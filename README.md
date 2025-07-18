# my-ubuntu-autostart-config

This one is a very personal one, so feel free to learn from it, but honestly, I doubt it'll be useful to anyone else.

## 🚀 Quick Install

To set up everything automatically on your system, just run the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/gouveags/my-ubuntu-autostart-config/main/install.sh | bash
````

This will:

* ✅ Check your system compatibility (Linux + apt-based/Ubuntu)
* 🔧 Install required dependencies (`git`, `wmctrl`, `xdotool`, etc.)
* 📦 Clone this repository
* ⚙️ Run the setup script to finish configuration
* 🗑️ Install an uninstall script for easy removal

## 🗑️ Uninstalling

If you want to remove the autostart configuration from your system, you can run:

```bash
my-ubuntu-autostartup-uninstall
```

This will:
* 🧹 Remove all autostart configurations
* 🗑️ Clean up temporary files
* 🗑️ Automatically remove the uninstall script itself

The uninstall script is installed to `~/.local/bin/` and can be run from anywhere in your terminal.
