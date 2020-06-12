/******************************************************************************
*******************************************************************************
  ECE 270 –Fall2019
  
  - author:   Junsung Ahn
  - filename: Kernel.c
  - Description: Definitions of kernel funtions
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
    
  [5] Real-Time Operating Systems for
  ARM Cortex-M Microcontrollers

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
#include 	"Kernel.h"
#include        "stm32f429xx.h" // TIM6_DAC_IRQn

/******************************************************************************
*******************************************************************************
    Definitions
*******************************************************************************
******************************************************************************/
#define OS_THUMB_BIT  0x01000000
#define TASK_IDLE_ID  0x00
#define TASK_IDLE_PRIORITY 0x00 // lowest priority
#define TASK_IDLE_EXECUTION_TIME 0x01
#define TASK_IDLE_DEADLINE 0x10 // highest deadline
#define PRIORITY_CEILING OS_MAX_TASKS // 0x04
#define MAX_LISTS 0x02 // ready, block
#define MAX_LIST_SIZE OS_MAX_TASKS // 0x04
#define INDEX_READY_LIST 0x00
#define INDEX_BLOCK_LIST 0x01
#define SEM_DEFAULT_OWNER OS_MAX_TASKS
#define DISPATCHER_TASK_SWITCH   0x01
#define DISPATCHER_TASK_CONTINUE 0x02
#define MINIMUM_TOTAL_HEAP 512*sizeof(unsigned int) // 2048
#define HEAP_INITIAL_LABEL end_allocation_array+2
#define EVENT_RED           0x01
#define EVENT_BLUE          0x02
#define EVENT_GREEN         0x04


// Optional definitions not required to produce working code
#ifndef			MAX_WAIT
	#define		BON(X)			|=(X)
	#define		BOFF(X)			&=~(X)
	#define		BTOG(X)			^=(X)
	#define		MAX_WAIT		0xFFFF
#endif		//	MAX_WAIT

/******************************************************************************
*******************************************************************************
    Declarations & Types
*******************************************************************************
******************************************************************************/
typedef	void (* OS_TaskAddress)(void);	

typedef unsigned char taskState_t; // Values are defined in Kernel HAL_asm.h
typedef enum { BINARY_AVAILABLE,
               BINARY_UNAVAILABLE,
               COUNTING_AVAILABLE,
               COUNTING_UNAVAILABLE,
               MUTEX_UNLOCKED,
               MUTEX_LOCKED } semaphoreState_t;

typedef struct {
    unsigned int    *sp;
    unsigned int    taskID;
    taskState_t     taskState;
    OS_TaskAddress  taskAddress;
    unsigned int    priority_level;
    unsigned int    original_priority_level;
    unsigned int    execution_time;
    unsigned int    elapsed_time;
    unsigned int    deadline;
    unsigned int    semaphoreID;
} TCB;

typedef struct {
  unsigned int *priority;
  TCB *ptr;
} nodeObj; // Tasks

typedef struct {
  unsigned int listSize;
  nodeObj *nodes[MAX_LIST_SIZE];
} listObj; // Ready, Block list

typedef struct {
  unsigned int ID;
  kernelObjects sem_type;
  semaphoreState_t semaphoreState;
  unsigned int tokens;
  unsigned int maxTokens;
  unsigned int count;
  unsigned int ownerID;
} semaphore; // SCB

typedef struct {
  int label;
  void *address;
} allocation_block;

// Globals used by the system
TCB                 Tasks[OS_MAX_TASKS]; // maximum 4 threads
TCB                 *OS_TaskNEW;
TCB                 *OS_TaskRUNNING;
unsigned char       newTaskID;
unsigned int        num_tasks; //
unsigned int        stack_size_per_task;
unsigned int        Stacks[OS_MAX_TASKS][OS_MAX_STACK_SIZE]; // 4*64 stacks
nodeObj             nodes[MAX_LIST_SIZE];
kernelErrors        error_code;
semaphore           Semaphores[OS_MAX_NUM_SEMAPHORES];
unsigned char       Heap[MINIMUM_TOTAL_HEAP]; // Heap
allocation_block    allocation_array[512];
unsigned int        end_allocation_array;
unsigned int        num_entry_allocation_array;
unsigned int        unit_block_size;
extern unsigned int whoTurn; // from main.c

/******************************************************************************
*******************************************************************************
    Prototypes
*******************************************************************************
******************************************************************************/
void OS_IdleTask(void);
listObj *OSp_GetList (unsigned int);
unsigned int OSp_ListPush(listObj *, nodeObj *);
nodeObj *OSp_ListPop(listObj *);
nodeObj *OSp_ListPopByTurn(listObj *);
nodeObj *OSp_ListPeek(listObj *);
nodeObj *OSp_ListPeekByTurn(listObj *);
void OSp_ListSort (listObj * list);
void OSp_SetError(kernelErrors code);
nodeObj * OSp_BlockListPop (listObj * list, unsigned int semaphoreID);
void OSp_ListShrink(listObj *);
unsigned int OSp_AllocateInit(unsigned int);

/******************************************************************************
*******************************************************************************
    Helper Functions
*******************************************************************************
******************************************************************************/

