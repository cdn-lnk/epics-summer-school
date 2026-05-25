#!/usr/bin/env iocsh

epicsEnvSet IOC "NeverGonna:GiveYouUp"

require ecmccfg 8.0.0

iocshLoad "$(ecmccfg_DIR)/startup.cmd" "ECMC_VER=8.0.2, NAMING=ESSnaming"

iocshLoad "$(ecmccfg_DIR)/addSlave.cmd" "HW_DESC=EK1100, DEFAULT_SUBS=false"
iocshLoad "$(ecmccfg_DIR)/addSlave.cmd" "HW_DESC=EL1808, DEFAULT_SUBS=false"
iocshLoad "$(ecmccfg_DIR)/addSlave.cmd" "HW_DESC=EL7041-0052, DEFAULT_SUBS=false"

iocshLoad "$(ecmccfg_DIR)/configureAxis.cmd" "CONFIG=$(E3_CMD_TOP)/cfg/axis1.ax"

iocshLoad "$(ecmccfg_DIR)/applyConfig.cmd"
iocshLoad "$(ecmccfg_DIR)/setAppMode.cmd"
