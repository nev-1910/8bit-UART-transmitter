# defaults

SIM ?= icarus
FST ?= 1

TOPLEVEL_LANG = verilog
TOPLEVEL = tt_um_uart_tx

SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = project.v

ifeq ($(GATES),yes)

# Gate level simulation

SIM_BUILD = ./sim_build/gl

COMPILE_ARGS += -DGL_TEST
COMPILE_ARGS += -DFUNCTIONAL
COMPILE_ARGS += -DUSE_POWER_PINS
COMPILE_ARGS += -DSIM
COMPILE_ARGS += -DUNIT_DELAY=#1

VERILOG_SOURCES += $(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/gf180mcu_fd_sc_mcu7t5v0.v

# Generated gate-level netlist
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v

else

# RTL simulation

SIM_BUILD = ./sim_build/rtl

VERILOG_SOURCES = $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))

endif

# Include testbench
VERILOG_SOURCES += $(PWD)/tb.v

# Include directory
COMPILE_ARGS += -I$(SRC_DIR)

# Python test module
COCOTB_TEST_MODULES = test

include $(shell cocotb-config --makefiles)/Makefile.sim