/******************************************************************************
    OS_InitKernel
		
      Prepares the Kernel for use, but does not start any services. No OS_
    function should be called until after this one has executed.
    
    <CA#05>
    Modify this function so that users can specify how many tasks they wish to
    reserve space for and how large(in 32-bit words) to make the stack space
    for each tasks.
    Note that these values cannot be allowed to exceed the limitations set by
    your kernel.
    Remove all code that directly touches TBCs or their stacks. Migrate this
    code into own functions. The best option is to have a function that sets
    the TCBs and stacks to have default values that are then overwritten as
    needed when new tasks are created
******************************************************************************/    
unsigned int
OS_InitKernel(unsigned int given_num_tasks, unsigned int given_stack_size)
{
    if (given_num_tasks > OS_MAX_TASKS)
    {
      OSp_SetError(ERROR_EXCEEDING_MAX_NUM_TASKS);
      return 0;
    }

    if (given_stack_size > OS_MAX_STACK_SIZE)
    {
      OSp_SetError(ERROR_EXCEEDING_MAX_STACK_SIZE);
      return 0;
    }

    num_tasks = given_num_tasks;
    stack_size_per_task = given_stack_size;
    
    if ( OS_InitKernelHAL() )
    {
      if (OS_CreateTask(OS_IdleTask, TASK_IDLE_PRIORITY, 
                        TASK_IDLE_EXECUTION_TIME, TASK_IDLE_DEADLINE) )
      {
        OS_TaskRUNNING = &Tasks[TASK_IDLE_ID];
        OS_TaskRUNNING->taskState = OS_RUNNING;

        if (OSp_AllocateInit(8*sizeof(unsigned int)))
        {
          return 1;
        }
        else
        {
          return 0;
        }
      }
      else
      {
        OSp_SetError(ERROR_CREATE_TASK);
        return 0;
      }
    }
    else
    {
      OSp_SetError(ERROR_INIT_KERNEL_HAL);
      return 0;
    }

} // end OS_InitKernel

/******************************************************************************
    OS_CreateTask
		
      Takes the assigned function pointer and uses it to create a kernel task
    that is ready for execution.

    <CA#05>
    Modify this function and TCB structure so that created tasks are assigned
    a prority level, execution time, and deadline determined by 
    the kernel user.
    Note that the system idle task must always be created at the lowest(worst)
    possible priority and no user task can be allowed to share this priority.
    Note also that for the purpose of our kernel, the task period is equal to
    the deadline(so extended deadlines are unsupported).
    Modify this function and TCB structure so that newly created tasks are
    assigned the READY state
******************************************************************************/
unsigned int
OS_CreateTask(
  void (* newTask)(void),
  unsigned int newTask_priority_level,
  unsigned int newTask_exectution_time,
  unsigned int newTask_deadline)
{
    static unsigned int newTaskID = 0x00; // Initial thread ID
    if (newTaskID > OS_MAX_TASKS)
    {
      OSp_SetError(ERROR_EXCEEDING_MAX_NUM_TASKS);
      return 0;
    }
    // R0~R12: General Purpose Registers
    // R13: SP
    // R14: LR
    // R15: PC


    //   /
    // \/ pt 04:
    //    This function has been passed a pointer to a function that we wish 
    //  to execute as a thread.  Examine the definition of the TCB structure
    //  contained in this file.  The code in this function must do the  
    //  following things:

    //  1) Store the passed-in function pointer inside the
    //      TCB structure and the TCB's stack.
    Tasks[newTaskID].taskAddress = newTask;
    
    // R15: PC
    Stacks[newTaskID][stack_size_per_task-0x03] = (unsigned int)(newTask); 

    // Store priority level, execution time, deadline
    Tasks[newTaskID].priority_level = newTask_priority_level;
    Tasks[newTaskID].original_priority_level = newTask_priority_level;
    Tasks[newTaskID].execution_time = newTask_exectution_time;
    Tasks[newTaskID].deadline = newTask_deadline;

    //  2) Assign the correct ID number to the new task.  Note that newTaskID
    //      is both a task ID and an index into the global array of tasks.
    Tasks[newTaskID].taskID = newTaskID;

    //  3) Set the task state to READY.
    Tasks[newTaskID].taskState = OS_READY;

    Tasks[newTaskID].elapsed_time = 0;
    Tasks[newTaskID].semaphoreID = 0;


    //  4) Pre-load the task's stack with the correct starting data.  Examine
    //    page 174* of the Valvano text very carefully to see what must be set,
    //    and where.  However, the Valvano code needs to be modified slightly.
    //    The top of the stack will be marked with a special value so that
    //    stack overruns can be detected.  This means that your code should 
    //    write our marker value (0xDEADBEEF) into location `stack size - 0x01`
    //    and all other locations need to have their locations in the stack
    //    incremented by +1 accordingly.
    //    The code below is referred from [5] p177, Valvano, 2nd edition
    Stacks[newTaskID][stack_size_per_task-0x01] = OS_STACK_MARKER;
    Stacks[newTaskID][stack_size_per_task-0x02] = OS_THUMB_BIT;
    Stacks[newTaskID][stack_size_per_task-0x04] = 0x14141414; // R14:LR
    Stacks[newTaskID][stack_size_per_task-0x05] = 0x12121212; // R12
    Stacks[newTaskID][stack_size_per_task-0x06] = 0x03030303; // R3
    Stacks[newTaskID][stack_size_per_task-0x07] = 0x02020202; // R2
    Stacks[newTaskID][stack_size_per_task-0x08] = 0x01010101; // R1
    Stacks[newTaskID][stack_size_per_task-0x09] = 0x00000000; // R0
    Stacks[newTaskID][stack_size_per_task-0x0A] = 0x11111111; // R11
    Stacks[newTaskID][stack_size_per_task-0x0B] = 0x10101010; // R10
    Stacks[newTaskID][stack_size_per_task-0x0C] = 0x09090909; // R9
    Stacks[newTaskID][stack_size_per_task-0x0D] = 0x08080808; // R8
    Stacks[newTaskID][stack_size_per_task-0x0E] = 0x07070707; // R7
    Stacks[newTaskID][stack_size_per_task-0x0F] = 0x06060606; // R6
    Stacks[newTaskID][stack_size_per_task-0x10] = 0x05050505; // R5
    Stacks[newTaskID][stack_size_per_task-0x11] = 0x04040404; // R4


    //  5) Set the stack pointer value in the TCB to set to the starting 
    //    location of valid stack data (which will be `stack size - 0x11`.
    // R4
    Tasks[newTaskID].sp = &Stacks[newTaskID][stack_size_per_task-0x11];

    // <CA#05>
    // If this task is not IDLE task, then add it to the ready list
    nodes[newTaskID].priority = &Tasks[newTaskID].priority_level;
    nodes[newTaskID].ptr = &Tasks[newTaskID];
    if (newTaskID != TASK_IDLE_ID)
    {
      if (OSp_ListPush(OSp_GetList(INDEX_READY_LIST), &nodes[newTaskID]))
      {
        OSp_ListSort(OSp_GetList(INDEX_READY_LIST));
      }
      else
      {
        OSp_SetError(ERROR_PUSH_TASK_READY_LIST);
        return 0;
      }
    }

    //  6) Lastly, the value of newTaskID should be updated.
    ++newTaskID;

    return 1;

} // end OS_TaskCreate

