# Files

#### VGAController
File given to use to interact with VGA Display

##### VGADisplay
Maps the SSD (Seven Segment Display) onto the monitor so that we can display the state of the lock to the user.

##### changeOverallStatus
Determines how the system will change/update when the "change" button is pushed. In the project description, the change button was used to initiate the steps that would allow the user to change the password of the lock.

##### clk_divider
Divided the 40 MHz clock of the FPGA board down to a reasonable refresh rate for the SSD. If you don't divide the clock it will be blinking because it is getting signals too frequently.

##### clk_divider2
Divided the 40 MHz clock of the FPGA board down to the refresh rate of the monitor. If they weren't the same we wouldn't be able to get a constant steady image.

##### debouncer
Used in the buttons to remove the "noise" from when the buttons have been pushed.

##### enterOverallStatus
Determines how the system will change/update when the "enter" button is pushed. The enter button may just add another digit to the current password unlock attempt, or it can change the overall status if the password is entered correctly or incorrectly.

##### finishedScrollingStatus
Small file used to check that we have finished scrolling text. (Bonus of project)

##### getDigit
Took the status of 4 Switches that represented a HEX number (0-F) in binary.

##### getDisplayElements
Based on the overall status, it would be returning an array of SSD Lines that should be getting displayed.

##### getOverallStatus
Would return the overall status from the other child statuses (Change, Enter, ...)

##### getPassword
Returns what the current password is.

##### projectMAIN
Main file of the project, instantiated most of the core submodules and overall organized everything.

##### scrollingLines
Organized the lines needed to display the scrolling text.

##### updateDigit
Updated the digit based on the current state of the switches.

##### updateSSDisplay
Updated the SSD based on what the current lines were to be displayed.
