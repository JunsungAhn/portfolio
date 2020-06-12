/******************************************************************************
*******************************************************************************
  ECE 270 –Fall2019
  
  - author:   Junsung Ahn
  - filename: Kernel HAL.c
  - Description: Definitions of HAL functions
  - Homework #: 7

  Copyright DigiPen (USA) Corporation
  All Rights Reserved
*******************************************************************************
******************************************************************************/

/******************************************************************************
*******************************************************************************
  References:

  [1] RM0090 Reference manual 
  STM32F405/415, STM32F407/417, STM32F427/437 and STM32F429/439 
    advanced ARM®-based 32-bit MCUs

  [2] UM1670 User manual
  Discovery kit with STM32F429ZI MCU

  [3] STM32F427xx/STM32F429xx Datasheet
  ARM Cortex-M4 32b MCU+FPU, 225DMIPS, up to 2MB Flash/256+4KB RAM, USB
    OTG HS/FS, Ethernet, 17 TIMs, 3 ADCs, 20 comm. interfaces, camera & LCD-TFT

  [4] PM0214 Programming manual
  STM32F3, STM32F4 and STM32L4 Series
    Cortex®-M4 programming manual

*******************************************************************************
******************************************************************************/

/*
        This code provides the Hardware Abstraction Layer (HAL) for the
    kernel.  This HAL only supports the STM32F429ZI microcontroller. 
*/

/******************************************************************************
*******************************************************************************
    Includes
*******************************************************************************
******************************************************************************/
#include 	"Kernel HAL.h"
#include 	"stm32f429xx.h"

/******************************************************************************
*******************************************************************************
    Definitions
*******************************************************************************
******************************************************************************/
#define   UINT32_ALL_ON       0xFFFFFFFF
#define   POS_07              0x07
#define   POS_13              0x0D
#define   POS_14              0x0E
#define   POS_16              0x10
#define   POS_17              0x11
#define   POS_18              0x12
#define   POS_19              0x13
#define   POS_26              0x1A
#define   POS_27              0x1B
#define   POS_28              0x1C
#define   POS_29              0x1D
#define   BIT_00              0x01
#define   BIT_01              0x02
#define   BIT_02              0x04
#define   BIT_03              0x08
#define   BIT_04              (0x01<<4)
#define   BIT_05              (0x01<<5)
#define   BIT_06              (0x01<<6)
#define   BIT_07              (0x01<<POS_07)
#define   BIT_08              (0x01<<8)
#define   BIT_09              (0x01<<9)
#define   BIT_13              (0x01<<POS_13)
#define   BIT_14              (0x01<<POS_14)
#define   BIT_16              (0x01<<POS_16)
#define   BIT_17              (0x01<<POS_17)
#define   BIT_18              (0x01<<POS_18)
#define   BIT_19              (0x01<<POS_19)
#define   BIT_26              (0x01<<POS_26)
#define   BIT_27              (0x01<<POS_27)
#define   BIT_28              (0x01<<POS_28) 
#define   BIT_29              (0x01<<POS_29)
#define   POS_GPIO_BSRR_CLEAR      0x10
#define   ONE_MS        0x3E80 // 16000
#define   ONE_SEC       0x3E8  // 1000  
#define   TIM6_IRQ      TIM6_DAC_IRQn // [1] table 62 (STM32F42xxx version)


// Optional definitions not required to produce working code
#ifndef			MAX_WAIT
	#define		BON(X)			|=(X)
	#define		BOFF(X)			&=~(X)
	#define		BTOG(X)			^=(X)
	#define		MAX_WAIT		0xFFFF
#endif		//	MAX_WAIT

/******************************************************************************
*******************************************************************************
    Prototypes
*******************************************************************************
******************************************************************************/

/******************************************************************************
*******************************************************************************
    Declarations & Types
*******************************************************************************
******************************************************************************/

/******************************************************************************
*******************************************************************************
    Helper Functions
*******************************************************************************
******************************************************************************/

