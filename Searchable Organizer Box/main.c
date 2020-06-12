/******************************************************************************/
/*
	Project Name: Searchable Organizer Box
	author: Junsung Ahn
  email: junsung.ahn@digipen.edu
  DigiPen login: junsung.ahn
  Course: ECE220L
*/
/******************************************************************************/
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include "UART.h"
#include "SPI.h"
#include "LCD_SPI.h"
#include "LCD_UART.h"
#include "microSD.h"
#include "timer.h"
#include "Inputs.h"
#include "Modes.h"
#include "tm4c123gh6pm.h"
#include "Prototype.h"


#define MODE_SEARCH 0x10
#define MODE_EDIT 0x20


int main(void)
{
  // Arrays of characters which have maximum possible length
  char ModeSelection;
  int PastInputButton = ';';

  
  // Initialize UART: boud rate, bits, stop bit, parity, flow control
	UART0_Init();
  UART1_Init();  
  KeyPad_Switch_Init();

  SSI1_Init();	//Initialize SPI
  SSI0_Init();

  LCD_UART_Init();
  
  LCD_UART_OutString("SYSTEM START;", true);
  microSD_Init();
  LCD_UART_OutString(" -mSD:Addressing..;", true);
  unsigned long mSD_EmptyAddressStart = microSD_FindAvailableAddress();

  LCD_UART_Clear();
  PROTO_LED_Clear();
  
  // System loop
	while (1)
  {
    LCD_UART_OutString("<SELECT THE MODE>;", true);
    LCD_UART_OutString("TOP:    SEARCH;", true);
    LCD_UART_OutString("BOTTOM: EDIT;", true);
    ModeSelection = Input_Read(&PastInputButton);
    while (ModeSelection == ';')
    {
      ModeSelection = Input_Read(&PastInputButton);
      // Mode selection
      switch (ModeSelection)
      {
        case MODE_SEARCH:
        {
          Mode_SEARCH(mSD_EmptyAddressStart);
          break;
        }
        case MODE_EDIT :
        {
          Mode_EDIT(&mSD_EmptyAddressStart);
          break;
        }
        default: break;
      }
    }  
    
	} // End of the system loop
}


/*
  Connections 12/08
  - Tiva -     - Peripherals -
    PA2           Shift Register SRCLK
    PA3           Shift Register RCLK
    PA5           Shift Register SER
    PB1           LCD_Rx
    PD0           mSD_CLK 
    PD1           mSD_CS
    PD2           mSD_MISO
    PD3           mSD_MOSI
    PE1           KeyPad_Column01
    PE2           KeyPad_Column02
    PE3           KeyPad_Column03
    PE4           SW01
    PE5           SW02
    PC4           KeyPad_Row01
    PC5           KeyPad_Row02
    PC6           KeyPad_Row03
    PC7           KeyPad_Row04
*/
