# Xim - Vim-like modal shortcuts for Xournal++

Simple plugin heavily based on [vi-xournalpp](https://github.com/raw-bacon/vi-xournalpp).

I originally wanted to use vi-xournalpp but didn't want to go through
the hassle of configuring it, so I made my own.

As a result it doesn't have all of the functionality that vi-xournalpp has but
only the things I need. Feel free to create issues/MRs if you want something
else implemented.

## Installation

Download the plugin into `~/.config/xournalpp/plugins`

```bash
cd ~/.config/xournalpp/plugins
git clone https://github.com/CrumblyLiquid/xim
```

To enable this plugin open `Plugin` -> `Plugin Manager` and enable `Xim`
and **restart Xournal++**.

## Setup

By default there are 5 modes: **Styles (q), Shapes (w), Size (e), Tool (r), Color (t)**

By default each mode has 4-5 keys bound. They are all on the home row and on the left
side of the keyboard so they can be reached easily.
(so `a`, `s`, `d`, `f`).

**If you want to see what a key does, press \<Shift\>\<key\> to show a little help menu**

Anything you'd want to change should be located in `config.lua`

## Contributing

Feel free to create issues or MRs if you have any issues or suggestions!
