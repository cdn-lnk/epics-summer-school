#!/usr/bin/env iocsh
on error halt

epicsEnvSet IOC "LensControl"

require ecmccfg 8.0.0

iocshLoad "$(ecmccfg_DIR)/startup.cmd" "ECMC_VER=8.0.2, NAMING=ESSnaming"
ecmcConfigOrDie "Cfg.SetDiagAxisEnable(0)"

iocshLoad "$(ecmccfg_DIR)/addSlave.cmd" "HW_DESC=EK1100, DEFAULT_SUBS=false, DEFAULT_SLAVE_PVS=false"
iocshLoad "$(ecmccfg_DIR)/addSlave.cmd" "HW_DESC=EL1808, DEFAULT_SUBS=false, DEFAULT_SLAVE_PVS=false"
iocshLoad "$(ecmccfg_DIR)/addSlave.cmd" "HW_DESC=EL7041-0052, DEFAULT_SUBS=false, DEFAULT_SLAVE_PVS=false"

# Driving current (amplitude per phase): 700 mA
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x1,700,2)"
# Holding current: 1 mA (cannot be 0)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x2,1,2)"
# PSU voltage: 24 V
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x3,24000,2)"

iocshLoad "$(ecmccfg_DIR)/configureAxis.cmd" "CONFIG=$(E3_CMD_TOP)/cfg/axis1.ax"

iocshLoad "$(ecmccfg_DIR)/applyConfig.cmd"
iocshLoad "$(ecmccfg_DIR)/setAppMode.cmd"

########################################
# DO NOT EDIT ABOVE THIS LINE

# Insert your code here
dbLoadRecords("db/lens_control.db", "AX=Axis, P=$(IOC), port=$(ECMC_ASYN_PORT), address=$(ECMC_ASYN_ADDR), timeout=$(ECMC_ASYN_TIMEOUT)")
