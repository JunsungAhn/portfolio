/******************************************************************************/
/*
	Project Name: microSD.c
	author: Javier Mart?ez Arrieta
  Modified/Added: Junsung Ahn
  email: junsung.ahn@digipen.edu
  DigiPen login: junsung.ahn
  Course: ECE220L

 *  Copyright (C) 2016 Javier Mart?ez Arrieta
 *
 *  This project is licensed under Creative Commons Attribution-Non Commercial-Share Alike 4.0 International (CC BY-NC-SA 4.0). According to this license you are free to:
 *  Share ?copy and redistribute the material in any medium or format.
 *  Adapt ?remix, transform, and build upon the material.
 *  The licensor cannot revoke these freedoms as long as you follow the license terms.
 *	Complete information about this license can be found at: https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode


 Part of this example (partially modified functions rcvr_datablock, rcvr_spi_m, disk_timerproc, Timer5A_Handler, Timer5_Init, is_ready, send_command and part of initialize_sd) accompanies the books
   Embedded Systems: Real-Time Operating Systems for ARM Cortex-M Microcontrollers, Volume 3,
   ISBN: 978-1466468863, Jonathan Valvano, copyright (c) 2013

   Volume 3, Program 6.3, section 6.6   "Embedded Systems: Real Time Interfacing to Arm Cortex M Microcontrollers",
   ISBN: 978-1463590154, Jonathan Valvano, copyright (c) 2013

 Copyright 2013 by Jonathan W. Valvano, valvano@mail.utexas.edu
    You may use, edit, run or distribute this file (concretely the functions mentioned)
    as long as the above copyright notice remains
 THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
 OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
 VALVANO SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL,
 OR CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
 For more information about my classes, my research, and my books, see
 http://users.ece.utexas.edu/~valvano/
*/
/******************************************************************************/
#include "microSD.h"
#include "tm4c123gh6pm.h" // Registers
#include "SPI.h" // SSI1_Send
#include "UART.h"
#include "LCD_UART.h"
#include "timer.h"
#include <stdint.h>
#include <stdbool.h>


/* Definitions for MMC/SDC commands */
#define CMD0     0x40    	/* GO_IDLE_STATE */
#define CMD1     0x41    	/* SEND_OP_COND */
#define CMD8     0x48    	/* SEND_IF_COND */
#define CMD9     0x49    	/* SEND_CSD */
#define CMD10    0x4A   	/* SEND_CID */
#define CMD12    0x4C    	/* STOP_TRANSMISSION */
#define CMD13    0x4D
#define CMD16    0x50    	/* SET_BLOCKLEN */
#define CMD17    0x51    	/* READ_SINGLE_BLOCK */
#define CMD18    0x52    	/* READ_MULTIPLE_BLOCK */
#define CMD23    0x57    	/* SET_BLOCK_COUNT */
#define CMD24    0x58    	/* WRITE_BLOCK */
#define CMD25    0x59    	/* WRITE_MULTIPLE_BLOCK */
#define CMD41    0x69    	/* SEND_OP_COND (ACMD) */
#define CMD55    0x77    	/* APP_CMD */
#define CMD58    0x7A    	/* READ_OCR */


// PD0: CLK 
// PD1: CS
// PD2: MISO
// PD3: MOSI

// Global Variables
unsigned long lba_begin_address,number_of_sectors,lba_addr,cluster_start,file_size,cluster_begin_lba,fat_begin_lba,sectors_per_fat,root_dir_first_cluster;
unsigned long previous_cluster=0,cluster_dir=0;
unsigned char sectors_per_cluster;
char cuenta=0,current_count=0;
char finish=0;
int row=0,column=0,number=0;


typedef struct
{
	char hour;
	char minute;
	unsigned int year;
	char month;
	char day;
	long size;
	long first_cluster;
}tfile_info;

typedef struct
{
	tfile_info info;
	unsigned char file_dir_name[255];
}tfile_name;

typedef struct
{
	tfile_name name;
	enum type_of_file
	{
		IS_NONE,
		IS_DIR,
		IS_FILE
	}type;
}tfile_dir;

tfile_dir file_dir[40];


