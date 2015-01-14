tip-app
=======

An iOS app to calculate tips and split the bill.  The initial version was created in under an hour using the [CodePath tutorial video](http://vimeo.com/102084767).  I spent another 4 hours adding additional features, including the settings page.

Required stories:
- By clicking on the user input box next to "Bill Amount", a decimal keypad will come up and the user can enter the price using the keypad.  Clicking anywhere else on the screen hides the keypad.  Three different tip percentages can be selected from the segmented control.  The tip amount and total amount will automatically update whenever the bill amount is edited or when a different tip percentage is selected.
- Clicking on settings on the navigation bar at top will take the user to a settings page where they can choose a default tip percentage.  Clicking "Cancel" or "Save" in the navigation bar will return the user to the main Tip Calculator page.  If the user clicks "Save", the selected percentae will be persisted in the NSUserDefaults.  This percent will then show up whenever the Tip Calculator view loads.  If the user clicks "Cancel", the app returns to the Tip Calculator without saving any changes.

Optional/special features:
- The bill amount, tip, total, and timestamp of the most recent edits are stored in NSUserDefaults.  When the Tip Calculator view is loading, it checks if the timestamp of the most recent edit is less then a certain interval of time ago.  If it is, the recent bill amount shows up.  This is useful if the user switches briefly to another app while in the middle of calculating a tip.  In order to demonstrate this feature in the GIF below, I've set the time interval to 15 seconds, but in practice, I would set it to be a few minutes.
- NSNumberFormatter is used to display the tip, total, and per person amounts with currency format ($ X,XXX.XX)
- Near the bottom, there is the option to choose if the user is splitting the bill.  If option 2, 3, or 4 is chosen, the per person price appears below the total.  Notice that when "No" is selected, the per person label and amount are hidden, so as to not clutter the screen.  Per person total is updated (and hidden or revealed as appropriate) whenever the selection is changed.
- Constraints are used and auto layout is enabled, so the placement/arrangement of the UI elements looks nice on a variety of screen sizes, including iphone 5 and 6 plus.

![alt tag](https://github.com/racheltho/tip-app/blob/master/screencaps/tip_calculator.gif)

In the animated gif above, the user enters 1200 as the bill amount (to show off the currency formatting) and then looks how the total changes with different tip percentages or with splitting the bill.  Notice that the "per person" amount is hidden when the user is not splitting the bill.  Next the user clicks on "Settings" to change their default tip percentage to 20% and hits "Save".  When the app returns to the tip calculator, the tip percentage has been updated to 20% and the bill amount still shows up .

Next, the user goes to "Settings", changes the tip percentage, and hits "Cancel".  In this case, the tip percentage doesn't change.

To see how the app looks on a different sized iphone (with the help of auto layout and constraints), here is a gif of the 6 plus:

![alt tag](https://github.com/racheltho/tip-app/blob/master/screencaps/tip_calculator2.gif)


