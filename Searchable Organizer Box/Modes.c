#include "Modes.h"
#include "LCD_UART.h"
#include "Inputs.h"
#include "microSD.h"
#include "SPI.h"
#include "timer.h"
#include "Prototype.h"
#include <stdbool.h>

#define MODE_EXIT 0x00
#define BACKSPACE 0x10
#define ENTER 0x20

#define EDIT_PHASE_NAME 0x00
#define EDIT_PHASE_ROW 0x01
#define EDIT_PHASE_COLUMN 0x02
#define EDIT_PHASE_INVALID 0x03
#define EDIT_PHASE_ALREADY 0x04

#define SEARCH_PHASE_NAME 0x00
#define SEARCH_PHASE_NONEXIST 0x01

#define EXIT -1
#define DONE 0x1

void StoreCharInBuffer(char *_InputBuffer, int *_BufferCount, char _data)
{
  _InputBuffer[*_BufferCount] = _data;
  ++(*_BufferCount);
}



void StoreStringInBuffer(char *_InputBuffer, int *_BufferCount, char *_String)
{
  int i = 0;
  while (_String[i] != ';')
  {
    StoreCharInBuffer(_InputBuffer, _BufferCount, _String[i]);
    ++i;
  }
}



int Mode_EDIT_InputRec(char *_InputBuffer, int *_BufferCount, int *_EditPhase)
{
  LCD_UART_Clear();
  LCD_UART_OutString("<EDIT MODE>;", true);
  LCD_UART_OutString("#:EXIT/T:DEL/B:ENT;", true);
  
  switch (*_EditPhase)
  {
    case EDIT_PHASE_NAME:
    {
      LCD_UART_OutString("Enter Name;", true);
      StoreStringInBuffer(_InputBuffer, _BufferCount, "<N>;");
      
      break;
    }
    case EDIT_PHASE_ROW:
    {
      LCD_UART_OutString("Enter Row(0-7);", true);
      StoreStringInBuffer(_InputBuffer, _BufferCount, "<R>;");
      break;
    }
    case EDIT_PHASE_COLUMN:
    {
      LCD_UART_OutString("Enter Column(0-7);", true);
      StoreStringInBuffer(_InputBuffer, _BufferCount, "<C>;");
      break;
    }
    default: return EXIT;
  }
  
  LCD_UART_OutChar('>');

  char InputInstance = ';';
  int PastInputButton = 0;
  
  // Clear Input Buffer
  while (Input_Read(&PastInputButton) != ';');  
  
  while (1) // Input Loop
  {
    InputInstance = Input_Read(&PastInputButton);
    
    switch (InputInstance)
    {
      case ';': break; // Terminator
      case '#': // Exit
      {
        LCD_UART_Clear();
        return EXIT;
      }
      case BACKSPACE:
      {
        if ((*_BufferCount) > 0)
        {
          --(*_BufferCount);
          LCD_UART_BackSpace();
        }

        break;
      }
      case ENTER:
      {
        if (*_EditPhase == EDIT_PHASE_COLUMN)
        {
          // All required data stored
          StoreCharInBuffer(_InputBuffer, _BufferCount, ';');
          return DONE;
        }
        else
        {
          ++(*_EditPhase);
          return Mode_EDIT_InputRec(_InputBuffer, _BufferCount, _EditPhase);
          //break;// Go to store
        }

      }
      default: // Valid characters: Add to the buffer
      {
        StoreCharInBuffer(_InputBuffer, _BufferCount, InputInstance);
        
        //_InputBuffer[(*_BufferCount)] = InputInstance;
        //++(*_BufferCount);
          
        //if (InputInstance == )
        break;
      }
    }
  }
}



int Mode_SEARCH_InputRec(char *_InputBuffer, int *_BufferCount, int *_SearchPhase)
{
  LCD_UART_Clear();
  LCD_UART_OutString("<SEARCH MODE>;", true);
  LCD_UART_OutString("#:EXIT/T:DEL/B:ENT;", true);
  
  switch (*_SearchPhase)
  {
    case SEARCH_PHASE_NAME:
    {
      LCD_UART_OutString("Enter Name;", true);
      StoreStringInBuffer(_InputBuffer, _BufferCount, "<N>;");
      
      break;
    }
    default: return EXIT;
  }
  
  LCD_UART_OutChar('>');

  char InputInstance = ';';
  int PastInputButton = 0;
  
  // Clear Input Buffer
  while (Input_Read(&PastInputButton) != ';');  
  
  while (1) // Input Loop
  {
    InputInstance = Input_Read(&PastInputButton);
    
    switch (InputInstance)
    {
      case ';': break; // Terminator
      case '#': // Exit
      {
        LCD_UART_Clear();
        return EXIT;
      }
      case BACKSPACE:
      {
        if ((*_BufferCount) > 0)
        {
          --(*_BufferCount);
          LCD_UART_BackSpace();
        }

        break;
      }
      case ENTER:
      {
        // Store the Termiantor at the end of input
        StoreCharInBuffer(_InputBuffer, _BufferCount, ';');
        return DONE;
      }
      default: // Valid characters: Add to the buffer
      {
        StoreCharInBuffer(_InputBuffer, _BufferCount, InputInstance);
        break;
      }
    }
  }
}



