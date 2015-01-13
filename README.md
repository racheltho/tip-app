tip-app
=======

An iOS app to calculate tips and split the bill.  The initial version was created in under an hour using the [CodePath tutorial video](http://vimeo.com/102084767).  I spent another hour adding bill split (the per person label and total are hidden when "No" is selected), creating constraints for auto layout, changing the colors, and creating the readme.

By clicking on the user input box next to "Bill Amount", a decimal keypad will come up and the user can enter the price using the keypad.  Clicking anywhere else on the screen hides the keypad.  Three different tip percentages can be selected from the segmented control.  The tip amount and total amount will automatically update whenever the bill amount is edited or when a different tip percentage is selected.

![alt tag](https://github.com/racheltho/tip-app/blob/master/screencaps/tip_calculator.gif)

Special features:
- Near the bottom, there is the option to choose if the user is splitting the bill.  If option 2, 3, or 4 is chosen, the per person price appears below the total.  Notice that when "No" is selected, the per person label and amount are hidden, so as to not clutter the screen.  Per person total is updated (and hidden or revealed as appropriate) whenever the selection is changed.
- Constraints are used and auto layout is enabled, so the placement/arrangement of the UI elements looks nice on a variety of screen sizes, including iphone 5 and 6 plus.

To see how the app looks on different sized iphones, here is a screenshot from the iphone 5:
![alt tag](https://github.com/racheltho/tip-app/blob/master/screencaps/iphone5.png)

and here it is on an iphone 6plus:
![alt tag](https://github.com/racheltho/tip-app/blob/master/screencaps/iphone6plus.png)
