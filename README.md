# 2026 EPICS Summer School

Objectives:
- [ ] write PVs to interface the asyn driver.
- [ ] implement a motor record.
- [ ] create an OPI / HMI.
- [ ] (bonus) play with the motor parameters. 😁
- [ ] (bonus) control the axis using a [script](https://gitlab.esss.lu.se/carlosneto/pyecmc).
- [ ] (bonus) secret objective.

Record references:
- [EPICS base](https://docs.epics-controls.org/projects/base/en/latest/ComponentReference.html)
- [motor](https://epics-modules.github.io/motor/motorRecord.html)

<details>
<summary>asyn interface</summary>

> [!warning] Syntax
> `.DTYP=XXX` and `@asyn(port,address,timeout)TYPE=XXX/axNN.name?`

> [!important]
> port, address and timeout are provided by ecmccfg.

> [!note] Bonus
> Play with `.TSE` and `T_SMP_MS` values.

|asyn name|type|description
|-:|-|-
|actpos|asynFloat64|axis position
|status|asynInt32|status word
|control|asynUInt32Digital|control word
|targpos|asynFloat64|target position
|targvelo|asynFloat64|target speed
|command|asynInt32|motion type
|cmddata|asynInt32|motion parameters
|errorid|asynInt32|error code

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

> [!warning] Syntax
> `.DTYP = asynMotor` and `@asyn(port,axis_number)`

> [!important]
> Not the same port as the asyn driver above, also provided by ecmccfg.

</details>