void Mode_EDIT_Write_mSD(char *_InputBuffer, int _BufferCount, unsigned long *_mSD_CurrentAvailableAddress)
{
  microSD_Write_SingleBlock(_InputBuffer, _BufferCount, _mSD_CurrentAvailableAddress);
}


int Mode_CheckMatching(char *_InputName, unsigned char *_Data_mSD)
{
  int i = 3;
  
  // Until detects another '<'
  while ( (_Data_mSD[i] != '<') && (i < 50) )
  {
    // Compare one by one
    if (_InputName[i] != _Data_mSD[i])
    {
      return 0; // Any of chars is not matched
    }
    ++i;
  }
  
  if (i < 50)
  {
    return 1;
  }
  return 0;
}



int Mode_SEARCH_Find_mSD(char *_InputName, char *_ConfirmedData, unsigned long _mSD_CurrentAvailableAddress)
{
  int DataExist = 0;
  unsigned char DataFrom_mSD[50];
  unsigned long mSD_ReadStartAddress = 0x200;
  
  while (mSD_ReadStartAddress != _mSD_CurrentAvailableAddress)
  {
    DataExist = microSD_Read_SingleBlock(DataFrom_mSD, mSD_ReadStartAddress);
    
    // Only compare by the name
    // Index: 0 1 2 3...
    //        < N > S... < R > n < C > n
    if (DataExist != 0)
    {
      // Compare Input and the data from the mSD
      int Matched = Mode_CheckMatching(_InputName, DataFrom_mSD);
      
      if (Matched == 1)
      {
        // Copy the data to confirmed
        int j = 0;
        while (DataFrom_mSD[j] != ';')
        {
          _ConfirmedData[j] = DataFrom_mSD[j];
          ++j;
        }
        // Add terminator before done copying
        _ConfirmedData[j] = ';';
        return 1; // Get out from the loop
      }
    }
    mSD_ReadStartAddress += 512;
  }
  
  return 0;
}


void Mode_SEARCH_SendSearchResult(char *_InputBuffer, int _BufferCount)
{
  int i = 0;
  
  while (_InputBuffer[i] != ';')
  {
    SSI1_Write(_InputBuffer[i]);
    ++i;
  }
}



int Mode_EDIT(unsigned long *_mSD_CurrentAvailableAddress)
{
  int PastInputButton = 0;
  char InputBuffer[512];
  int BufferCount = 0;
  
  // Clear Input Buffer
  while (Input_Read(&PastInputButton) != ';');
  LCD_UART_Clear();
  //LCD_UART_OutString("<EDIT MODE>   #:EXIT;", true);
  //LCD_UART_OutString("Type Name;", true);
  //LCD_UART_OutChar('>');
  
  while (1) // Mode Loop
  {
    int EditPhase = 0;
    int RecResponse = Mode_EDIT_InputRec(InputBuffer, &BufferCount, &EditPhase);
    
    if (RecResponse == EXIT)
    {
      return EXIT;
    }
    
    if (RecResponse == DONE)
    {
      LCD_UART_Clear();
      LCD_UART_OutString("ENTERED>;", true);
      LCD_UART_OutDataInFormat(InputBuffer);
      
      int Dummy = ';';
      while(Input_Read(&Dummy) != 0x20);

      
      Mode_EDIT_Write_mSD(InputBuffer, BufferCount, _mSD_CurrentAvailableAddress);
      //LCD_UART_OutString(InputBuffer, false);
      
      // Store this data to mSD
      
    }
  }
}


void Mode_Search_ClearSearch(void)
{
  // Wait?
}



int Mode_SEARCH(unsigned long _mSD_CurrentAvailableAddress)
{
  int PastInputButton = 0;
  char InputBuffer[512];
  //char ReadBuffer[512];
  int BufferCount = 0;
  
  // Clear Input Buffer
  while (Input_Read(&PastInputButton) != ';');
  LCD_UART_Clear();
  
  while (1) // Mode Loop
  {
    int Dummy = ';';
    while(Input_Read(&Dummy) != ';'); // Clear Buffer
    
    int SearchPhase = 0;
    int Response = Mode_SEARCH_InputRec(InputBuffer, &BufferCount, &SearchPhase);

    if (Response == EXIT)
    {
      return EXIT;
    }

    if (Response == DONE)
    {
      LCD_UART_Clear();
      LCD_UART_OutString(InputBuffer, true);
      LCD_UART_OutString("SEARCHING...;", false);
      char Confirmed_[50]; // Each sector is 512-bytes
      int DoesExist = Mode_SEARCH_Find_mSD(InputBuffer, Confirmed_, _mSD_CurrentAvailableAddress);
      
      LCD_UART_Clear();
      
      if (DoesExist == 0)
      {  
        LCD_UART_OutString(InputBuffer, true);
        LCD_UART_OutString("Not Exists   #:EXIT;", true);
      }
      else
      {
        Dummy = ';';
        while(Input_Read(&Dummy) != ';'); // Clear Buffer
        LCD_UART_OutString("Found;", true);
        LCD_UART_OutDataInFormat(Confirmed_);
        LCD_UART_OutString("        #:EXIT;", false);
        
        // Send the data
        PROTO_SendDataToShiftRegister(Confirmed_);
      }
      
      // Instead of waiting, wait the response
      Dummy = ';';
      while(Input_Read(&Dummy) != '#');
        
      // Clear ShiftRegister
      PROTO_LED_Clear();
    }
    BufferCount = 0;
  }
}