/******************************************************************************
    OS_GetError
		
      Returns the value of a hidden system variable that stores the currently
      reported kernel error.
******************************************************************************/
kernelErrors
OS_GetError(void)
{
  return error_code;
}

/******************************************************************************
    OS_IdleTask
		
      This task should always be created, have the lowest possible (worst) 
    priority, and never be prevented from running.
******************************************************************************/
void
OS_IdleTask(void) {
    while (0x01) {
      ;
    } // end while
} // end OS_IdleTask

/******************************************************************************
    OS_SemCreate
		
      Creates a semaphore object
******************************************************************************/
unsigned int
OS_SemCreate(unsigned int type, 
             unsigned int startTokens,
             unsigned int maxTokens)
{
  // Semaphore ID starts from 1
  static unsigned int semaphore_id = 1;

  // Check total number of semaphore currently
  if (semaphore_id > OS_MAX_NUM_SEMAPHORES)
  {
    OSp_SetError(ERROR_CREATE_SEM_EXCEEDING_MAX_NUM_SEM);
    return 0;
  }
   
  // Check type is valid
  if (type != MUTEX && type != COUNTING)
  {
    OSp_SetError(ERROR_CREATING_SEM_INVALID_TYPE);
    return 0;
  }
  
  // Check maximum token given
  if (maxTokens == 0)
  {
    OSp_SetError(ERROR_CREATING_SEM_ZERO_MAX_TOKEN);
    return 0;
  }

  // Check startToken is higher than maxTokens
  if (startTokens > maxTokens)
  {
    OSp_SetError(ERROR_CREATING_SEM_START_HIGHER_THAN_MAX);
    return 0;
  }

  
  Semaphores[semaphore_id].ID = semaphore_id;
  Semaphores[semaphore_id].sem_type = type;
  Semaphores[semaphore_id].tokens = startTokens;
  Semaphores[semaphore_id].maxTokens = maxTokens;
  if (type == BINARY)
  {
    // Start from available
    Semaphores[semaphore_id].count = 1;
    Semaphores[semaphore_id].semaphoreState = BINARY_AVAILABLE;
  }
  else if (type == COUNTING)
  {
    // For counting semaphore,
    // 'count' is counting the number of tokens
    Semaphores[semaphore_id].count = startTokens;
    Semaphores[semaphore_id].semaphoreState = COUNTING_AVAILABLE;
  }
  else if (type == MUTEX)
  {
    // For mutex semaphore,
    // 'count' is couting the number of lock(recursive)
    Semaphores[semaphore_id].count = 0;
    Semaphores[semaphore_id].semaphoreState = MUTEX_UNLOCKED;
  }
  // In default, give invalid owner for this semaphore
  Semaphores[semaphore_id].ownerID = SEM_DEFAULT_OWNER;

  // Return ID and increment for the next semaphore object
  return semaphore_id++;
  
} // end of OS_SemCreate

