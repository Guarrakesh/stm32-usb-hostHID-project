# HOW TO USE THIS MAKEFILE 
#  if on STMF407... you only need to configure the correct path(and name) for original project and STM32F4CUBE platform 
#  > make prepare            
#  > make                           # build the default target (USBdemo.bin)
#  > make debug                     # run the GDB debugger
#  > make clean                     # remove all temporary files in the working directories (obj, dep, bin)


# custom PHONY targets:
#
#  > make prepare                   # copy all source files to a working directory (src), both files which need only compilation (platform) and files which need customization (user and include)
#  > make create-orig               # copy srcs to customize (from the original project demo) in a orig folder, so that you have these clean files to customize again 
#  > make restore-src-from-orig     # restore src and include custom file files at their clean state(like orig)

include .env

#  +++ CHECK ALL THE SETTINGS BELOW AND ADAPT THEM IF NEEDED +++


# example project name generated with cubeIDE
EXAMP_NAME = usb_cube_project
# example project directory generated with cubeIDE
APP_DIR    = ../$(EXAMP_NAME)
# path to the root folder of the STM32Cube platform
STM_DIR   = ../STM32CubeF4

# 3333 for openocd. 61234 for st-link gdbserver
GDB_SERVER_PORT = ${DEBUG_PORT}
GDB_SERVER_HOST = ${DEBUG_SERVER}

# default target and name of the image and executable files to generate
TARGET     = USBdemo

# Board and MCU  names as used in the linker script path and file name, e.g. "$(STM_DIR)/Demonstrations/SW4STM32/STM32F4-DISCO/STM32F407VGTx_FLASH.ld"
BOARD_UC   = STM32F4-DISCO
MCU_UC     = STM32F407VG

# board name as used in the STM32cube Drivers/BSP folder, e.g. "$(STM_DIR)/Drivers/BSP/STM32F4-Discovery"
BSP_BOARD   = STM32F4-Discovery

# MCU name as used in the .s source file name, e.g. "startup_stm32f407xx.s"
MCU_LC     = stm32f407xx

# pre-processor symbol to be defined for the compilation (will be used in a -Dxxx flag in gcc)
MCU_MC     = STM32F407xx


###############################################################################
# Directories

BSP_DIR    = $(STM_DIR)/Drivers/BSP
HAL_DIR    = $(STM_DIR)/Drivers/STM32F4xx_HAL_Driver

CMSIS_DIR  = $(STM_DIR)/Drivers/CMSIS
DEV_DIR    = $(CMSIS_DIR)/Device/ST/STM32F4xx
USB_DIR    = $(STM_DIR)/Middlewares/ST/STM32_USB_Host_Library

####
####




###############################################################################
# Source files



# headers to customize, taken from the stmcube generated project 
CUSTOM_INC = \
$(APP_DIR)/Core/Inc/main.h \
$(APP_DIR)/Core/Inc/stm32f4xx_it.h \
$(APP_DIR)/Core/Inc/stm32f4xx_hal_conf.h \
$(APP_DIR)/USB_HOST/App/usb_host.h \
$(APP_DIR)/USB_HOST/Target/usbh_conf.h \
$(APP_DIR)/USB_HOST/Target/usbh_platform.h \

# sources to customize, taken from the stmcube generated project 
CUSTOM_SRCS = \
$(APP_DIR)/Core/Src/main.c \
$(APP_DIR)/Core/Src/stm32f4xx_hal_msp.c \
$(APP_DIR)/Core/Src/stm32f4xx_it.c \
$(APP_DIR)/Core/Src/system_stm32f4xx.c \
$(APP_DIR)/USB_HOST/App/usb_host.c \
$(APP_DIR)/USB_HOST/Target/usbh_conf.c \
$(APP_DIR)/USB_HOST/Target/usbh_platform.c \
#$(APP_DIR)/Core/Src/syscalls.c \
#$(APP_DIR)/Core/Src/sysmem.c \