void microSD_Init(void)
{
  //////////////////////////////////////// MILESTONE
  LCD_UART_OutString(" -mSD:Initializing;", true);
  //////////////////////////////////////// MILESTONE  
  
  
  unsigned char Response;
  unsigned char SDtype;
  
  // Wait for one millisecond at least
  Wait_ms(2);
  
  // Disable alt function of PD1(CS), PD3(MOSI)
  GPIO_PORTD_AFSEL_R &= ~0xA;
  
  // PD1, PD3 are for outputs
  GPIO_PORTD_DIR_R |= 0xA;
  
  // Clear before assigning any logical value
  GPIO_PORTD_DATA_R &= ~0xFF;

  // Set PD1(CS), PD3(MOSI) as logical high
  GPIO_PORTD_DATA_R |= 0xA;
  
  // Toggle Clock for at least 74 cycles(Wait until 74 cycle): 400kHz
  int wait;
  for (wait = 0; wait < 10; ++wait)
  {
    SSI1_Write(0xFF); // One Writing has 8 cycles
  }

  // After the cycles, set PD1(CS) 0
  GPIO_PORTD_DATA_R &= ~0x2;
  
  // Re-enable alt function of PD3
  GPIO_PORTD_AFSEL_R |= 0x8;
  
  // Send the CMD0 command
  Response = microSD_SendCommand(CMD0, 0);
  
  if (Response == 0x01)
  {
    LCD_UART_OutString("mSD: IDLE.;", true);
    /////////////////////////////////
    // Initialization timeout of 1000 msec */
    Response = microSD_SendCommand(CMD8, 0x1AA);
    
    if (Response == 0x01)
    {
      // SDC Ver 2+
      int i;
      unsigned char SDspec[4];
      for (i = 0; i < 4; ++i)
      {
        SDspec[i] = SSI1_Read();
      }
      
      // Check the voltage([2]) and check pattern([3]) 
      if (SDspec[2] == 0x01 && SDspec[3] == 0xAA)
      {
        // Need to send ACMD41, instead of CMD1
        // ACMD41 = sequence of CMD55 and CMD41
        
        // Need timeout: 
        int timeout = 1000;
        while(timeout--)
        {
          unsigned char ResponseCMD55 = microSD_SendCommand(CMD55, 0);
          unsigned char ResponseCMD41 = microSD_SendCommand(CMD41, (1UL << 30) );
          if ((ResponseCMD55 <= 1 && ResponseCMD41 == 0))
          {
            //LCD_UART_OutString("microSD: Initialization done. Generic Read/Write available.;");
            LCD_UART_OutString("mSD: Ready R/W.;", true);
            break; // Idle State bit cleard, now SD card is ready to do generic read/write
          }
        }
        unsigned char ResponseCMD58 = microSD_SendCommand(CMD58, 0);
        if ( timeout && (ResponseCMD58 == 0x00) )
        {
          for (i = 0; i < 4; ++i)
          {
            SDspec[i] = SSI1_Read();
            SDtype = (SDspec[0] & 0x40) ? 6 : 2;
          }
        }        
      }
    }
  }
}


unsigned char microSD_SendCommand(unsigned char _CMD, unsigned long _Argument)
{
  unsigned char Response_ = 0x00;
  unsigned char ResetResponse = 0x00;
  int ResetCommandCounter = 0;
  unsigned long argument = _Argument;
  unsigned char CRCwithStopBit = 0;
    
  switch (_CMD)
  {
    case CMD0: // Software Reset
    {
      CRCwithStopBit = 0x95;
      ResetResponse = 0x01;
      ResetCommandCounter = 10;
      break;
    }
    case CMD1: // Initiate initialization process
    {
      // Read the current response
      CRCwithStopBit = 0x00;
      break;
    }
    case CMD8: // SEND_IF_COND
    {
      CRCwithStopBit = 0x87;
      break;
    }
    case CMD13:
    {
      CRCwithStopBit = 0xFF;
      break;
    }
    case CMD16:
    {
      CRCwithStopBit = 0xFF;
      break;
    }
    case CMD17:
    {
      // Nothing need to be modified from the default
      break;
    }
    case CMD41:
    {
      CRCwithStopBit = 0;
      break;
    }
    case CMD55:
    {
      CRCwithStopBit = 0;
      break;
    }
    case CMD58: // READ_OCR
    {
      CRCwithStopBit = 0x0F;
      break;      
    }
    default: break;
  }  

  do
  {
    // Send the command with start bit : 2bit + 6 bit of command data
    SSI1_Write(_CMD);

    // Send the argument: 39th~32th(8 bits, 1 byte)
    SSI1_Write((unsigned char)(argument >> 24));  // Argument [31..24]
    SSI1_Write((unsigned char)(argument >> 16));  // Argument [23..16]
    SSI1_Write((unsigned char)(argument >> 8));   // Argument [15..8]
    SSI1_Write((unsigned char)argument);          // Argument [7..0]
      
    // Send CRC with stop bit: 8 bits + 1 bit
    SSI1_Write(CRCwithStopBit);
    
    // Dummy bytes
    SSI1_Write(0xFF);
    
    // Read the response for 16 cycles (= 2 reading calls)
    int RepeatReading = 2;
    do
    {
      Response_ = SSI1_Read();
      if(Response_ == ResetResponse)
      {
        ResetResponse = 0x00;
        break;
      }
    } while((Response_ & 0x80) && --RepeatReading);
  } while (ResetResponse && (--ResetCommandCounter)); // Only if the command is CMD0, loop

  return Response_;
}




