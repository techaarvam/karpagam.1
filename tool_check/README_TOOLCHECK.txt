
Tech Aarvam – EDA Tool Check (Signs-of-Life)
=====================================

This package is meant to verify that required EDA tools are installed
and licensed correctly on the college systems.
No prior chip-design knowledge is assumed.

--------------------------------------------------
Folder layout
--------------------------------------------------

You should have the following structure:

tool_check/
  dv/
  fv/
  rtl/
  env/env_setup.sh

All commands below must be run from the `tool_check/rtl` directory
unless stated otherwise.

--------------------------------------------------
1) One-time setup: environment file
--------------------------------------------------

Open the file:

  tool_check/env/env_setup.sh

Edit and fill in:
- SNPSLMD_LICENSE_FILE (Synopsys license server)
- Tool install paths for:
  - VCS
  - Verdi
  - VC Formal
  - JasperGold
  - dc_shell
  - icc2_shell

Save the file.

Then load the environment:

  cd ~/techaarvam/events/karpagam_feb_2026/tool_check
  source env/env_setup.sh

Quick sanity check (should not be empty):

  echo $VCS_HOME

--------------------------------------------------
2) Automated checks using Makefile
--------------------------------------------------

Move to the RTL directory:

  cd rtl

A) VCS compile + simulate + coverage

  make all

Expected signs-of-life:
- comp.log and run.log are created
- simv executable is created
- simv.vdb directory is created

You may also run step by step:

  make comp
  make run
  make urg

--------------------------------------------------
B) JasperGold formal check
--------------------------------------------------

  make jg

Expected:
- JasperGold launches
- Design files are read
- No license checkout errors

--------------------------------------------------
C) VC Formal check
--------------------------------------------------

  make vcf

Expected:
- VC Formal launches
- Design files are read
- No license checkout errors

--------------------------------------------------
3) Manual (interactive) tool checks
--------------------------------------------------

These checks simply confirm that the tools start correctly.

A) Verdi (waveform viewer)

  verdi &

Expected:
- Verdi GUI opens

--------------------------------------------------
B) dc_shell (synthesis)

  make dc_shell

At the prompt, type:

  help
  quit

--------------------------------------------------
C) icc2_shell (place and route)

  make icc2_shell

At the prompt, type:

  help
  exit

--------------------------------------------------
4) If something fails
--------------------------------------------------

Please share:
- The exact command you ran
- Error messages printed on the terminal
- Log files from tool_check/rtl:
  - comp.log
  - run.log
- The value used for SNPSLMD_LICENSE_FILE

--------------------------------------------------
5) Common issues
--------------------------------------------------

- License checkout failed:
  Check license server name/port and tool feature availability

- Command not found:
  Tool path in env_setup.sh is incorrect

- GUI does not open:
  Tool path or license issue

--------------------------------------------------
Copyright
--------------------------------------------------

Tech Aarvam
Copyright (c) 2026 Tech Aarvam.
Author: Ram (Ramasubramanian B)


