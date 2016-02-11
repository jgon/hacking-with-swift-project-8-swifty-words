# Hacking with Swift - Project 8 - Swifty Words

## Setup

- Xcode 7.2.1
- Swift 2.0
- iOS 9.2
-  iPad

## Topics covered

- For loops with a condition: ```for ... in ... where```.
- Programmatically adding an action to a ```UIButton``` using ```addTarget``` and specifying the event ```.TouchUpInside```.
- Splitting a string into an array using ```String```  ```componentsSeparatedByString```.
- Using the ```enumerate``` to iterate over an array getting the position in the array as well as the array element (```for (index, line) in lines.enumerate()```).
- Replacing occurrences of a string in a string using ```stringByReplacingOccurrencesOfString```.
- Trimming strings using ```stringByTrimmingCharactersInSet``` (```whitespaceAndNewlineCharacterSet```).
- Looping over a range without including the upper bound of the range (```for i in 0 ..< letterButtons.count```). The ```...```operator includes the upper bound of the range.
- Defining a property observer (```didSet```) to perform some logic every time the value changes. One can also use the ```willSet``` property observer to take action before the value is changed.
