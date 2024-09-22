cmake_minimum_required(VERSION 3.10)

# Project name
project(stm32_no_hal_project C CXX ASM)

# Set compiler
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)

# Set CPU and FPU flags for STM32F103C8
set(CPU_FLAGS "-mcpu=cortex-m3 -mthumb")

# Linker script location
set(LINKER_SCRIPT "${CMAKE_SOURCE_DIR}/linker/stm32f103xb.ld")

# Compiler flags
set(CMAKE_CXX_FLAGS "${CPU_FLAGS} -Wall -O3")
set(CMAKE_C_FLAGS "${CPU_FLAGS} -Wall -O3")
set(CMAKE_ASM_FLAGS "${CPU_FLAGS} -Wall -O3")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "-T ${LINKER_SCRIPT} -nostartfiles -Wl,--gc-sections")

# Add source files (main.cpp and startup)
file(GLOB_RECURSE SOURCES "src/*.cpp")
set(STARTUP_FILE "${CMAKE_SOURCE_DIR}/startup/startup_stm32f103xb.s")

# Define the executable target
add_executable(${PROJECT_NAME}.elf ${SOURCES} ${STARTUP_FILE})

# Post-build: Convert ELF to binary and flash using stlink
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
    COMMAND st-flash --reset write ${PROJECT_NAME}.bin 0x8000000
)

