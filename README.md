Expected directory structure:

STM32F4xx_DSP_StdPeriph_Lib_V1.X.X\

	Libraries\ 		(contains all standard peripheral libraries) 
		CMSIS\
		STM32F4xx_StdPeriph_Driver\
		
	Project\   		(contains all project files; git clone here)
		STM32F4xx_Makefile_Test\
	
	Utilities\  	(more drivers and/or third party libraries)
		ST\
		Third_Party\
	
HOW-TO:	
	- Run make in STM32F4xx_Makefile_Test to obtain STM32F4xx_Makefile_Test.hex
	- Use STMFlashLoader to flash the hex file to the microcontroller

TODO: 
	- make burn command for automatic flashing