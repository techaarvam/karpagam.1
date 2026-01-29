# --------------------------------------------------
# Copyright
# --------------------------------------------------
#
# Tech Aarvam
# Copyright (c) 2026 Tech Aarvam.
# Author: Ram (Ramasubramanian B)

SHELL := /bin/bash

# Use env vars if already exported; otherwise allow default placeholders
VCS_HOME       ?=
VERDI_HOME     ?=
VC_STATIC_HOME ?=
JASPER_HOME    ?=
ICC2_HOME      ?=
DC_HOME        ?=

ENV_SCRIPT := ./env/env_setup.sh

# Helper: source env for every recipe
define USE_ENV
source $(ENV_SCRIPT);
endef

ifeq ($(DEBUGPP), 1)
  COMPILE_EXTRA_ARGS=-debug_pp
  RUN_EXTRA_ARGS=-gui
endif

all: comp run urg

comp:
	@$(USE_ENV) \
	"$$VCS_HOME/linux64/bin/vcs" -full64 -kdb $(COMPILE_EXTRA_ARGS) +v2k -cm line -sverilog \
	  ./rtl/counter.v ./dv/tb.v -l comp.log

run:
	@$(USE_ENV) \
	env VERDI_ARCH_OVERRIDE=$$VERDI_ARCH_OVERRIDE ./simv $(RUN_EXTRA_ARGS) -cm line -l run.log

urg:
	@$(USE_ENV) \
	"$$VCS_HOME/linux64/bin/urg" -dir ./simv.vdb

jg:
	@$(USE_ENV) \
	"$$JASPER_HOME/bin/jg" -tcl ./jg.tcl

vcf:
	@$(USE_ENV) \
	env VC_STATIC_HOME=$$VC_STATIC_HOME "$$VC_STATIC_HOME/bin/vcf" -f vcf.tcl

# Manual tool “sign-of-life” helpers
dc_shell:
	@$(USE_ENV) \
	"$$DC_HOME/bin/dc_shell" -64

icc2_shell:
	@$(USE_ENV) \
	"$$ICC2_HOME/bin/icc2_shell"
