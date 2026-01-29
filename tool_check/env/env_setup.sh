#!/usr/bin/env bash
# --------------------------------------------------
# Copyright
# --------------------------------------------------
#
# Tech Aarvam
# Copyright (c) 2026 Tech Aarvam.
# Author: Ram (Ramasubramanian B)

set -e

# License (Synopsys)
export SNPSLMD_LICENSE_FILE="27000@<license_server>"
export LM_LICENSE_FILE=$SNPSLMD_LICENSE_FILE

# Synopsys installs
export VCS_HOME="<VCS_INSTALL_DIR>"          # root that contains linux64/bin/vcs
export VERDI_HOME="<VERDI_INSTALL_DIR>"      # root that contains bin/verdi
export VC_STATIC_HOME="<VCF_INSTALL_DIR>"    # root that contains bin/vcf
export DC_HOME="<DC_INSTALL_DIR>"            # root that contains bin/dc_shell (or linux64/syn/bin)

# Cadence JasperGold
export JASPER_HOME="<JASPER_INSTALL_DIR>"    # root that contains bin/jg

# ICC2
export ICC2_HOME="<ICC2_INSTALL_DIR>"        # root that contains bin/icc2_shell

# Optional: make these tools appear in PATH (nice for manual checks)
export PATH="$VCS_HOME/linux64/bin:$VERDI_HOME/bin:$VC_STATIC_HOME/bin:$JASPER_HOME/bin:$ICC2_HOME/bin:$PATH"

# Verdi runtime helper (some sites need this)
export VERDI_ARCH_OVERRIDE=LINUX64