/******************************************************************************
    OS_SemAcquire
		
      Attempts to acquire the semaphore sepcified by parameter 'ID'.
      This function is blocking, so the user code that completes this function
      call will assume it has the semaphore unless and error is thrown.

      Mutexes must be able to support recursive locking. Note that on a failed
      acquire of a valid semaphore, the calling task has its state set to
      BLOCKED and it is added to the blocked list. The code should then burn
      through its remaining CPU cycles in a 'while state==BLOCKED' loop.
      When the task is restored to the READY(and eventual RUNNING) state,
      code execution should then resume with a successful acquire of the
      semaphore(if the task could not complete the acquisition process,
      it should not have benn removed from the blocked list).
******************************************************************************/
unsigned int
OS_SemAcquire(unsigned int ID)
{
  // Make sure interrupt not occurs during semaphore acquisition
  NVIC_DisableIRQ(TIM6_DAC_IRQn);
  unsigned int acquire_return = NO_ERROR;
  // Check ID is valid
  if (ID >= OS_MAX_NUM_SEMAPHORES)
  {
    OSp_SetError(ERROR_SEM_ACQ_WRONG_SEM_ID);
    acquire_return = 0;
  }
  else
  {
    if (Semaphores[ID].sem_type == BINARY)
    {
      // Binary semaphore acquire
    }
    else if (Semaphores[ID].sem_type == COUNTING)
    {
      // Counting semaphore acquire
    }
    else // Mutex semaphore
    {

      if (Semaphores[ID].semaphoreState == MUTEX_UNLOCKED)
      {
        // Acquire unlocked mutex semaphore
        // Ceiling priority protocol, this should be first
        //OS_TaskRUNNING->priority_level = PRIORITY_CEILING;

        OS_TaskRUNNING->semaphoreID = ID;
        
        Semaphores[ID].semaphoreState = MUTEX_LOCKED;

        // Register the running task as the owner of this mutex
        Semaphores[ID].ownerID = OS_TaskRUNNING->taskID;

        
        // Decrement token count
        --(Semaphores[ID].tokens);

        // Increment lock count
        ++(Semaphores[ID].count);
        
        // This semaphore moves to locked state

      }
      else // if MUTEX_LOCKED
      {
        // Check ownership
        if (Semaphores[ID].ownerID == OS_TaskRUNNING->taskID)
        {
          // Recursive locking: Increase lock count
          ++(Semaphores[ID].count);
        }
        else
        {
          // Not the owner of this mutex,
          // Change the current running task's state to BLOCKED
          OS_TaskRUNNING->taskState = OS_BLOCKED;

          // Scheduler should not add blocked task to the ready list

          // Push this task to the block list
          // Before pushing, assign semID to this task
          OS_TaskRUNNING->semaphoreID = ID;
          listObj *block_list = OSp_GetList(INDEX_BLOCK_LIST);
          if (OSp_ListPush(block_list, &nodes[OS_TaskRUNNING->taskID]))
          {
            OSp_ListSort(block_list);
          }
          else
          {
            OSp_SetError(ERROR_PUSH_TASK_BLOCK_LIST);
            acquire_return = 0;
          }
  
          // Burn CPU cycles
          // until this semaphore tokens are available
          // until it restores to the READY/RUNNING
          // Before go into while, make sure enable interrupt again
 
          while (OS_TaskRUNNING->taskState == OS_BLOCKED)
          {
            NVIC_EnableIRQ(TIM6_DAC_IRQn);
            //acquire_return = 0xDEAD;
          }
          // The function will be here when the semaphore release token
          // Make sure disable interrupt
          NVIC_DisableIRQ(TIM6_DAC_IRQn);

          // Check semaphore is unlocked
          if (Semaphores[ID].semaphoreState == MUTEX_UNLOCKED)
          {
            // Check token is available
            if (Semaphores[ID].tokens)
            {
              // Check lock count is cleared
              if (Semaphores[ID].count == 0)
              {
                // Check ownership is cleared in default
                if (Semaphores[ID].ownerID == SEM_DEFAULT_OWNER)
                {
                  // This semaphore moves to locked state
                  Semaphores[ID].semaphoreState = MUTEX_LOCKED;

                  // Register the running task as the owner of this mutex
                  Semaphores[ID].ownerID = OS_TaskRUNNING->taskID;
        
                  // Decrement token count
                  --(Semaphores[ID].tokens);

                  // Increment lock count
                  ++(Semaphores[ID].count);
                }
                else
                {
                  OSp_SetError(ERROR_SEM_ACQ_TASK_RESTORE_READY_BUT_OWNERSHIP_NOTCLEARED);
                  acquire_return = 0;
                }
              }
              else
              {
                OSp_SetError(ERROR_SEM_ACQ_TASK_RESTORE_READY_BUT_LOCK_COUNT_NONZERO);
                acquire_return = 0;
              }
            }
            else
            {
              OSp_SetError(ERROR_SEM_ACQ_TASK_RESTORE_READY_BUT_NO_TOKENS);
              acquire_return = 0;
            }
          }
          else
          {
            OSp_SetError(ERROR_SEM_ACQ_TASK_RESTORE_READY_BUT_LOCKED);
            acquire_return = 0;
          }
        }
      }
    }
  }
  NVIC_EnableIRQ(TIM6_DAC_IRQn);
  return acquire_return;
} // end of OS_SemAcquire

/******************************************************************************
    OS_SemRelease

    Releases the semaphores specified by parameter 'ID'.
    Release operations are always successful unless the wrong task is
    attempting to release a mutex.
    The semaphore's count is simply limited to the ragne [0:maxTokens].
    This function also needs to manage the process of pulling tasks off
    the blocked list and setting them back to READY.
******************************************************************************/
unsigned int
OS_SemRelease(unsigned int ID)
{
  // Make sure interrupt not occur during semaphore release
  NVIC_DisableIRQ(TIM6_DAC_IRQn);
  unsigned int release_return = NO_ERROR;
  // Check ID is valid
  if (ID >= OS_MAX_NUM_SEMAPHORES)
  {
    OSp_SetError(ERROR_SEM_REL_WRONG_SEM_ID);
    release_return = 0;
  }
  else
  {
    if (Semaphores[ID].sem_type == BINARY)
    {
      // Binary semaphore release
    }
    else if (Semaphores[ID].sem_type == COUNTING)
    {
      // Couting semaphore relese
    }
    else // Mutex semaphore 
    {
      // Check the semaphore state
      if (Semaphores[ID].semaphoreState == MUTEX_LOCKED)
      {
        // Check ownership
        if (Semaphores[ID].ownerID == OS_TaskRUNNING->taskID)
        {
          // Check counter is in the valid range
          if (Semaphores[ID].count <= Semaphores[ID].maxTokens)
          {
            // Release(decrement) counter
            --(Semaphores[ID].count);

            // After release, check the semaphore becomes unlocked
            if (Semaphores[ID].count == 0)
            {
              // semaphore should be unlocked, so clear all information
              // 

              // Clear the owner
              Semaphores[ID].ownerID = SEM_DEFAULT_OWNER;

              // Increment the token
              ++(Semaphores[ID].tokens);

              // Change semaphore state to unlocked
              Semaphores[ID].semaphoreState = MUTEX_UNLOCKED;

              OS_TaskRUNNING->semaphoreID = 0x00;

              // Restore the priority
              //OS_TaskRUNNING->priority_level = OS_TaskRUNNING->original_priority_level;
              
              // Pop the waiting task from the block list if any blocked task exists
              listObj *block_list = OSp_GetList(INDEX_BLOCK_LIST);
              if (block_list->listSize)
              {
                nodeObj *waiting_task = OSp_BlockListPop(block_list, ID);

                // set the task back to READY
                if (waiting_task)
                {
                  waiting_task->ptr->taskState = OS_READY;
                  listObj *ready_list = OSp_GetList(INDEX_READY_LIST);
                  // Put this back to the ready list
                  if (OSp_ListPush(ready_list, waiting_task))
                  {
                    OSp_ListSort(ready_list);
                    release_return = NO_ERROR; // done
                  }
                  else
                  {
                    OSp_SetError(ERROR_PUSH_TASK_READY_LIST);
                    release_return = 0;
                  }
                }
              }
            }
          }
          else
          {
            OSp_SetError(ERROR_SEM_REL_COUNTER_OUT_OF_MAXTOKENS);
            release_return = 0;
          }
        }
        else
        {
          // Wrong owner tries to release semaphore
          // Will be blocked next acquire call
          release_return = 0;
        }
      }
      else
      {
        // Release unlocked semaphore
        // No affect
        release_return = NO_ERROR;        
      }
    }
  }
  // Make sure interrupt occur after release is done
  NVIC_EnableIRQ(TIM6_DAC_IRQn);
  return release_return;
} // end of OS_SemRelease