/*
 * Verify if file system is FAT32
 */
void microSD_read_first_sector(void)
{
	unsigned char buffer[512];
  unsigned char ResponseCMD17 = 0;
  int TimeOut = 0;
  do
  {
    ResponseCMD17 = microSD_SendCommand(CMD17, 0x00000000);
    ++TimeOut;
  } while(ResponseCMD17 != 0x00 && TimeOut != 1000);
  
	//if (microSD_SendCommand(CMD17, 0x00000000) == 0)
	//{
		microSD_rcvr_datablock(buffer, 512);
	//}
	if((buffer[450] == 0x0B || buffer[450] == 0x0C) && buffer[510] == 0x55 && buffer[511] == 0xAA)
	{
		LCD_UART_OutString("mSD: FAT32;", true);
	}
	else{
		LCD_UART_OutString("msd: Error FAT32;", true);
	}
	lba_begin_address=(unsigned long)buffer[454]+(((unsigned long)buffer[455])<<8)+(((unsigned long)buffer[456])<<16)+(((unsigned long)buffer[457])<<24);
	number_of_sectors=(unsigned long)buffer[458]+(((unsigned long)buffer[459])<<8)+(((unsigned long)buffer[460])<<16)+(((unsigned long)buffer[461])<<24);
}


void microSD_read_disk_data(void)
{
	unsigned char buffer[512];
	if (microSD_SendCommand(CMD17, lba_begin_address) == 0)
	{
		microSD_rcvr_datablock(buffer, 512);
	}
	fat_begin_lba = lba_begin_address + (unsigned long)buffer[14] + (((unsigned long)buffer[15])<<8); //Partition_LBA_BEGIN + Number of reserved sectors
	sectors_per_fat=((unsigned long)buffer[36]+(((unsigned long)buffer[37])<<8)+(((unsigned long)buffer[38])<<16)+(((unsigned long)buffer[39])<<24));
	cluster_begin_lba = fat_begin_lba + ((unsigned long)buffer[16] * ((unsigned long)buffer[36]+(((unsigned long)buffer[37])<<8)+(((unsigned long)buffer[38])<<16)+(((unsigned long)buffer[39])<<24)));//Partition_LBA_Begin + Number_of_Reserved_Sectors + (Number_of_FATs * Sectors_Per_FAT);
	sectors_per_cluster = (unsigned char) buffer[13];//BPB_SecPerClus;
	root_dir_first_cluster = (unsigned long)buffer[44]+(((unsigned long)buffer[45])<<8)+(((unsigned long)buffer[46])<<16)+(((unsigned long)buffer[47])<<24);//BPB_RootClus;
	lba_addr = cluster_begin_lba + ((root_dir_first_cluster/*cluster_number*/ - 2) * (unsigned long)sectors_per_cluster);
}


long microSD_get_root_dir_first_cluster(void)
{
	return root_dir_first_cluster;
}