SRCS =\
$(HAL_DIR)/Src/stm32f4xx_hal.c \
$(HAL_DIR)/Src/stm32f4xx_hal_cortex.c \
$(HAL_DIR)/Src/stm32f4xx_hal_dma.c \
$(HAL_DIR)/Src/stm32f4xx_hal_flash.c \
$(HAL_DIR)/Src/stm32f4xx_hal_flash_ex.c \
$(HAL_DIR)/Src/stm32f4xx_hal_gpio.c \
$(HAL_DIR)/Src/stm32f4xx_hal_hcd.c \
$(HAL_DIR)/Src/stm32f4xx_hal_pwr.c \
$(HAL_DIR)/Src/stm32f4xx_hal_rcc.c \
$(HAL_DIR)/Src/stm32f4xx_ll_fsmc.c \
$(HAL_DIR)/Src/stm32f4xx_ll_usb.c \
$(USB_DIR)/Class/HID/Src/usbh_hid.c \
$(USB_DIR)/Class/HID/Src/usbh_hid_keybd.c \
$(USB_DIR)/Class/HID/Src/usbh_hid_mouse.c \
$(USB_DIR)/Class/HID/Src/usbh_hid_parser.c \
$(USB_DIR)/Core/Src/usbh_core.c \
$(USB_DIR)/Core/Src/usbh_ctlreq.c \
$(USB_DIR)/Core/Src/usbh_ioreq.c \
$(USB_DIR)/Core/Src/usbh_pipes.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_adc.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_can.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_crc.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_cryp.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_dac.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_dcmi.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_i2c.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_i2s.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_irda.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_iwdg.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_nand.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_nor.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_pccard.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_pcd.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_pcd_ex.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_rng.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_rtc.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_sd.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_smartcard.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_spi.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_sram.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_tim.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_tim_ex.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_uart.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_usart.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_wwdg.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_eth.c \
#$(HAL_DIR)/Src/stm32f4xx_hal_hash.c \	
#$(HAL_DIR)/Src/stm32f4xx_ll_sdmmc.c \
#$(BSP_DIR)/Components/lis302dl/lis302dl.c \
#$(BSP_DIR)/Components/lis3dsh/lis3dsh.c \
#$(BSP_DIR)/$(BSP_BOARD)/stm32f4_discovery.c \
#$(BSP_DIR)/$(BSP_BOARD)/stm32f4_discovery_accelerometer.c \


# remove paths from the file names
SRCS_FN = $(notdir $(SRCS))


# filename of customfiles only 
CUSTOM_SRC_FN = $(notdir $(CUSTOM_SRCS))


LDFILE     = $(APP_DIR)/STM32F407VGTX_FLASH.ld


###############################################################################
# Tools

PREFIX     = arm-none-eabi
CC         = $(PREFIX)-gcc
AR         = $(PREFIX)-ar
OBJCOPY    = $(PREFIX)-objcopy
OBJDUMP    = $(PREFIX)-objdump
SIZE       = $(PREFIX)-size
GDB        = $(PREFIX)-gdb
OCD        = openocd

###############################################################################
# Options

# Defines (-D flags)
DEFS       = -D$(MCU_MC) -DUSE_HAL_DRIVER
DEFS       += -DUSE_DBPRINTF

# Include search paths (-I flags)
INCS      = -I$(STM_DIR)/Drivers/CMSIS/Include
INCS      += -I$(STM_DIR)/Drivers/CMSIS/Device/ST/STM32F4xx/Include
INCS      += -I$(STM_DIR)/Drivers/STM32F4xx_HAL_Driver/Inc
INCS      += -I$(STM_DIR)/Drivers/BSP/STM32F4-Discovery
INCS      += -I$(STM_DIR)/Middlewares/ST/STM32_USB_Host_Library/Core/Inc
INCS      += -I$(STM_DIR)/Middlewares/ST/STM32_USB_Host_Library/Class/HID/Inc
INCS      += -I$(STM_DIR)/Drivers/BSP/Components/lis302dl
INCS      += -I$(STM_DIR)/Drivers/BSP/Components/lis3dsh
INCS	  += -I./include

####
####
# includes needed for integrated lcd on f412g
#INCS      += -I$(STM_DIR)/Utilities/Log
#INCS      += -I$(STM_DIR)/Drivers/BSP/$(PORTED_MCU_NOF)

# Library search paths (-L flags)
LIBS       = -L$(CMSIS_DIR)/Lib

# Compiler flags
CFLAGS     = -Wall -g -std=c99 -Os
CFLAGS    += -mlittle-endian -mcpu=cortex-m4 -march=armv7e-m -mthumb
CFLAGS    += -mfpu=fpv4-sp-d16 -mfloat-abi=hard
CFLAGS    += -ffunction-sections -fdata-sections
CFLAGS    += $(INCS) $(DEFS)