/******************************************************************************
    OS_Malloc
     - On success, return back a pointer to an allocation block in the heap
       that is large enough to support 'blockSize' where 'blockSize' is 
       in units of sizeof(unsigned int)=4. If 'blockSize' is larger than a 
       single allocation block, the function must still return a valid pointer
       if enough contiguous allocation blocks are present in the heap to meet
       the demand. Even though the function is only returning a pointer to the
       first such block in the series, the allocation table must be correctly
       updated to show that the entire series has been allocated.
     - An error is returned if the memory request cannot be honored (which
       meshes well with our error system, as we would want to return a null
       pointer in any case.)
     - A separate error is returned if 'blockSize' is of a value that makes it
       impossible to successfully allocate.
     - The function must be reentrant.
******************************************************************************/
void *
OS_Malloc(unsigned int blockSize)
{
  if (blockSize > num_entry_allocation_array * unit_block_size)
  {
    // blockSize is too big
    return 0;
  }
  NVIC_DisableIRQ(TIM6_DAC_IRQn);

  // Compute how many blocks may be required
  int num_block_required = 0;
  if (blockSize <= unit_block_size)
  {
    num_block_required = 1;
  }
  else // blockSize > unit_block_size
  {
    num_block_required = (blockSize / unit_block_size);
    if (blockSize % unit_block_size)
    {
      ++num_block_required;
    }
  }


  // Look from the end
  int i;
  int found_block_index = -1;
  void *return_address;
  for (i = end_allocation_array; i > 0; --i)
  {
    if (allocation_array[i].label == HEAP_INITIAL_LABEL)
    {
      continue;
    }

    if (allocation_array[i].label < 0)
    {
      continue;
    }
    // The first-found valid size block will be returned
    if (allocation_array[i].label >= num_block_required)
    {
      found_block_index = i;
      break;
    }
  }

  if (found_block_index != -1) // Found
  {
    // Update the above blocks
    int existing_head = found_block_index 
                        - allocation_array[found_block_index].label + 1;
    allocation_array[existing_head].label -= num_block_required;
    int new_tail = existing_head+allocation_array[existing_head].label-1;
    allocation_array[new_tail].label = allocation_array[existing_head].label;
    
    // Update the found block
    int traverse;
    allocation_array[found_block_index].label = 0;
    for (traverse = 1; traverse < num_block_required; ++traverse)
    {
      --found_block_index;
    }
    allocation_array[found_block_index].label = -1 * num_block_required;

    return_address = allocation_array[found_block_index].address;
  }
  else // Not found
  {
    return_address = 0;
  }

  NVIC_EnableIRQ(TIM6_DAC_IRQn);
  return return_address;
} // end of OS_Malloc


/******************************************************************************
    OS_Free
     - Provided that 'ptr' is a valid pointer from the allocation table,
       its associated memory block should be marked as available for
       reallocation. Otherwise, it is an error.
     - On a successful de-allocation, return back 'ptr' which the function
       will obviously have to cast.
     - The function must be reentrant
******************************************************************************/
unsigned int
OS_Free(void *ptr)
{
  if (ptr == 0)
  {
    return 0;
  }
  NVIC_DisableIRQ(TIM6_DAC_IRQn);
  // Find this ptr in the allocation table <- linear..
  unsigned int start_address = (unsigned int)(allocation_array[0].address);
  unsigned int diff = (unsigned int)(ptr) - start_address;
  unsigned int index = diff / unit_block_size;
  
  // If the starting index of the block is not 0
  if (index != 0)
  {
    // Check for the value of the array at [index-1]
    int before_block_index = index-1;
    while (allocation_array[before_block_index].label > 0) // If positive
    {
      // Check it is not initial label
      if (allocation_array[before_block_index].label != HEAP_INITIAL_LABEL)
      {
        // The neighbor can be merged
        // Front merge
        // keep the label of the ptr
        // Jump to the head
        int new_head = index 
                        - (allocation_array[before_block_index].label);

        // Update the head label as the sum of ptr and current label
        allocation_array[new_head].label
          += -1 * (allocation_array[index].label);
        int tail_ptr = new_head + (allocation_array[new_head].label) - 1;

        int i;
        for (i = new_head+1; i < tail_ptr; ++i)
        {
          // Update the middle
          allocation_array[i].label = HEAP_INITIAL_LABEL;
        }

        // Update the new taii
        allocation_array[tail_ptr].label = allocation_array[new_head].label;
        index = new_head;
      }
      if (index == 0)
      {
        break;
      }
      before_block_index = index-1;
    }
  }

  int next_block_index = index + (-1* (allocation_array[index].label));
  int current_block_size = -1* (allocation_array[index].label);

  if (allocation_array[index].label > 0)
  {
    // If positive, front merge occur first
    next_block_index = index + (allocation_array[index].label);
    current_block_size = allocation_array[index].label;
  }

  // If a block does not exceed the maximum array index value
  if (next_block_index <= end_allocation_array)
  {
    // Check for the value of the array at
    while (allocation_array[next_block_index].label > 0)
    {
      if (allocation_array[next_block_index].label != HEAP_INITIAL_LABEL)
      {
        // This neighbor can be merged
        // BackMerge
        int new_tail = next_block_index 
                        + (allocation_array[next_block_index].label) - 1;
        int new_size = current_block_size + (allocation_array[next_block_index].label);
        allocation_array[index].label = new_size;
        int i = 0;
        for (i = index + 1; i < new_tail; ++i)
        {
          allocation_array[i].label = HEAP_INITIAL_LABEL;
        }
        allocation_array[new_tail].label = allocation_array[index].label;
        if (new_tail == end_allocation_array)
        {
          break;
        }
        else
        {
          next_block_index = new_tail + 1;
        }
      }
    }
  }

  // None of above cases
  // Label is still negative = unfreed
  if (allocation_array[index].label < 0)
  {
    allocation_array[index].label *= -1;
    int tail = index + (allocation_array[index].label) - 1;
    int i;
    for (i = index+1; i <= tail; ++i)
    {
      if (i == tail)
      {
        allocation_array[i].label = allocation_array[index].label;
      }
      else
      {
        allocation_array[i].label = HEAP_INITIAL_LABEL;
      }
    }
  }

  NVIC_EnableIRQ(TIM6_DAC_IRQn);
  return (unsigned int)(ptr);
} // end of OS_Malloc