long microSD_list_dirs_and_files(long next_cluster,enum name_type name, enum get_subdirs subdirs)
{
	unsigned char buffer[512];
	int position=0,filename_position=0;
	int n=0;
	unsigned long count=10,sector=0,sectors_to_be_read=sectors_per_cluster;//Calculate this
	long address=cluster_begin_lba + ((next_cluster - 2) * (unsigned long)sectors_per_cluster);
	if(cluster_dir == next_cluster)
	{
		cluster_dir=0;
	}
	if(microSD_SendCommand(CMD18,address)==0)
	{
		do
		{
			microSD_rcvr_datablock(buffer, 512);
			do
			{
				if(position<512 && filename_position<255 /*&& position%32==0 && buffer[position]!=0x00 && buffer[position]!=0x05 && buffer[position]!=0x00*/)
				{//Long filename text - 11th byte is 0x0F
					if(position%32==0)
					{//Check if file has a long filename text, normal record with short filename, unused or end of a directory
						if(buffer[position]==0x00 || buffer[position]==0x2E)
						{//End of directory
							position=position+32;
						}
						else
						{
							if(buffer[position]==0xE5)
							{//Deleted file or directory that is maintained until overriden
								position=position+32;
							}
							else
							{
								if(buffer[position+11]==0x0F && name==LONG_NAME)//Review this
								{//Long filename text (to be ignored?)
									//Get the number of groups of 32 bytes corresponding to the name of file or directory
									short keep_counting=1,do_not_continue=0,is_dir=0;
									int pos=position+32;
									do
									{
										if(buffer[pos+11]==0x0F)
										{
											pos=pos+32;
										}
										else
										{
											//Is it hidden, operating system or Volume ID?
											if((buffer[pos+11]&0x0E)>0x00)
											{
												do_not_continue=1;
											}
											else
											{
												if((buffer[pos+11]&0x10)==0x10)
												{
													is_dir=1;
												}
											}
											keep_counting=0;
										}
									}while(keep_counting==1);
									if(do_not_continue==0)
									{
										int num_blocks=(pos-position)/32;
										int current_block=0;
										if(is_dir)
										{
											file_dir[cuenta].type=IS_DIR;
										}
										else
										{
											file_dir[cuenta].type=IS_FILE;
										}
										//Get sequence number
										do
										{
											int seq_num=buffer[position]&0x1F;
											filename_position=32*(seq_num-1);
											position++;
											for(n=1;n<32;n++)
											{
												if((n<11 || n>13) && n!=26)
												{
													file_dir[cuenta].name.file_dir_name[filename_position+n]=buffer[position];
												}
												position++;
											}
											current_block++;
											num_blocks--;
										}while(num_blocks>0);
										microSD_clean_name();
										int time=(((int)(buffer[position/*-11*/+23]))<<8) + ((int)buffer[position/*-11*/+22]);
										int date=(((int)(buffer[position/*-11*/+25]))<<8) + ((int)buffer[position/*-11*/+24]);
										file_dir[cuenta].name.info.minute=(time&0x07E0)>>5;
										file_dir[cuenta].name.info.hour=(time&0xF800)>>11;
										file_dir[cuenta].name.info.month=((date&0x01E0)>>5);
										file_dir[cuenta].name.info.year=((date&0xFE00)>>9)+1980;
										file_dir[cuenta].name.info.day=date&0x001F;
										file_dir[cuenta].name.info.size=(long)((buffer[position/*-11*/+31])<<24)+(long)((buffer[position/*-11*/+30])<<16)+(long)((buffer[position/*-11*/+29])<<8)+(long)(buffer[position/*-11*/+28]);
										file_dir[cuenta].name.info.first_cluster=(long)((buffer[position/*-11*/+21])<<24)+(long)((buffer[position/*-11*/+20])<<16)+(long)((buffer[position/*-11*/+27])<<8)+(long)(buffer[position/*-11*/+26]);
										position=position+32;
									}
									else
									{
										position=position+(32*(pos/32));
									}
								}
								else
								{//Normal record with short filename
									//Is it a directory (not system's)?
									if((buffer[position+11]&0x30)==0x10 && (buffer[position+11]&0x0E)==0x00)
									{
										file_dir[cuenta].type=IS_DIR;
										for(n=0;n<11;n++)
										{
											file_dir[cuenta].name.file_dir_name[n]=buffer[position];
											position++;
										}
										int time=(((int)(buffer[position-11+23]))<<8) + ((int)buffer[position-11+22]);
										int date=(((int)(buffer[position-11+25]))<<8) + ((int)buffer[position-11+24]);
										file_dir[cuenta].name.info.minute=(time&0x07E0)>>5;
										file_dir[cuenta].name.info.hour=(time&0xF800)>>11;
										file_dir[cuenta].name.info.month=((date&0x01E0)>>5);
										file_dir[cuenta].name.info.year=((date&0xFE00)>>9)+1980;
										file_dir[cuenta].name.info.day=date&0x001F;
										file_dir[cuenta].name.info.size=(long)((buffer[position-11+31])<<24)+(long)((buffer[position-11+30])<<16)+(long)((buffer[position-11+29])<<8)+(long)(buffer[position-11+28]);
										file_dir[cuenta].name.info.first_cluster=(long)((buffer[position-11+21])<<24)+(long)((buffer[position-11+20])<<16)+(long)((buffer[position-11+27])<<8)+(long)(buffer[position-11+26]);
									}
									else
									{
										if(((buffer[position+11])&0x30)==0x20 && ((buffer[position+11])&0x0E)==0x00)
										{
											file_dir[cuenta].type=IS_FILE;
											for(n=0;n<11;n++)
											{
												file_dir[cuenta].name.file_dir_name[n]=buffer[position];
												position++;
											}
											int time=(((int)(buffer[position-11+23]))<<8) + ((int)buffer[position-11+22]);
											int date=(((int)(buffer[position-11+25]))<<8) + ((int)buffer[position-11+24]);
											file_dir[cuenta].name.info.minute=(time&0x07E0)>>5;
											file_dir[cuenta].name.info.hour=(time&0xF800)>>11;
											file_dir[cuenta].name.info.month=((date&0x01E0)>>5);
											file_dir[cuenta].name.info.year=((date&0xFE00)>>9)+1980;
											file_dir[cuenta].name.info.day=date&0x001F;
											file_dir[cuenta].name.info.size=(long)((buffer[position-11+31])<<24)+(long)((buffer[position-11+30])<<16)+(long)((buffer[position-11+29])<<8)+(long)(buffer[position-11+28]);
											file_dir[cuenta].name.info.first_cluster=(long)((buffer[position-11+21])<<24)+(long)((buffer[position-11+20])<<16)+(long)((buffer[position-11+27])<<8)+(long)(buffer[position-11+26]);
											//files++;
										}
										else
										{
											if(position==512)
											{
												//position=0;
											}
											else
											{
												position++;
											}
										}
									}
								}
							}
						}
						microSD_clean_name();
						if(file_dir[cuenta].name.file_dir_name[0]!=0xFF && file_dir[cuenta].name.file_dir_name[0]!=0x00)
						{
              LCD_UART_OutString("msD: Read ;", false);
							if(file_dir[cuenta].type==IS_DIR)
							{
                LCD_UART_OutString("DIR;", true);
								//printf("%d. (DIR)\t\t", number);
							}
							else
							{
                LCD_UART_OutString("FILE;", true);
								//printf("%d. (FILE)\t\t", number);
							}
							int i;
              char filename[100];
							for(i=0;i<255;i++)
							{
								if(file_dir[cuenta].name.file_dir_name[i]!=0x00)
								{
                  filename[i] = file_dir[cuenta].name.file_dir_name[i];
                  //char what = file_dir[cuenta].name.file_dir_name[i];
                  //UART0_OutChar(file_dir[cuenta].name.file_dir_name[i]);
                  //UART1_OutChar(file_dir[cuenta].name.file_dir_name[i]);
                  //printf("%c",file_dir[cuenta].name.file_dir_name[i]);
								}
                else
                {
                  if (i < 100)
                  {
                    filename[i] = ';';
                  }
                }
							}
              LCD_UART_OutString("mSD: ;", false);
              LCD_UART_OutString(filename, true);
							//printf("\t\t");
							//printf("%d/%d/%d	%d:%d\n",file_dir[cuenta].name.info.day,file_dir[cuenta].name.info.month,file_dir[cuenta].name.info.year,file_dir[cuenta].name.info.hour,file_dir[cuenta].name.info.minute);
							cuenta++;
							number++;
						}
					}
					else
					{
						if(position==512)
						{
							//position=0;
						}
						else
						{
							position++;
						}
					}
				}
				else
				{
					if(position==512)
					{
						count--;
					}
					else
					{
						position++;
					}
				}
			} while (position<512);
			position=0;
			sectors_to_be_read--;
		}while(sectors_to_be_read>0);
	}
	microSD_SendCommand(CMD12,0);
	sectors_to_be_read=(next_cluster*4)/512;
	if(microSD_SendCommand(CMD18,fat_begin_lba)==0)
	{
		do
		{
			sector++;
			microSD_rcvr_datablock(buffer, 512);
		}while(sector<=sectors_to_be_read);
		sector--;
	}
	microSD_SendCommand(CMD12,0);
	next_cluster=(((long)(buffer[((next_cluster*4)-(sector*512))+3]))<<24)+(((long)(buffer[((next_cluster*4)-(sector*512))+2]))<<16)+(((long)(buffer[((next_cluster*4)-(sector*512))+1]))<<8)+(long)(buffer[((next_cluster*4)-(sector*512))]);
	if((next_cluster==0x0FFFFFFF || next_cluster==0xFFFFFFFF) && current_count<40 && subdirs==GET_SUBDIRS)
	{
		while(current_count<40&&file_dir[current_count].type!=IS_DIR)
		{
			current_count++;
		}
		if(current_count<40 && file_dir[current_count].type==IS_DIR)
		{
			//printf("Content of ");
      LCD_UART_OutString("mSD: Content of ;", false);
			int i;
			for(i=0;i<255;i++)
			{
				if(file_dir[current_count].name.file_dir_name[i]!=0x00)
				{
					//printf("%c",file_dir[current_count].name.file_dir_name[i]);
				}
			}
			next_cluster=file_dir[current_count].name.info.first_cluster;
			current_count++;
			//printf("\n\t");
		}
	}
	if(current_count==40)
	{
		number=0;
		next_cluster=0x0FFFFFFF;
	}
	return next_cluster;
}



