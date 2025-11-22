# Xim - Vim-like modal shortcuts for Xournal++

Simple plugin heavily based on [vi-xournalpp](https://github.com/raw-bacon/vi-xournalpp).

I originally wanted to use vi-xournalpp but didn't want to go through
the hassle of configuring it, so I made my own.

As a result it doesn't have all of the functionality that vi-xournalpp has but
only the things I need. Feel free to create issues/MRs if you want something
else implemented.

## Installation

> [!WARNING]
> This plugin needs to be manually enabled after installation!
>
> To do so, click on `Plugin` -> `Plugin Manager`, enable `Xim`
> and **restart Xournal++**.

### Automatic

**Linux/macOS:**
```bash
curl -sS https://raw.githubusercontent.com/CrumblyLiquid/xim/refs/heads/main/install.sh | sh
```

_Note: The [install script](./install.sh) is very simple.
You should inspect it before running it._

**Windows:**
```
TODO: I don't have Windows installed at the moment. Use the manual method.
```

### Manual

**Linux/macOS:**
```bash
cd ~/.config/xournalpp/plugins
git clone --depth 1 https://github.com/CrumblyLiquid/xim
```

**Windows:**
```ps
cd $env:LOCALAPPDATA\xournalpp\plugins
git clone --depth 1 https://github.com/CrumblyLiquid/xim
```

## How does it work?

By default, you're in the **Tool** mode.

In the **Tool** mode you have:
- **\[f\]**: Pen
- **\[d\]**: Eraser
- **\[s\]**: Rectangle select
- **\[a\]**: Region select

When you want to use tools from other modes
simply press the key of the mode.

There are 5 modes (in the default `config.lua`):
- **\[t\]**: Color
- **\[r\]**: Tool
- **\[e\]**: Size
- **\[w\]**: Styles
- **\[q\]**: Shapes

After you entered the desired mode,
press another key to activate the desired keybind.
After the keybind triggers, you will be put again
into the default mode (which is **Tool**).

> [!TIP]
> Not sure what a key does or what keybinds
> a mode contains?
>
> Press **Shift** together with the key!

If you don't want to be put back into the default mode straight away,
you can enable **sticky mode**, which will allow you to
stay in the mode without moving into the default one
upon triggering a keybind.

To enable sticky mode, simply use **Alt** together with the key
used to enter your desired mode.

## Configuration

Anything you'd want to change should be located in `config.lua`

You can change the `help` and `sticky` keys and
modify modes or keybinds!

## Contributing

Feel free to create issues or MRs if you have any issues or suggestions!