/******************************************************************************
    OSp_ScheduleTask
        
******************************************************************************/
unsigned int
OSp_ScheduleTask(void)
{
  // Increment elapsed time
  // Only if current running task is not blocked
  if (OS_TaskRUNNING->taskState != OS_BLOCKED)
  {
    ++(OS_TaskRUNNING->elapsed_time);
  }
  
  // Get the ready list
  listObj *ready_list = OSp_GetList(INDEX_READY_LIST);
  if (ready_list)
  {
    // Check the list's highest priority job, do peek
    nodeObj *front_task = OSp_ListPeek(ready_list);

    front_task = OSp_ListPeekByTurn(ready_list);

    if (front_task)
    {
      // If current running task is blocked by semaphore
      if (OS_TaskRUNNING->taskState == OS_BLOCKED)
      {
        // No matter priority, switch the task
        front_task = OSp_ListPop(ready_list);
        OS_TaskNEW = (front_task->ptr);
        OS_TaskNEW->taskState = OS_RUNNING;
        return DISPATCHER_TASK_SWITCH;
      }

      // If the front task has higher priority(due to shorter deadline)
      // List has already been sorted in EDF
      if (1/* *(front_task->priority) > OS_TaskRUNNING->priority_level */)
      {
        // then the current task should be switched
        // Pop the front task
        //front_task = OSp_ListPop(ready_list);
        front_task = OSp_ListPopByTurn(ready_list);
        if (front_task)
        {
          // Set front_task as OS_TaskNEW
          OS_TaskNEW = (front_task->ptr);

          // Set new task's state to RUNNING
          OS_TaskNEW->taskState = OS_RUNNING;
          
          if (OS_TaskRUNNING->taskState == OS_RUNNING)
          {
            // Reset current running task's elapsed time
            OS_TaskRUNNING->elapsed_time = 0;

            // Set the running task's state to READY
            OS_TaskRUNNING->taskState = OS_READY;

            // Push the current running task to the READY list
            if (OSp_ListPush(ready_list, &nodes[OS_TaskRUNNING->taskID]))
            {
              // After pushing, sort ready_list by EDF
              OSp_ListSort(ready_list);
              return DISPATCHER_TASK_SWITCH; // done
            }
            else
            {
              // Something bad happend during PUSH
              OSp_SetError(ERROR_PUSH_TASK_READY_LIST);
              return 0;
            }
          }
          else if (OS_TaskRUNNING->taskState == OS_BLOCKED)
          {
            // Do not push running task in the ready list
            // Just change the task
            return DISPATCHER_TASK_SWITCH;
          }
        }
        else 
        {
          // Something bad happen during POP
          OSp_SetError(ERROR_POP_TASK_READY_LIST);
          return 0;
        }
      }
      else // front task has lower priority
      {
        // Higher priority task should not be changed if it owns semaphore
        // Check ownership, count, token, state
        if (OS_TaskRUNNING->taskID != TASK_IDLE_ID)
        {
          unsigned int semID = OS_TaskRUNNING->semaphoreID;
          // Check this task owns semaphore
          if (semID != 0x00)
          {
            unsigned int ownerID = Semaphores[semID].ownerID;
            if (ownerID == OS_TaskRUNNING->taskID)
            {
              // Should keep this task
              return DISPATCHER_TASK_CONTINUE;
            }
          }
        }


        // then check the current task's elapsed time
        if (OS_TaskRUNNING->elapsed_time >= OS_TaskRUNNING->execution_time)
        {
          // The currently running task is done
          // then the current task should be switched, and return to the ready list

          // Pop the front task
          front_task = OSp_ListPop(ready_list);
          if (front_task)
          {
            // Set front_task as OS_TaskNEW
            OS_TaskNEW = (front_task->ptr);
            OS_TaskNEW->taskState = OS_RUNNING;
          
            // Reset some of current running task's elapsed time
            OS_TaskRUNNING->elapsed_time = 0;
            OS_TaskRUNNING->taskState = OS_READY;

            // Push the current running task
            if (OSp_ListPush(ready_list, &nodes[OS_TaskRUNNING->taskID]))
            {
              // After pushing, sort ready_list by EDF
              OSp_ListSort(ready_list);
              return DISPATCHER_TASK_SWITCH; // done
            }
            else
            {
              // Something bad happend during PUSH
              OSp_SetError(ERROR_PUSH_TASK_READY_LIST);
              return 0; 
            }
          }
          else
          {
            // Something bad happen during POP
            OSp_SetError(ERROR_POP_TASK_READY_LIST);
            return 0; 
          }
        }
        else
        {
          // not equal, then keep the current task
          return DISPATCHER_TASK_CONTINUE;
        }
      }
    }
    else // no front task, means empty ready list
    {
      // Reset elapsed time
      OS_TaskRUNNING->elapsed_time = 0;

      // Keep idle task
      return DISPATCHER_TASK_CONTINUE;
    }
  }
  else
  {
    // no list, error
    OSp_SetError(ERROR_NO_READY_LIST);
    return 0; 
  }
} // end OSp_ScheduleTask

