#include "Prototype.h"
#include "SPI.h"
#include "tm4c123gh6pm.h" // Registers
#include <stdint.h> // uint32_t

// bit  7     6     5     4     3     2     1     0        
// pos  R2C1  R2C0  R1C2  R1C1  R1C0  R0C2  R0C1  R0C0

char GetLED_bit(char Row, char Column)
{
  char LEDbitData;
  switch (Row)
  {
    case '0':
    {
      switch (Column)
      {
        case '0':
        {
          LEDbitData = 0x01;
          break;
        }
        case '1':
        {
          LEDbitData = 0x02;
          break;
        }
        case '2':
        {
          LEDbitData = 0x04;
          break;
        }
        default: break;
      }
      break;
    }
    case '1':
    {
      switch (Column)
      {
        case '0':
        {
          LEDbitData = 0x08;
          break;
        }
        case '1':
        {
          LEDbitData = 0x10;
          break;
        }
        case '2':
        {
          LEDbitData = 0x20;
          break;
        }
        default: break;
      }
      break;
    }
    case '2':
    {
      switch (Column)
      {
        case '0':
        {
          LEDbitData = 0x40;
          break;
        }
        case '1':
        {
          LEDbitData = 0x80;
          break;
        }
        default: break;
      }
      break;
    }
    default: break;
  }
  return LEDbitData;
}


void GetRowColumnFromArray(char *_ConfirmedArray, char *_Row, char *_Column)
{
  int i = 3;
  while (_ConfirmedArray[i] != '<')
  {
    ++i;
  }
  
  // <R>
  i += 3;
  (*_Row) = _ConfirmedArray[i];
  
  while (_ConfirmedArray[i] != '<')
  {
    ++i;
  }
  
  // <C>
  i += 3;
  (*_Column) = _ConfirmedArray[i];
}


void SendDataToShiftRegister(char _LEDValue)
{
  // Send
  SSI0_Out(_LEDValue);
}


void PROTO_LED_Clear(void)
{
  SendDataToShiftRegister(0x00);
}




void PROTO_Enable_microSD(void);



void PROTO_SendDataToShiftRegister(char *_ConfirmedArray)
{
  // Extract the value of row and column
  char RowChar;
  char ColumnChar;
  char LED_Value;
  
  GetRowColumnFromArray(_ConfirmedArray, &RowChar, &ColumnChar);
  LED_Value = GetLED_bit(RowChar, ColumnChar);
  
  SendDataToShiftRegister(LED_Value);
}
