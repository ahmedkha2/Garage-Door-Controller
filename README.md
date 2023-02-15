# Garage Door Controller
 Simple FSM for an automatic Garage Door Controller that control both up and down motors.
 

### IO:

#### control:
* `CLK` - **[input]** board internal clock
* `RST` - **[input]** Synchronized reset signal

#### Signals:
* `UP_Max` - **[input]** door completely open
* `Activate` - **[input]** trigger the Up motor when the Door down and trigger the Down motor when the Door Up
* `DN_Max` - **[input]** door completely open
* `UP_M` - **[output]** Trigger Up Motor
* `DN_M` - **[output]** Trigger Down Motor

#### States Diagram:
* `IDLE state`: it is the default state & reset state of the finite state machine.
* `Mv_Up State`: it is the state to enable the up motor to open the garage door.
* `Mv_Dn state`: it is the state to enable the down motor to close the garage door.
![state diagram](rsc/statediagram.png)