/******************************************************************************
    OSp_SetError
		
      Sets the value of a hidden variable that stores the currently reported
      kernel error. If a kernel function detects a problem(null pointers, for
      just one example), the function should write out an error code using
      this function and return zero.
      It is then up to the calling function to invoke 'OS_GetError' in order
      to process the error and take action, if desired.
******************************************************************************/
void
OSp_SetError(kernelErrors code)
{
  error_code = code;
} // end OSp_SetError

/******************************************************************************
    OSp_GetList
		
      Returns the pointer to the selected linked list.
******************************************************************************/
listObj *
OSp_GetList (unsigned int list) {
    static listObj lists[MAX_LISTS];

    if (list > MAX_LISTS-1)
    {
      OSp_SetError(ERROR_ACCESSING_OUT_OF_BOUND_LISTS);
      return 0;
    }

    return &lists[list];
} // end OSp_GetList

/******************************************************************************
    OSp_ListPush
		
    Inserts the given node into the given list based on the 
    current priority level of the node.  It is implicitly assumed that 
    higher priority values are better than lower ones.

    credited by Christopher Theriault
******************************************************************************/
unsigned int
OSp_ListPush (listObj *list, nodeObj *newEntry) {
    unsigned int insert;
    unsigned int i;

    // Check the error conditions
    if (!list || !newEntry || (list->listSize == MAX_LIST_SIZE)) {
        return SYSTEM_ERROR;
    } // end if

    // Special case: list is empty
    if (!list->listSize) {
        list->nodes[0x00] = newEntry;
    } // end if
    else { // List is not empty
        insert = list->listSize;
        // Count back to find the insertion point
        while (insert && 
      (list->nodes[insert - 0x01]->priority >= newEntry->priority)) {
            insert--;
        } // end while
        // Move down the end items in the list if needed
        if (insert != list->listSize) {
            for (i = list->listSize; i > insert; i--) {
                list->nodes[i] = list->nodes[i - 0x01];
            } // end for
        } // end if
        list->nodes[insert] = newEntry;
    } // end else
    
    list->listSize++;
    
    return NO_ERROR;

} // end OSp_ListPush

/******************************************************************************
    OSp_ListPop

    Returns the highest priority node which should be at the end of 
    the list, and removes the node.
        
    credited by Christopher Theriault
******************************************************************************/
nodeObj *
OSp_ListPop (listObj * list) {
    nodeObj *pop = 0x00;

    if (list->listSize) {
         pop = list->nodes[list->listSize - 0x01];
        list->nodes[list->listSize - 0x01] = 0x00;
        list->listSize--;
    } // end if

    return pop;

} // end OSp_ListPop

/******************************************************************************
    OSp_ListPopByTurn

******************************************************************************/
nodeObj *
OSp_ListPopByTurn (listObj * list)
{
  nodeObj *pop = 0x00;

  if (list->listSize)
  {
    int i;
    for (i = (list->listSize) - 0x01; i >= 0; --i)
    {
      int TaskID = list->nodes[i]->ptr->taskID;

      if (TaskID == 1) // BLUE
      {
        if (whoTurn == EVENT_BLUE)
        {
          pop = list->nodes[i];
          list->nodes[i] = 0x00;
          OSp_ListShrink(list);
          break;
        }
      }
      else if (TaskID == 2) // RED
      {
        if (whoTurn == EVENT_RED)
        {
          pop = list->nodes[i];
          list->nodes[i] = 0x00;
          OSp_ListShrink(list);
          break;
        }
      }
      else if (TaskID == 3) // GREEN
      {
        if (whoTurn == EVENT_GREEN)
        {
          pop = list->nodes[i];
          list->nodes[i] = 0x00;
          OSp_ListShrink(list);
          break;
        }
      }
      else
      {
        continue;
      }
    }
  }

  return pop;
} // end OSp_ListPop

/******************************************************************************
    OSp_BlockListPop

    Returns the highest priority node waiting for the given semaphore
    in the list, and removes the node.        
******************************************************************************/
nodeObj *
OSp_BlockListPop (listObj * list, unsigned int semaphoreID)
{
  nodeObj *pop = 0x00;

  if (list->listSize)
  {
    unsigned int i;
    for (i = (list->listSize) - 0x01; i >= 0; --i)
    {
      if ((list->nodes[i]->ptr->semaphoreID) == semaphoreID)
      {
        pop = list->nodes[i];
        list->nodes[i] = 0x00;
        OSp_ListShrink(list);
        break;
      }
    }
  }

  return pop;
}

/******************************************************************************
    OSp_ListShrink

    Shrink the list so that there is no empty node in the list
    Assuming this function is called right after the block list pops
******************************************************************************/
void
OSp_ListShrink(listObj *list)
{
  if (list)
  {
    unsigned int i;
    for (i = 0; i < list->listSize; ++i)
    {
      if (list->nodes[i] == 0x00)
      {
        // If the last node
        if (i == (list->listSize-0x01))
        {
          // Just shrink the size value
          --(list->listSize);
        }
        else
        {
          // Pull the next node to the front
          list->nodes[i] = list->nodes[i+1];
          list->nodes[i+1] = 0x00;
        }
      }
    }
  }
}

/******************************************************************************
    OSp_ListPeek
		
    Returns the highest priority task which should be at the end of 
    the list, but does not remove the node.

    credited by Christopher Theriault
******************************************************************************/
nodeObj *
OSp_ListPeek (listObj * list) {
    nodeObj *peek = 0x00;

    if (list->listSize) {
        peek = list->nodes[list->listSize - 0x01];
    } // end if

    return peek;

} // end OSp_ListPeek