/*
 * Removes non ascii characters
 * Note: It must be checked if it removes characters, for example, with accents
 */
void microSD_clean_name(void)
{
	int j,k;
	for (j = 0; j < 255; j++)
	{
		if(file_dir[cuenta].name.file_dir_name[j]<0x20 || file_dir[cuenta].name.file_dir_name[j]>0x7E)
		{
			k=j;
			do
			{
				k++;
			}while(k<255 && (file_dir[cuenta].name.file_dir_name[k]<0x20 || file_dir[cuenta].name.file_dir_name[k]>0x7E));
			file_dir[cuenta].name.file_dir_name[j]=file_dir[cuenta].name.file_dir_name[k];
			file_dir[cuenta].name.file_dir_name[k]=0x00;
		}
	}
}

/*
 * Receives a block from a read of an SD card
 */
unsigned int microSD_rcvr_datablock(unsigned char *buff, unsigned int btr)
{ 
  /* Byte count (must be even number) */
  unsigned char token;
  int timeout = 1000;
  do
  {                            /* Wait for data packet in timeout of 100ms */
    token = SSI1_Read();
  } while ((token == 0xFF) && --timeout);
 if(token != 0xFE) return 0;    /* If not valid data token, retutn with error */

 do {                            /* Receive the data block into buffer */
   microSD_rcvr_spi_m(buff++);
   microSD_rcvr_spi_m(buff++);
 } while (btr -= 2);
 SSI1_Write(0xFF);                        /* Discard CRC */
 SSI1_Write(0xFF);

 return 1;                    /* Return with success */
}