/******************************************************************************
    OSp_InitGPIOG
		
      The clock to the PORTG module is enabled and the two pins 
    attached to the Red/Green LEDs have their digital outputs enabled. 
******************************************************************************/
unsigned int
OSp_InitGPIOG (void) {
    //   /
    // \/ pt:
    //    Import your code from Coding Assignment #02

    volatile unsigned int wait = MAX_WAIT;

    // Identify which pin/port connects to the Green/Blue/Red user LED
    // Enable the system clock for the PORTG peripheral
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOGEN;

    // Wait for the system clock to stabilize
    for (wait = 0x00; wait < MAX_WAIT; ) {
      ++wait;
    }

    // Configure the desired I/O as output or input in the GPIOx_MODER register
    // 01: output
    // Red LED: PG2 as output [5:4]
    GPIOG->MODER |= BIT_04; // Set bit4 as 1
    GPIOG->MODER &= ~BIT_05; // Set bit5 as 0
    // Green LED: PG3 as output [7:6]
    GPIOG->MODER |= BIT_06; // Set bit6 as 1
    GPIOG->MODER &= ~BIT_07; // Set bit7 as 0
    // Blue LED: PG9 as output [19:18]
    GPIOG->MODER |= BIT_18; // Set bit18 as 1
    GPIOG->MODER &= ~BIT_19; // Set bit19 as 0

    // Set the output type. 
    // Note: remember that `open drain` requires a pull-up or pull-down
    //       resistor attached to the I/O port
    // 0: Output push-pull (reset state)
    // PG2: [2]
    GPIOG->OTYPER &= ~BIT_02; // Set bit2 as 0
    // PG3: [3]
    GPIOG->OTYPER &= ~BIT_03; // Set bit3 as 0
    // PG9: [9]
    GPIOG->OTYPER &= ~BIT_09; // Set bit9 as 0

    // Set the speed
    // 11: Very high speed
    // PG2: [5:4]
    GPIOG->OSPEEDR |= BIT_04; // Set bit4 as 1
    GPIOG->OSPEEDR |= BIT_05; // Set bit5 as 1
    // PG3: [7:6]
    GPIOG->OSPEEDR |= BIT_06; // Set bit6 as 1
    GPIOG->OSPEEDR |= BIT_07; // Set bit7 as 1
    // PG9: [19:18]
    GPIOG->OSPEEDR |= BIT_18; // Set bit18 as 1
    GPIOG->OSPEEDR |= BIT_19; // Set bit19 as 1

    // Disable pull up/down
    // 00: No pull-up, pull-down
    // PG2: [5:4]
    GPIOG->PUPDR &= ~BIT_04; // Set bit4 as 0
    GPIOG->PUPDR &= ~BIT_05; // Set bit5 as 0
    // PG3: [7:6]
    GPIOG->PUPDR &= ~BIT_06; // Set bit6 as 0
    GPIOG->PUPDR &= ~BIT_07; // Set bit7 as 0
    // PG9: [19:18]
    GPIOG->PUPDR &= ~BIT_18; // Set bit18 as 0
    GPIOG->PUPDR &= ~BIT_19; // Set bit19 as 0

    // Ensure the LEDs are ON by default
    if (OS_SetLEDs(RED | GREEN | BLUE))
    {
      return 1;
    }
    else return 0;
} // end OSp_InitGPIOG

/******************************************************************************
    OSp_InitGPIOA
		
      The clock to the PORTA module is enabled and the pin
    attached to the Blue pushbutton has its digital input enabled. 
******************************************************************************/
unsigned int
OSp_InitGPIOA (void) {
    //   /
    // \/ pt:
    //    Import your code from Coding Assignment #02

    volatile unsigned int wait = MAX_WAIT;
	
    // Identify which pin/port connects to the Blue pushbutton
    // [2] (Note: no code here, just something you need to do)

    // Enable the system clock for the PORTA peripheral
    // [1] pp.180-1
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

    // Wait for the system clock to stabilize
    for (wait = 0x00; wait < MAX_WAIT; ) {
      ++wait;
    } 

    // Configure the desired I/O as output or input in the GPIOx_MODER register
    // PA0 as input: [1:0]
    // 00: input
    GPIOA->MODER &= ~BIT_00; // Set bit0 as 0
    GPIOA->MODER &= ~BIT_01; // Set bit1 as 0

    // Set the speed
    // PA0: [1:0]
    // 11: Very high speed
    GPIOA->OSPEEDR |= BIT_00; // Set bit0 as 1
    GPIOA->OSPEEDR |= BIT_01; // Set bit1 as 1

    // Disable pull up/down
    // PA0: [1:0]
    // 00: No pull-up, pull-down
    GPIOA->PUPDR &= ~BIT_00; // Set bit0 as 0
    GPIOA->PUPDR &= ~BIT_01; // Set bit1 as 0

    return 1;
} // end OSp_InitGPIOA

