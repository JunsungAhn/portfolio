/******************************************************************************
*******************************************************************************
  ECE 270 –Fall2019
  
  - author:   Junsung Ahn
  - filename: Kernel.h
  - Description: Declarations of kernel funtions
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

#ifndef		__KERNEL__H__
#define		__KERNEL__H__

/******************************************************************************
*******************************************************************************
    Includes
*******************************************************************************
******************************************************************************/
#include 	"Kernel HAL.h"
#include        "Kernel HAL_asm.h"

/******************************************************************************
*******************************************************************************
    Definitions
*******************************************************************************
******************************************************************************/
#define   OS_MAX_STACK_SIZE       0x40 // 64
#define   OS_MAX_TASKS            0x04 // 4
#define   OS_MAX_NUM_SEMAPHORES   0x02 // 2 for CA#06: LED
#define   OS_STACK_MARKER         0xDEADBEEF

/******************************************************************************
*******************************************************************************
    Public Prototypes
*******************************************************************************
******************************************************************************/


/******************************************************************************
*******************************************************************************
    Declarations & Types
*******************************************************************************
******************************************************************************/
typedef enum { UNDEFINED_ERROR,
               NO_ERROR,
               ERROR_EXCEEDING_MAX_NUM_TASKS,
               ERROR_EXCEEDING_MAX_STACK_SIZE,
               ERROR_INIT_KERNEL_HAL,
               ERROR_INIT_KERNEL,
               ERROR_CREATE_TASK,
               ERROR_ACCESSING_OUT_OF_BOUND_LISTS,
               ERROR_NO_READY_LIST,
               ERROR_PUSH_TASK_READY_LIST,
               ERROR_POP_TASK_READY_LIST,
               ERROR_CREATING_SEM_INVALID_TYPE,
               ERROR_CREATING_SEM_ZERO_MAX_TOKEN,
               ERROR_CREATE_SEM_EXCEEDING_MAX_NUM_SEM,
               ERROR_CREATING_SEM_START_HIGHER_THAN_MAX,
               ERROR_SEM_ACQ_WRONG_SEM_ID,
               ERROR_SEM_ACQ_TASK_RESTORE_READY_BUT_NO_TOKENS,
               ERROR_SEM_ACQ_TASK_RESTORE_READY_BUT_LOCKED,
               ERROR_SEM_ACQ_TASK_RESTORE_READY_BUT_LOCK_COUNT_NONZERO,
               ERROR_SEM_ACQ_TASK_RESTORE_READY_BUT_OWNERSHIP_NOTCLEARED,
               ERROR_SEM_ACQ_NEGATIVE_TOKEN,
               ERROR_SEM_REL_WRONG_SEM_ID,
               ERROR_SEM_REL_WRONG_OWNER,
               ERROR_SEM_REL_COUNTER_OUT_OF_MAXTOKENS,
               ERROR_SEM_REL_ALREADY_UNLOCKED,
               ERROR_PUSH_TASK_BLOCK_LIST,
               ERROR_SCHEDULER_CLEAR_SEMAPHORE,
               ERROR_INIT_ALLOC_TABLE_BLKSIZE_ZERO,
               ERROR_INIT_ALLOC_TABLE_BLKSIZE_NOT_8BIT_ALIGNED,
               ERROR_INIT_ALLOC_TABLE_BLKSIZE_GREATHER_THEN_HALFHEAP,
               ERROR_INIT_ALLOC_TABLE_BLKSIZE_NOT_DIVIDING_EVENLY,
               SYSTEM_ERROR } kernelErrors;

typedef enum { BINARY,
               MUTEX,
               COUNTING } kernelObjects;

/******************************************************************************
    OS_InitKernel
		
      Prepares the Kernel for use, but does not start any services.  No OS_
    function should be called until after this one has executed.
******************************************************************************/    
unsigned int
OS_InitKernel(unsigned int, unsigned int);

/******************************************************************************
    OS_CreateTask
		
      Takes the assigned function pointer and uses it to create a kernel task
    that is ready for execution.
******************************************************************************/
unsigned int
OS_CreateTask(void (*)(void), unsigned int,unsigned int, unsigned int);

/******************************************************************************
    OS_GetError
		
      Returns the value of a hidden system variable that stores the currently
      reported kernel error.
******************************************************************************/
kernelErrors
OS_GetError(void);

/******************************************************************************
    OS_SemCreate
		
      Creates a semaphore object
******************************************************************************/
unsigned int
OS_SemCreate(unsigned int type,
             unsigned int startTokens,
             unsigned int maxTokens);

/******************************************************************************
    OS_SemAcquire
		
      Attempts to acquire the semaphore sepcified by parameter 'ID'.
******************************************************************************/
unsigned int
OS_SemAcquire(unsigned int ID);

/******************************************************************************
    OS_SemRelease

    Releases the semaphores specified by parameter 'ID'.
******************************************************************************/
unsigned int
OS_SemRelease(unsigned int ID);

/******************************************************************************
    OS_Malloc

    Return a pointer to an allocation block in the heap that is large enough
    to support 'blockSize' where 'blockSize' is in units of 
    sizeof(unsigned int)
******************************************************************************/
void *
OS_Malloc(unsigned int blockSize);

/******************************************************************************
    OS_Start
		
      Begins kernel services and starts execution of the highest priority task.
******************************************************************************/
extern void
OS_Start(void);
#endif	//	__KERNEL__H__

// EOF    Kernel HAL.h
// Note: Some IDEs generate warnings if a file doesn't end in whitespace,
//  but Embedded Studio doesn't seem to be one of them.
