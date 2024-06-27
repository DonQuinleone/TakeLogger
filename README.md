# TakeLogger
### A large print, keyboard-based take logger for macOS

For visually impaired music producers, keeping accurate take logs (and even just keeping track of what take we're on when Pyramix's take logging window isn't available) can be really difficult.

This simple macOS app is designed to get around that. It's nothing fancy, and it's certainly not going to win any awards, but it does the job. And once you're done with a session, you can export the take log to a CSV and send it to the engineer!

![Screenshot](/screenshot.png?raw=true "Screenshot of TakeLogger in action")

## Key Commands

This is a keyboard-driven app, so it's crucial that you can get around using the keyboard shortcuts!

**Timer**

| Shortcut | Action |
| -------- | ------ |
| Cmd+D    | Set timer duration in minutes |
| Cmd+Shift+D | Reset timer to 01:30:00 |
| Cmd+G | Start/Stop the timer - "Go" |

**Take Number**

| Shortcut | Action |
| -------- | ------ |
| Cmd+Return | Next take |
| Cmd+Backspace | Previous take |
| Cmd+T | Enter take number |

**Take Log**

| Shortcut | Action |
| -------- | ------ |
| Cmd+F | Increment FS counter for current take |
| Cmd+Shift+F | Decrement FS counter for current take |
| Cmd+N | Set notes for current take |

**Import & Export**

| Shortcut | Action |
| -------- | ------ |
| Cmd+S | Export take log to CSV |
| Cmd+O | Import take log CSV (**empties current take log**) |

## Using the mouse

Should you wish to use the mouse, you can!

* Double click on the take number to enter a new value
* Double click on the timer to set a new timer
* Click on a take in the take logger to select that take
* Use the buttons at the top of the take logger (why would you though?)
