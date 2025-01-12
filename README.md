# TakeLogger
### A large print, keyboard-based take logger for macOS

For visually impaired music producers, keeping accurate take logs (and even just keeping track of what take we're on when Pyramix's take logging window isn't available) can be really difficult.

This simple macOS app is designed to get around that. It's nothing fancy, and it's certainly not going to win any awards, but it does the job. And once you're done with a session, you can export the take log to a CSV and send it to the engineer!

A separate Producer Window is available if it is the engineer that is controlling the machine, allowing the producer to see just the information that's important.

![Screenshot](/screenshot.png)

## Key Commands

This is a keyboard-driven app, so it's crucial that you can get around using the keyboard shortcuts!

If you want to set your own keyboard shortcuts, you can modify them in `config/KeyCommands.swift`

**Timer**

| Shortcut | Action |
| -------- | ------ |
| D | Set timer duration in minutes |
| R | Reset timer to 01:30:00 |
| Space | Toggle the timer |

**Take Number**

| Shortcut | Action |
| -------- | ------ |
| Left or Down arrow | Previous take |
| Right or Up arrow | Next take |
| T | Select take number |
| Return | Add and jump to new take |

**Take Log**

| Shortcut | Action |
| -------- | ------ |
| F | Increment FS counter for current take |
| G or Shift+F | Decrement FS counter for current take |
| N | Set notes for current take |
| L | Show/hide the take logger (shown by default) |

**Import & Export**

| Shortcut | Action |
| -------- | ------ |
| Cmd+S | Export take log to CSV |
| Cmd+O | Import take log CSV (**empties current take log**) |

**Show the Producer Window**

| Shortcut | Action |
| -------- | ------ |
| P | Show producer window |

## Using the mouse

Should you wish to use the mouse, you can!

* Click on the take number to enter a new value
* Click on the timer to set a new timer
* Click on a take in the take logger to select that take

## Feature Requests & Bugs

If you would like to request a new feature or have found a bug, please open an Issue and I'll look into it as soon possible.

## Contributions

Contributions very much welcome. Please feel free to open a PR.