/******************************************************************************
    OSp_ListPeekByTurn
	
******************************************************************************/
nodeObj *
OSp_ListPeekByTurn (listObj * list)
{
  nodeObj *peek = 0x00;

  if (list->listSize)
  {
    int i;
    for (i = 0; i < list->listSize; ++i)
    {
      peek = list->nodes[i];
      int taskID = peek->ptr->taskID;
      if (taskID == 1) // BLUE
      {
        if (whoTurn == EVENT_BLUE)
        {
          return peek;
        }
      }
      else if (taskID == 2) // RED
      {
        if (whoTurn == EVENT_RED)
        {
          return peek;
        }
      }
      else if (taskID == 3) // GREEN
      {
        if (whoTurn == EVENT_GREEN)
        {
          return peek;
        }
      }
      else // IDLE
      {
        continue;
      }
    }
  } // end if
  return 0;
} // end OSp_ListPeek

/******************************************************************************
    OSp_ListSort
		
    Sorts the list in order of increasing priority.
    begin .............. end
    highest deadline  >  lowest deadline
    lowest priority   <  highest priority
    lowest value      <  highest value

    credited by Christopher Theriault
******************************************************************************/
void
OSp_ListSort (listObj * list) {
    // Only act if we have a valid list
    if (list)
    {
      unsigned int rhs;
      // Check from the end
      for (rhs = (list->listSize)-1; rhs > 0; --rhs)
      {
        unsigned int lhs = rhs-1;
        // i:rhs, i-1: lhs
        // rhs should always have lower deadline and higher priority/value

        // Check rhs has lower deadline
        if (list->nodes[lhs]->ptr->deadline > list->nodes[rhs]->ptr->deadline)
        {
          // Check rhs has the higher priority
          if (*(list->nodes[lhs]->priority) > *(list->nodes[rhs]->priority))
          {
            // Swap the priority only, not the position in the list
            unsigned int lhs_priority = *(list->nodes[lhs]->priority);

            *(list->nodes[lhs]->priority) = *(list->nodes[rhs]->priority);
            *(list->nodes[rhs]->priority) = lhs_priority;
          }
        }
        else 
        {
          // lhs has lower deadline
          nodeObj *temp = list->nodes[rhs]; // copy the address
          list->nodes[rhs] = list->nodes[lhs];
          list->nodes[lhs] = temp;

          // After swap, take care of priority
          // the priority of rhs should be always greater then that of lhs
          if (*(list->nodes[lhs]->priority) > *(list->nodes[rhs]->priority))
          {
            unsigned int temp = *(list->nodes[rhs]->priority);
            *(list->nodes[rhs]->priority) = *(list->nodes[lhs]->priority);
            *(list->nodes[rhs]->priority) = temp;
          }
          // else, fine
        }
      }
    } // end if
	
} // end OSp_ListSort


/******************************************************************************
    OSp_AllocateInit

    - Initialize memory manager objects as needed.
    - The heap is divided into allocation blocks each of size 'blockSize'.
    - Create an allocation table that stores the pointers to the start of
      each allocation block and whether the block is free or has been 
      allocated. The memory manager will interact with the allocation table
      when awarding or releasing memory.
    - An error is returned if 'blockSize' is not 8-byte aligned, is zero,
      is greater than half the size of the heap, or does not evenly divide
      the heap.
    - On success, return back the number of allocatin blocks.
******************************************************************************/
unsigned int
OSp_AllocateInit (unsigned int blockSize)
{
  // Check whether the parameter is zero
  if (blockSize == 0)
  {
    // the given blockSize is zero
    OSp_SetError(ERROR_INIT_ALLOC_TABLE_BLKSIZE_ZERO);
    return 0;
  }

  // Check whether the paramter is 8-byte aligned
  if (blockSize % 8 != 0)
  {
    // The parameter is not 8-byte aligned
    OSp_SetError(ERROR_INIT_ALLOC_TABLE_BLKSIZE_NOT_8BIT_ALIGNED);
    return 0;
  }

  // Check whether the parameter is greater than half the size of the heap
  if (blockSize > (MINIMUM_TOTAL_HEAP / 2))
  {
    // The parameter is greater than half the size of the heap
    OSp_SetError(ERROR_INIT_ALLOC_TABLE_BLKSIZE_GREATHER_THEN_HALFHEAP);
    return 0;
  }

  // Check whether the parameter does not divide the heap evenly
  if (MINIMUM_TOTAL_HEAP % blockSize != 0)
  {
    // The paramter does not divide the heap evenly
    OSp_SetError(ERROR_INIT_ALLOC_TABLE_BLKSIZE_NOT_DIVIDING_EVENLY);
    return 0;
  }

  // Compute the number of entries
  num_entry_allocation_array = MINIMUM_TOTAL_HEAP / blockSize;
  unit_block_size = blockSize;

  // allocation map wil start from 0 to num_entries-1
  end_allocation_array = num_entry_allocation_array-1;

  // Place the initial range
  allocation_array[0].label = num_entry_allocation_array;
  allocation_array[end_allocation_array].label = num_entry_allocation_array;

  // Assign address to each entry
  int i;
  for (i = 0; i < num_entry_allocation_array; ++i)
  {
    if ((i != 0) && (i != end_allocation_array))
    {
      allocation_array[i].label = HEAP_INITIAL_LABEL;
    }
    allocation_array[i].address = (void *)(&Heap[i *blockSize]);
  }


  /*
  void *test3 = OS_Malloc(3*32); // 3*32 bytes
  void *test2 = OS_Malloc(2*32); // 2*32 bytes
  void *test4 = OS_Malloc(4*32); // 4*32 bytes
  OS_Free(test2);
  OS_Free(test4);
  OS_Free(test3);
  */

  return num_entry_allocation_array;
} // end of OSp_AllocateInit

// EOF    Kernel.c
// Note: Some IDEs generate warnings if a file doesn't end in whitespace,
//  but Embedded Studio doesn't seem to be one of them.