cmake_minimum_required(VERSION 3.15)

if (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
	set(toolchain_dir      "${CMAKE_CURRENT_LIST_DIR}/../win__arm-eabi-gcc_13_2_1")
else()
	message(STATUS "${CMAKE_HOST_SYSTEM_NAME}")
	message(SEND_ERROR "Host OS ${CMAKE_HOST_SYSTEM_NAME} is not supported")
endif()

set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_VERSION    13.2.1)
set(CMAKE_SYSTEM_PROCESSOR  STM32C0xx)

set(TOOLS_DIR          "${CMAKE_CURRENT_LIST_DIR}/../utility")
set(toolchain_bin_dir  "${toolchain_dir}/bin")
set(toolchain_inc_dir  "${toolchain_dir}/arm-none-eabi/include")
set(toolchain_lib_dir  "${toolchain_dir}/arm-none-eabi/lib")


set(ARM_OPTIONS
 -mcpu=cortex-m0plus
 -mthumb
)



add_compile_options(
 ${ARM_OPTIONS}
 -ggdb
 -fno-builtin
 -ffunction-sections
 -fdata-sections
 -fomit-frame-pointer
 "$<$<COMPILE_LANGUAGE:CXX>:-fno-unwind-tables>"
 "$<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>"
 "$<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>"
 -MD
 -MF
 --specs=nano.specs
 --specs=nosys.specs
)

add_link_options(
 ${ARM_OPTIONS}
 -Wl,-gc-sections
 -Wl,--print-memory-usage
 -Wl,--no-warn-rwx-segments
 -Wl,-lstdc++
 --specs=nano.specs
 --specs=nosys.specs
)


set(CMAKE_C_COMPILER   "${toolchain_bin_dir}/arm-none-eabi-gcc.exe")
set(CMAKE_CXX_COMPILER "${toolchain_bin_dir}/arm-none-eabi-g++.exe")
set(CMAKE_ASM_COMPILER "${toolchain_bin_dir}/arm-none-eabi-gcc.exe")
set(CMAKE_OBJCOPY      "${toolchain_bin_dir}/arm-none-eabi-objcopy.exe")
set(CMAKE_SIZE         "${toolchain_bin_dir}/arm-none-eabi-size.exe")

set(CMAKE_EXECUTABLE_SUFFIX ".elf")
set(CMAKE_FIND_ROOT_PATH "${toolchain_dir}")

set(CMAKE_TRY_COMPILE_TARGET_TYPE     STATIC_LIBRARY)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)



