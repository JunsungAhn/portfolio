/******************************************************************************
*******************************************************************************
  ECE 270 –Fall2019
  
  - author:   Junsung Ahn
  - filename: Kernel HAL_asm.s
  - Description: Definitions of OS_Start, TIM6_DAC_IRQHandler
  - Homework #: 7

  Copyright DigiPen (USA) Corporation
  All Rights Reserved
*******************************************************************************
******************************************************************************/
#include "Kernel HAL_asm.h" // For some defined values

/******************************************************************************
*******************************************************************************
  References:

  [5] Real-Time Operating Systems for
  ARM Cortex-M Microcontrollers

*******************************************************************************
******************************************************************************/
  .syntax unified                   // Required to execute Thumb-2 code

  .global OS_Start                  // Required to expose function to .c files
  .extern OS_TaskRUNNING            // Defined in Kernel.c
  .extern OS_TaskNEW                // Defined in Kernel.c

  .section .text                    // Where to locate this code
  .align 0


  .thumb_func
OS_Start:
  /****************************************************************************
    OS_Start

    pt 06:
      Implement the StartOS assembly code from the Valvano text, but 
      replace RunPt with OS_TaskRUNNING.  Place a breakpoint on the bx
      instruction and verify that the registers are getting loaded with 
      the data you manually placed in the stack for the task.  If it isn't,
      go back and fix OS_TaskCreate.  Then, place a breakpoint in the 
      Idle task.  After the bx command executes, you should be running
      inside the Idle task.  When the code is free-running, the Red LED
      should continue to flash as before while program execution remains in
      the Idle task.  Note that pure assembly functions don't require any
      () or {} around them- code just begins and ends.
      [5] p.177 (3rd Ed.)

    <CA#05>
    Modify this function so that the task it attempts to run has its state
    set to RUNNING
  ****************************************************************************/

  /****************************************************************************
    The code below is referred from "Real-Time Operating Systems for
    ARM Cortex-M Microcontrollers", Valvano, 4th edition, p 179(kindle)
   ***************************************************************************/
  LDR     R0, =OS_TaskRUNNING           // Currently Running Thread
  LDR     R1, [R0]                      // R1 = value of OS_TaskRUNNING
  LDR     R2, [R1, #TCB_STATE_OFFSET]   // Load taskState of OS_TaskRUNNING
  LDR     R2, =OS_RUNNING               // Change state value to OS_RUNNING
  STR     R2, [R1, #TCB_STATE_OFFSET]   // Apply change to TCB's taskState
  LDR     SP, [R1]                      // new thread SP
                                          // SP = OS_TaskRUNNING->sp;
  POP     {R4-R11}                      // Restore R4-R11
  POP     {R0-R3}                       // Restore R0-R3
  POP     {R12}                         // Restore R12
  ADD     SP, SP, #4                    // Discard LR from initial stack
  POP     {LR}                          // Start location
  ADD     SP, SP, #4                    // Discard PSR
  CPSIE   I                             // Enable interrupt
  BX      LR                            // Start the first thread

  /*
  // 2nd edition
  LDR     R0, =OS_TaskRUNNING   // currently running thread
  LDR     R2, [R0]              // R2 = value of OS_TaskRUNNING
  LDR     R3, [R2, #8]          // Load taskState of OS_TaskRUNNING
  LDR     R3, =0x01             // Change value to OS_RUNNING
  STR     R3, [R2, #8]          // Apply to TCB's taskState
  LDR     SP, [R2]              // new thread SP; SP = OS_TaskRUNNING->sp;
  POP     {R4-R11}              // restore regs r4-11
  POP     {R0-R3}               // restore regs r0-3
  POP     {R12}
  POP     {LR}
  POP     {LR}
  POP     {R1}
  CPSIE   I                     // Enable interrupts at processor level
  BX      LR                    // start first thread
  */



  .thumb_func
  .weak TIM6_DAC_IRQHandler
TIM6_DAC_IRQHandler:
  
  /****************************************************************************
    The code below is referred from "Real-Time Operating Systems for
    ARM Cortex-M Microcontrollers", Valvano, p 180, 4th edition(kindle)
    (Program 4.7. Assembly code for the thread switcher)  
   ***************************************************************************/

  /****************************************************************************
    <CA#06>
    Remove any code that touches task states. This will now have to be done in
    the scheduler function.
    Add code that checks the return value from the scheduler.
    If the scheduler indicates that the currently running task should continue
    to run, then the dispatch function must skip over the lines of code that
    execute this functionality(function execution should resume at the pop of
    registers R4-R11 off of the stack).
    By default, function return values are always placed into the same
    register, unless the size of the return value exceeds the space available,
    in which case it could end up on the stack.
   ***************************************************************************/
  CPSID   I         // Disable global interrupts
  PUSH    {R4-R11}  // push registers 4-11 onto the stack
 
  // WHILE_CLEAR_SR:
  // Clear the timer 6 interrupt flag bit om the Timer 6 status register,
  // and do not let the code proceed
  // until it is verified that the bit is cleared.
  WHILE_CLEAR_SR:
    LDR   R3, =TIMER6_SR    // R3 = pointer to register TIM6_SR
    LDR   R3, [R3]          // Get the current value of SR register
    BIC   R3, R3, #SR_HIGH  // Clear bit[0]
    LDR   R2, =TIMER6_SR    // R2 = pointer to TIM6_SR
    STR   R3, [R2]          // Store modifed value(bit[0]:1->0) to TIM6_SR
    LDR   R2, [R2]          // Get the current value of TIM6_SR
    AND   R3, R2, #SR_HIGH  // AND with R2(current) and TIMER
    CMP   R3, #TIMER_IF     // Check bit[0] is cleared
    BNE   WHILE_CLEAR_SR    // If not, go to while loop again
    
  PUSH    {LR}              // Push LR value before entering subroutine
  BL      OSp_ScheduleTask  // Call function OSp_ScheduleTask
                            // Return value is stored in R0
  POP     {LR}              // Restore LR value
  
  CMP     R0, #DISPATCHER_TASK_CONTINUE
  BEQ     POP_R4_R11 // If no task change, jump to pop R4-R11

  LDR     R0, =OS_TaskRUNNING           // R0 = pointer to old thread
  LDR     R1, [R0]                      // R1 = OS_TaskRUNNING
  STR     SP, [R1]                      // Save the current SP into old TCB's sp

  LDR     R1, =OS_TaskNEW               // R1 = pointer to new thread
  LDR     R2, [R1]                      // R2 = OS_TaskNEW
  STR     R2, [R0]                      // OS_TaskRUNNING = OS_TaskNEW

  LDR     R1, [R0]                      // R1 = OS_TaskRUNNING
  LDR     SP, [R1]                      // new thread SP; SP=OS_TaskNEW->sp

  POP_R4_R11:
    POP     {R4-R11}                      // Restore regs R4-R11
    CPSIE   I                             // Tasks run with interrupts enabled
    BX      LR                            // Restore R0-R3, R12, LR, PC, PSR
  

// EOF    Kernel HAL_asm.s
// Note: Some IDEs generate warnings if a file doesn't end in whitespace,
//  but Embedded Studio doesn't seem to be one of them.