void microSD_rcvr_spi_m(unsigned char *dst)
{
 *dst = SSI1_Read();
}



void microSD_Write_SingleBlock(char *_Buffer, int _BufferCount, unsigned long *_mSD_CurrentAvailableAddress)
{
  //unsigned long WritingAddress = 0x00 + 512;
  unsigned char mSD_Response;
  int i = 0;
  int Counter_WaitBusy = 0;
  int AddressValidResponse = 0;
  
  // Check the given block is valid
  while (AddressValidResponse == 0)
  {
    AddressValidResponse = microSD_CheckAddressValid(*_mSD_CurrentAvailableAddress);
    if (AddressValidResponse == 1)
    {
      break;
    }
    else
    {
      (*_mSD_CurrentAvailableAddress) += 512;
    }
  }
  
  // Dummy bytes
  SSI1_Write(0xFF);  
  
  do
  {
    // Set the block size of the write
    mSD_Response = microSD_SendCommand(CMD16, 0x00000200);
    ++Counter_WaitBusy;
  } while( (mSD_Response != 0x00) && (Counter_WaitBusy < 0xFFFF) );
  
   
  Counter_WaitBusy = 0;
  // Go to the first empty cluster
  do
  {
    mSD_Response = microSD_SendCommand(CMD24, (*_mSD_CurrentAvailableAddress));    
  } while(mSD_Response != 0x00 && (Counter_WaitBusy < 0xFFFF) );
  /////////////////////////////
  // CMD24 Accepted  
  
  // Dummy bytes
  SSI1_Write(0xFF);
  
  SSI1_Write(0xFE); // Start token
  
  for (i = 0; i < 100; ++i)
  {
    char data = _Buffer[i];
    SSI1_Write(data);
    if (_Buffer[i] == ';')
    {
      break;
    }
  }
  
  // Dummies
  SSI1_Write(0xFF);
  SSI1_Write(0xFF);
  
  mSD_Response = SSI1_Read();
  
  if ( (mSD_Response & 0x05) != 0x05)
  {
    return;
  }
  
  mSD_Response = microSD_SendCommand(CMD13, 0);
  
  do
  {
    mSD_Response = SSI1_Read();
    ++Counter_WaitBusy;
  } while( (mSD_Response != 0xFF) && (Counter_WaitBusy < 0xFFFF) );
  
  if (Counter_WaitBusy >= 0xFFFF) // timeout
  {
    return;
  }
  
  
  // Writing Done Successfully
  (*_mSD_CurrentAvailableAddress) += 512;
  
  return;
}



