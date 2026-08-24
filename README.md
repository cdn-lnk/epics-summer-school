# 2026 EPICS Summer School

Objectives:
- [ ] write PVs to interface the asyn driver.
  - [ ] limit switches
  - [ ] turn motor on/off
  - [ ] stop
  - [ ] current position
  - [ ] driver status (it is a byte word that must be parsed)
  - [ ] error code + reset command
  - [ ] position and velocity setpoints
  - [ ] choose all 4 types of motion (absolute, relative, velocity and homing)
- [ ] implement a motor record.
- [ ] create an OPI / HMI (all PVs created above must be present).
- [ ] (bonus 1) write a scan script.
- [ ] (bonus 2) play with the motor parameters.
- [ ] prepare a presentation.

Record references:
- [EPICS base](https://docs.epics-controls.org/projects/base/en/latest/ComponentReference.html)
- [motor](https://epics-modules.github.io/motor/motorRecord.html)

<details>
<summary>asyn interface (switches)</summary>

> `.DTYP=asynInt32`  
> `@asyn(port,address,timeout)TYPE=asynInt32/ec0.sX.binaryInputYY?`  
> port, address and timeout are provided by ecmccfg (use `epicsEnvShow`).

</details>

<details>
<summary>asyn interface (motor)</summary>

> `.DTYP=XXX`  
> `@asyn(port,address,timeout)TYPE=XXX/axNN.name?`

|name|type|description
|-:|-|-
|actpos|asynFloat64|axis position (read)
|status|asynInt32|status word (read)
|control|asynUInt32Digital|control word (write)
|targpos|asynFloat64|target position (write)
|targvelo|asynFloat64|target speed (write)
|command|asynInt32|motion type (write)
|cmddata|asynInt32|motion parameters (write)
|errorid|asynInt32|error code (read)

<details>
<summary>Control word</summary>

|bit|description
|-:|-
|0|on/off
|1|exec
|2|stop
|3|reset error

</details>

<details>
<summary>Status word</summary>

|bit|description
|-:|-
|1|on/off
|4|in position
|6|can move forward
|7|can move backward
|9|homed

</details>

<details>
<summary>Motion type and parameters</summary>

|command|description
|-:|-
|1|velocity
|2|relative
|3|absolute
|4|homing

|cmddata|description
|-:|-
|0|use when `type=1,2 or 3`
|1|home at the backward switch (only when `type=4`)
|2|home at forward switch (only when `type=4`)

</details>

</details>

<details>
<summary>motor record interface</summary>

> `.DTYP=asynMotor`  
> `@asyn(port,axis_number)`  
> ***NOT*** the same port as the asyn driver above, also provided by ecmccfg.

</details>