# Linker flags
LDFLAGS    = -Wl,--gc-sections -Wl,-Map=$(TARGET).map $(LIBS) -Tsrc/linker/linkerScript.ld

# Enable Semihosting
LDFLAGS   += --specs=rdimon.specs -lc -lrdimon
#LDFLAGS   += --specs=nosys.specs --specs=nano.specs --specs=rdimon.specs -lc -lrdimon

# Source search paths
VPATH      = ./src/user
VPATH	  += ./src/platform

# Debugger flags
GDBFLAGS   =

# generate OBJS and DEPS target lists by prepending obj/ and dep prefixes
OBJS       = $(addprefix obj/,$(SRCS_FN:.c=.o))
OBJS       += $(addprefix obj/,$(CUSTOM_SRC_FN:.c=.o))
DEPS       = $(addprefix dep/,$(SRCS_FN:.c=.d))
DEPS       += $(addprefix dep/,$(CUSTOM_SRC_FN:.c=.d))

###################################################

.PHONY: all dirs debug prepare clean restore-src-from-orig create-orig delete-src delete-orig
	
all: $(TARGET).bin

-include $(DEPS)

dirs: dep obj

dep obj include:
	@echo "[MKDIR]   $@"
	mkdir -p $@

src:
	@echo "[MKDIR]   $@"
	mkdir -p $@
	mkdir -p $@/user
	mkdir -p $@/platform
	mkdir -p $@/linker
	
orig:
	@echo "[MKDIR]   $@"
	mkdir -p $@
	mkdir -p $@/src
	mkdir -p $@/src/user
	mkdir -p $@/include

obj/%.o : %.c | dirs
	@echo "generating \"$@\" from \"$<\""
	$(CC) $(CFLAGS) -c -o $@ $< -MMD -MF dep/$(*F).d

$(TARGET).elf: $(OBJS)
	@echo "[LD]###################"
	@echo "[LD]###################"
	@echo "[LD]###################"
	@echo "[LD]      $(TARGET).elf"
	$(CC) $(CFLAGS) $(LDFLAGS) src/platform/startup_stm32f407vgtx.s $^ -o $@
	@echo "[OBJDUMP] $(TARGET).lst"
	$(OBJDUMP) -St $(TARGET).elf >$(TARGET).lst
	@echo "[SIZE]    $(TARGET).elf"
	$(SIZE) $(TARGET).elf

$(TARGET).bin: $(TARGET).elf
	@echo "[OBJCOPY] $(TARGET).bin"
	$(OBJCOPY) -O binary $< $@
	mkdir -p bin
	mv $(TARGET).* bin

debug:
	@if ! nc -z $(GDB_SERVER_HOST) $(GDB_SERVER_PORT); then \
		echo "\n\t[Error] gdbserver is not running!\n"; exit 1; \
	else \
	$(GDB)  -ex "file bin/$(TARGET).elf" \
			-ex "target extended-remote $(GDB_SERVER_HOST):$(GDB_SERVER_PORT)" \
			-ex "load bin/$(TARGET).elf" \
			-ex "monitor arm semihosting enable" \
			-ex "monitor reset halt" \
			-ex "monitor reset init"; \
	fi
	
prepare: src include
	cp $(SRCS) src/platform
	cp $(CUSTOM_INC) include/
	cp $(CUSTOM_SRCS) src/user
	cp $(APP_DIR)/Core/Startup/startup_stm32f407vgtx.s src/platform
	cp $(LDFILE) src/linker/linkerScript.ld
	
create-orig: orig
	cp $(CUSTOM_SRCS) orig/src/user
	cp $(CUSTOM_INC) orig/include
	
restore-src-from-orig:
	cp orig/src/user/* src/user
	cp orig/include/* include/

clean:
	@echo "[RMDIR]   bin"          ; rm -fr bin
	@echo "[RMDIR]   dep"          ; rm -fr dep
	@echo "[RMDIR]   obj"          ; rm -fr obj
	
delete-src:
	@echo "[RMDIR]   src"          ; rm -fr src
	
delete-orig:
	@echo "[RMDIR]   orig"          ; rm -fr orig