/******************************************************************************
    OSp_InitTIM6
		
      The clock to the TIM6 module is enabled and configured to run at a 1ms
    cycle, causing an interrupt if global interrupts are enabled. 
******************************************************************************/
unsigned int
OSp_InitTIM6 (void) {
    //   /
    // \/ pt:
    //    Import your code from Coding Assignment #02

   volatile unsigned int wait = MAX_WAIT;	

    // Enable the system clock for the TIM6 peripheral
    // [1] p.183
    RCC->APB1ENR |= RCC_APB1ENR_TIM6EN;

    // Wait for the system clock to stabilize
    for (wait = 0x00; wait < MAX_WAIT; ) {
      ++wait;
    } 

    // Enable auto-reload
    // [1] p.704
    // Bit7 ARPE: Auto-reload preload enable
    // 0: TIMx_ARR register is not buffered.
    // 1: TIMx_ARR register is buffered.
    TIM6->CR1 |= BIT_07;

    // Ensure counter is free-running (does not stop counting)
    // [1] p.705
    // Bit3 OPM: One-pulse mode
    // 0: Counter is not stopped at update event
    // 1: Counter stops counting at the next update event
    //    (clearing the CEN bit).
    TIM6->CR1 &= ~BIT_03;

    // Only over/underflow causes interrupts
    // [1] p.705
    // Bit2 URS: Update request source
    // This bit is set and cleared by software to select the UEV event sources.
    // 0: Any of the following events generates an update interrupt or DMA
    //    request if enabled.
    //    These events can be:
    //      – Counter overflow/underflow
    //      – Setting the UG bit
    //      – Update generation through the slave mode controller
    // 1: Only counter overflow/underflow generates an update interrupt or
    //    DMA request if enabled.
    TIM6->CR1 |= BIT_02;


    // Interrupt on over/underflow enabled
    // [1] p.705
    // Bit1 UDIS: Update disable
    // This bit is set and cleared by software to enable/disable UEV event 
    // generation.
    // 0: UEV enabled. The Update (UEV) event is generated by one of the 
    //    following events:
    //   – Counter overflow/underflow
    //   – Setting the UG bit
    //   – Update generation through the slave mode controller
    //   Buffered registers are then loaded with their preload values.
    // 1: UEV disabled.
    TIM6->CR1 &= ~BIT_01;
    
    // [1] p.706 TIMx_DIER
    // Bit0 UIE: Update interrupt enable
    // 0: Update interrupt disabled.
    // 1: Update interrupt enabled.
    TIM6->DIER |= BIT_00;

    // No prescaler used
    // [1] pp.699, 708
    // The counter clock frequency CK_CNT is equal to f / (PSC[15:0] + 1)
    TIM6->PSC = 0x0; // f / (0+1) = f

    // Value for auto-reload register (sets the timer duration)
    // !!! BE SURE YOU USE A VALUE THAT CAUSES THE TIMER TO ROLLOVER
    //     AT 1 millisecond INTERVALS !!!
    // Note that the peripheral clock is running at 16MHz
    // [1] pp.699, 701, 708
    // 16000 = 0x3E80
    TIM6->ARR = ONE_MS;

    // Set the timer to the lowest-numbered (best-possible) priority
    // [4] pp.208, 214, core_cm4.h in (Proj. Dir.)/CMSIS_4/CMSIS/Include
    // (*** REPLACE THIS LINE WITH YOUR CODE ***)
    NVIC_SetPriority(TIM6_IRQ, 1);

    // Timer is ON
    // [1] p.705 TIMx_CR1
    // Bit0 CEN: Counter enable
    // 0: Counter disabled
    // 1: Counter enabled
    TIM6->CR1 |= BIT_00;

    // Enable IRQ for TIM6 in the NVIC
    // [4] p.208, 214, core_cm4.h in (Proj. Dir.)/CMSIS_4/CMSIS/Include
    
    NVIC_EnableIRQ(TIM6_IRQ);

    return 1;        
} // end OSp_InitTIM6

/******************************************************************************
    OS_SetLEDs
		
      Parameter is the bitwise OR of all the colors that should be set
    to ON.  This does not turn any LEDs OFF (requires OS_ClearLEDs).
******************************************************************************/
unsigned int
OS_SetLEDs (unsigned int LEDs) {
    //   /
    // \/ pt:
    //    Import your code from Coding Assignment #02
    
    // Set clear-bits of ODR register
    GPIOG->BSRR = (LEDs << POS_GPIO_BSRR_CLEAR);

    return 1;
} // end OS_SetLEDs

/******************************************************************************
    OS_ClearLEDs
		
      Parameter is the bitwise OR of all the colors that should be set
    to OFF.  This does not turn any LEDs ON (requires OS_SetLEDs).
******************************************************************************/
unsigned int
OS_ClearLEDs (unsigned int LEDs) {
    //   /
    // \/ pt:
    //    Import your code from Coding Assignment #02

    // Set set-bits of ODR register
    GPIOG->BSRR = LEDs;
    return 1;
} // end OS_ClearLEDs

/******************************************************************************
    OS_GetButton
		
      Returns nonzero if the button is pushed, otherwise returns zero. 
******************************************************************************/
unsigned int
OS_GetButton (void) {
    //   /
    // \/ pt:
    //    Import your code from Coding Assignment #02
    
    //    Send back the value of the bit in the input register assigned to
    //    the Blue pushbutton on the STM32 board
  return (GPIOA->IDR) & BIT_00;

} // end OS_GetButton


/******************************************************************************
    OS_InitKernelHAL
		
      Prepares the system hardware for use.
******************************************************************************/
unsigned int
OS_InitKernelHAL (void) {
    //   /
    // \/ pt 03:
    //    Import your existing code for the following functions:
    if ( OSp_InitGPIOG() && OSp_InitGPIOA() && OSp_InitTIM6() )
    {
      return 1;
    }
    else return 0;  

    // Make sure the call to OS_CRITICAL_END from CA #02 is *NOT* present in 
    //    this function

} // end OS_InitKernelHAL

// EOF    Kernel HAL.c
// Note: Some IDEs generate warnings if a file doesn't end in whitespace,
//  but Embedded Studio doesn't seem to be one of them.