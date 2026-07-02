#!/usr/bin/env iocsh
on error halt

epicsEnvSet IOC "NeverGonna:GiveYouUp"

require ecmccfg 8.0.0

iocshLoad "$(ecmccfg_DIR)/startup.cmd" "ECMC_VER=8.0.2, NAMING=ESSnaming"
ecmcConfigOrDie "Cfg.SetDiagAxisEnable(0)"

iocshLoad "$(ecmccfg_DIR)/addSlave.cmd" "HW_DESC=EK1100, DEFAULT_SUBS=false, DEFAULT_SLAVE_PVS=false"
iocshLoad "$(ecmccfg_DIR)/addSlave.cmd" "HW_DESC=EL1808, DEFAULT_SUBS=false, DEFAULT_SLAVE_PVS=false"
iocshLoad "$(ecmccfg_DIR)/addSlave.cmd" "HW_DESC=EL7041-0052, DEFAULT_SUBS=false, DEFAULT_SLAVE_PVS=false"

# Driving current (amplitude per phase): 600 mA
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x1,600,2)"
# Holding current: 0
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x2,0,2)"
# PSU voltage: 24 V
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x3,24000,2)"

iocshLoad "$(ecmccfg_DIR)/configureAxis.cmd" "CONFIG=$(E3_CMD_TOP)/cfg/axis1.ax"

iocshLoad "$(ecmccfg_DIR)/applyConfig.cmd"
iocshLoad "$(ecmccfg_DIR)/setAppMode.cmd"
