# 🚀 BlackSwanDev PHP Compatibility Checker

A powerful and user-friendly macOS Quick Action to check PHP compatibility for WordPress plugins and projects. Easily verify the minimum PHP version required for your code, right from Finder!

---

## 📦 Features

- 🟢 Check PHP compatibility for any folder containing PHP files.
- 📜 Generate a detailed report with errors and warnings.
- 📅 Automatically includes timestamp and PHP version used.
- 📂 Opens the report in TextEdit, clean and formatted.
- 🔔 Notifications for start and completion of the scan.

---

## 🖥️ **Installation (macOS)**

### 1. **Install Required Tools**
Ensure you have PHP, Composer, and PHPCS installed:

```bash
# Install Homebrew if not installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install PHP (latest version)
brew install php

# Install Composer
brew install composer

# Install PHP CodeSniffer (PHPCS)
composer global require "squizlabs/php_codesniffer=*"

# Install PHPCompatibility Standard for PHPCS
composer global require "phpcompatibility/php-compatibility"
```

### 2. **Verify Installations**
Run these commands to ensure everything is installed:

```bash
php --version
composer --version
phpcs --version
```

---

## ⚙️ **Setup Quick Action (Automator)**

1. Open **Automator** and create a **Quick Action**.
2. Set **"Workflow receives current"** to `folders` in `Finder`.
3. Add a **Run Shell Script** action.
4. **Shell:** `/bin/bash`
   **Pass Input:** `as arguments`
5. Paste the following command:

```bash
/Users/$(whoami)/Documents/php_compatibility_check.sh "$@"
```

6. Save the Quick Action as **PHP Compatibility Check**.

---

## 📝 **How to Use**

1. **Right-click** any folder containing PHP files.
2. Select **Quick Actions > PHP Compatibility Check**.
3. Enter the desired PHP version (default: `7.1`).
4. View the detailed report in TextEdit.

---

## 🤝 **Credits**

Developed by [Amirhossein Hosseinpour](https://amirhp.com) 🖤
Powered by **BlackSwanDev** and the **PHPCompatibility Standard**.

---

## ⚠️ **Disclaimer & Warranty**

This tool is provided **as-is**, without warranty of any kind, express or implied.
The developer assumes **no responsibility** for any issues arising from the use of this tool.

---

## 📄 **License**

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

💡 **Enjoy effortless PHP compatibility checks!** If you find this tool useful, ⭐️ star the repo and share it with others!