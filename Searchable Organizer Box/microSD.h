

enum typeOfWrite
{
  COMMAND,                              // the transmission is an LCD command
  DATA                                  // the transmission is data
};


enum name_type
{
	SHORT_NAME,
	LONG_NAME
};


enum get_subdirs
{
	GET_SUBDIRS,
	NO_SUBDIRS
};



void microSD_Init(void);

unsigned long microSD_FindAvailableAddress(void);

unsigned char microSD_SendCommand(unsigned char _CMD, unsigned long _Argument);

void microSD_read_disk_data(void);

void microSD_read_first_sector(void);

long microSD_list_dirs_and_files(long next_cluster,enum name_type name, enum get_subdirs subdirs);

void microSD_clean_name(void);

unsigned int microSD_rcvr_datablock(unsigned char *buff, unsigned int btr);

void microSD_rcvr_spi_m(unsigned char *dst);

long microSD_get_root_dir_first_cluster(void);

int microSD_CheckAddressValid(unsigned long _mSD_Address);

void microSD_Write_SingleBlock(char *_Buffer, int _BufferCount, unsigned long *_mSD_CurrentAvailbleAddress);

int microSD_Read_SingleBlock(unsigned char *_Data_mSD, unsigned long _mSD_CurrentAvailbleAddress);
