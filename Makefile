TARGET=STM32F4xx_Makefile_Test.hex
EXECUTABLE=STM32F4xx_Makefile_Test.elf

CC=arm-none-eabi-gcc
#LD=arm-none-eabi-ld 
LD=arm-none-eabi-gcc
AR=arm-none-eabi-ar
AS=arm-none-eabi-as
CP=arm-none-eabi-objcopy
OD=arm-none-eabi-objdump

BIN=$(CP) -O ihex

DEFS = -DUSE_STDPERIPH_DRIVER -DSTM32F4XX -DSTM32F40_41xxx -DUSE_USB_OTG_FS -DHSE_VALUE=8000000

MCU = cortex-m4
MCFLAGS = -mcpu=$(MCU) -mthumb -mlittle-endian -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork  
#-mfpu=fpa -mfloat-abi=hard -mthumb-interwork  
STM32_INCLUDES = -I./inc/ \
	-I../../Libraries/CMSIS/ST/STM32F4xx/Include/ \
	-I../../Libraries/CMSIS/Include/ \
	-I../../Libraries/STM32F4xx_StdPeriph_Driver/inc/  \
	-I../../Libraries/CMSIS/Device/ST/STM32F4xx/Include

OPTIMIZE 	= -Os

CFLAGS	= $(MCFLAGS)  $(OPTIMIZE)  $(DEFS) -I./ $(STM32_INCLUDES)  -Wl,-T,stm32f4xx_flash.ld
AFLAGS	= $(MCFLAGS) 

SRC = ./src/*.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_syscfg.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/misc.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_adc.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_dma.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_exti.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_flash.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_gpio.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_i2c.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_rcc.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_spi.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_tim.c \
	../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_dac.c 

STARTUP = ../../Libraries/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc_ride7/startup_stm32f40xx.s

OBJDIR = .
OBJ = $(SRC:%.c=$(OBJDIR)/%.o) 
OBJ += Startup.o


all: $(TARGET)

$(TARGET): $(EXECUTABLE)
	$(CP) -O ihex $^ $@

# --specs=nosys.specs added to suppress error "undefined reference to _exit()"
# refer to http://stackoverflow.com/questions/19419782/exit-c-text0x18-undefined-reference-to-exit-when-using-arm-none-eabi-gcc
$(EXECUTABLE): $(SRC) $(STARTUP)
	$(CC) --specs=nosys.specs $(CFLAGS) $^ -o $@ 

clean:
	rm -f Startup.lst  $(TARGET)  $(EXECUTABLE) *.lst $(OBJ) $(AUTOGEN)  *.out *.map \
	 *.dmp