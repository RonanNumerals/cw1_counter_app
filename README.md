## # cw1_counter_app

This Flutter application features a counter with increment, decrement, and reset functionality, as well as a toggle for switching between two images with a fade animation. The app also includes a theme toggle for light and dark modes.

For Task 1 we were asked to implement at least two of the enhancements provided. I dedided to implement Multi-step controls and Decrement + Reset buttons.
- The program contains +1, +5, and +10 step buttons. When pressed, the step value is set to that button's value, and pressing increment adds to the counter by that value. The current step value is also displayed.
- Since I implemented this step functionality, the decrement button will also remove the current step value from the counter, but the counter will not fall below 0.
- The reset button simply sets the counter to 0.

For Task 2 we were asked to implement a toggle button that transitions between two images, so I chose a king and queen card that fade transition between each other.

## # Extra Notes

- I was not sure if the decrement button was supposed to decrement by 1 or the current step value, but in the end I chose to have it decrement by the current step value.
- Because the function of the reset button wasn't clarified, I wasn't sure if the button should reset the step value as well as the counter. I decided that the reset button would only reset the counter, not the step.
