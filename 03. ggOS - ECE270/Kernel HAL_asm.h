/******************************************************************************
*******************************************************************************
  ECE 270 –Fall2019
  
  - author:   Junsung Ahn
  - filename: Kernel HAL_asm.h
  - Description: Some define values for Kernel HAL_asm.s
  - Homework #: 7

  Copyright DigiPen (USA) Corporation
  All Rights Reserved
*******************************************************************************
******************************************************************************/

/******************************************************************************
      Contains gcc symbol definitions that must be shared between both the
    assembly and C source files.
******************************************************************************/

/******************************************************************************
*******************************************************************************
    Definitions
*******************************************************************************
******************************************************************************/
// taskState_t values
#define   OS_READY            0x00
#define   OS_RUNNING          0x01
#define   OS_BLOCKED          0x02

//   /
// \/ pt:
//  Left to the student to determine what these values should be
#define   BYTES_PER_WORD   0x04
#define   TCB_STATE_OFFSET 0x08
#define   TIMER6_BASE      0x40001000
#define   TIMER6_SR        0x40001010
#define   TIMER6_SR_OFFSET 0x10
#define   TIMER_IF         0x00
#define   SR_HIGH          1
#define   DISPATCHER_TASK_SWITCH      0x01
#define   DISPATCHER_TASK_CONTINUE    0x02

// EOF    Kernel HAL_asm.h
// Note: Some IDEs generate warnings if a file doesn't end in whitespace,
//  but Embedded Studio doesn't seem to be one of them.