int microSD_Read_SingleBlock(unsigned char* _Data_mSD, unsigned long _mSD_Address)
{
  unsigned char mSD_Response;
  int Counter_WaitBusy = 0;
  
  // Dummy bytes
  SSI1_Write(0xFF);  
  
  do
  {
    // Set the block size of the write
    mSD_Response = microSD_SendCommand(CMD16, 0x00000200);
    ++Counter_WaitBusy;
  } while( (mSD_Response != 0x00) && (Counter_WaitBusy < 0xFFFF) );  
  
  do
  {
    // Command READ, Starting Address
    mSD_Response = microSD_SendCommand(CMD17, _mSD_Address);
    ++Counter_WaitBusy;
  } while( (mSD_Response != 0x00) && (Counter_WaitBusy < 0xFFFF) );
  
  if (Counter_WaitBusy == 0xFFFF)
  {
    // This address is not valid
    return 0;
  }
  
  
  Counter_WaitBusy = 0;
  do
  {
    // Wait until the mSD is ready
    mSD_Response = SSI1_Read();
    ++Counter_WaitBusy;
  } while( (mSD_Response != 0xFE) && (Counter_WaitBusy < 0xFFFF) );
  
  //////////////// Read start
  int i = 0;
  for (i = 0; i < 50; ++i)
  {
    unsigned char data = SSI1_Read();
    _Data_mSD[i] = data;
    if (data == ';')
    {
      break;
    }
  }
  
  // Send dummies
  SSI1_Write(0xFF);
  SSI1_Write(0xFF);
  
  return 1;
}


int microSD_CheckAddressValid(unsigned long _mSD_Address)
{
  unsigned char Data_mSD[50];

  microSD_Read_SingleBlock(Data_mSD, _mSD_Address);
  if (Data_mSD[0] == '<')
  {
    return 0; // Already written
  }
  else
  {
    return 1; // Empty
  }
}


unsigned long microSD_FindAvailableAddress(void)
{
  unsigned long DefaultStartingAddress = 0x200;
  int Response = 0;
  
  while (Response == 0)
  {
    Response = microSD_CheckAddressValid(DefaultStartingAddress);
    if (Response == 1)
    {
      return DefaultStartingAddress;
    }
    else
    {
      DefaultStartingAddress += 512;
    }
  }
  
  return 0;
}

