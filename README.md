# 🚀 Systemctl Manager Pro

A lightweight, interactive bash utility for effortless systemd service management on Linux. Start, stop, create, and monitor services without memorizing complex commands—perfect for sysadmins, DevOps engineers, and Linux enthusiasts.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage](#usage)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)
- [FAQ](#faq)
- [License](#license)

---

## 📌 Overview

Managing systemd services on Linux servers can be tedious, especially when juggling multiple services. **Systemctl Manager Pro** brings all essential service operations into an intuitive menu-driven interface, eliminating the need to memorize complex systemctl commands.

Whether you're a sysadmin managing dozens of services, a DevOps engineer automating deployments, or a developer running local services, this tool handles the complexity so you can focus on what matters.

### Why Choose Systemctl Manager Pro?

✅ **No Command Memorization** - Interactive menus guide you through every operation  
✅ **Batch Operations** - Manage multiple services simultaneously  
✅ **Real-time Monitoring** - Stream logs and track service status  
✅ **Service Creation** - Create custom services with guided prompts  
✅ **Color-Coded Output** - Visual feedback for success, errors, and warnings  
✅ **Beginner-Friendly** - Perfect for learning systemd management  

---

## ✨ Key Features

### 🔍 Service Discovery & Monitoring
- **View all services** with detailed status information
- **Filter services** by state: active, enabled, disabled, or failed
- **Real-time status checks** for individual services
- **Live log streaming** with journalctl integration
- **Service analysis** including boot configuration and error logs

### 🎮 Service Control
- **Start, stop, restart,** and reload services without memorizing commands
- **Enable/disable** services for automatic startup at boot
- **One-command operations** for quick management

### 🛠️ Service Creation & Configuration
- **Create custom services** with interactive prompts
- **Edit existing service files** with nano editor
- **Automatic daemon reload** after modifications
- **Delete services** safely with confirmation prompts

### ⚙️ Advanced Operations
- **Batch enable/disable** multiple services simultaneously
- **Batch restart** operations for dependency management
- **Error detection** and recent error log viewing
- **System information** dashboard showing service statistics

### 🎨 User Experience
- **Intuitive menu interface** organized by task category
- **Color-coded output** (success, error, warning, info)
- **Real-time feedback** for all operations
- **Root privilege detection** with helpful prompts
- **Systemd availability check** before operation

---

## 🔧 Requirements

- **Linux operating system** with systemd installed
- **Bash shell** (version 4.0+)
- **Root or sudo access** for system-wide operations
- **Standard utilities:** systemctl, journalctl, nano

### Supported Distributions

This tool works on any modern Linux distribution using systemd:

- ✓ Ubuntu/Debian-based systems
- ✓ CentOS/RHEL/Fedora
- ✓ Arch Linux
- ✓ openSUSE
- ✓ Alpine Linux
- ✓ Any systemd-based distribution

### Verify Your System

Check if systemd is installed:

```bash
systemctl --version
```

---

## 📥 Installation

### Method 1: Git Clone (Recommended)

Clone the repository and navigate to the project directory:

```bash
git clone https://github.com/Jdhdx/Systemctl-Manager-Pro.git
cd Systemctl-Manager-Pro
```

Make the script executable:

```bash
chmod +x systemctl-manager.sh
```

Run the script with sudo:

```bash
sudo ./systemctl-manager.sh
```

### Method 2: Quick Download

Download and run in one go:

```bash
# Download the script
wget https://raw.githubusercontent.com/Jdhdx/Systemctl-Manager-Pro/main/systemctl-manager.sh

# Make it executable
chmod +x systemctl-manager.sh

# Run with sudo
sudo ./systemctl-manager.sh
```

Or using curl:

```bash
curl -O https://raw.githubusercontent.com/Jdhdx/Systemctl-Manager-Pro/main/systemctl-manager.sh
chmod +x systemctl-manager.sh
sudo ./systemctl-manager.sh
```

### Method 3: System-Wide Installation

Install globally for access from anywhere:

```bash
# Clone the repository
git clone https://github.com/Jdhdx/Systemctl-Manager-Pro.git

# Navigate to the directory
cd Systemctl-Manager-Pro

# Copy to system bin directory
sudo cp systemctl-manager.sh /usr/local/bin/systemctl-manager

# Make it executable
sudo chmod +x /usr/local/bin/systemctl-manager
```

Now run from anywhere:

```bash
sudo systemctl-manager
```

### Method 4: Manual Installation

1. Create a new file:
```bash
sudo nano /usr/local/bin/systemctl-manager
```

2. Paste the script contents from the repository

3. Save and exit (Ctrl+X, then Y, then Enter)

4. Make it executable:
```bash
sudo chmod +x /usr/local/bin/systemctl-manager
```

5. Run it:
```bash
sudo systemctl-manager
```

---

## 🚀 Quick Start

### Starting the Tool

```bash
sudo ./systemctl-manager.sh
```

You'll see an interactive menu with options organized by category.

### Main Menu Structure

```
╔═══════════════════════════════════════╗
║  Systemctl Manager Pro - Main Menu    ║
╚═══════════════════════════════════════╝

1. View Services        (Browse & filter services)
2. Control Services     (Start, stop, restart)
3. Manage Services      (Enable, disable, create)
4. Logs & Analysis      (View and troubleshoot logs)
5. Batch Operations     (Manage multiple services)
6. System Management    (System info & daemon reload)
7. Exit
```

---

## 📖 Usage Guide

### 1. View Services

Browse all available services with different filters:

```
[1] All services (including inactive)
[2] Active/running services only
[3] Services enabled for boot
[4] Services disabled on boot
[5] Services in failed state
[6] Detailed status of specific service
```

### 2. Control Services

Directly manage service states:

```
[1] Start service         - Begin a stopped service
[2] Stop service          - Halt a running service
[3] Restart service       - Stop and start in sequence
[4] Reload service        - Reload configuration without stopping
```

### 3. Manage Services

Full lifecycle management:

```
[1] Enable service        - Start automatically on system boot
[2] Disable service       - Prevent auto-start on boot
[3] Create service        - Build new custom service files
[4] Edit service          - Modify existing service configurations
[5] Delete service        - Remove service files safely
```

### 4. Logs & Analysis

Troubleshoot and monitor services:

```
[1] View recent logs      - Display last N lines of service logs
[2] Follow logs           - Stream logs in real-time
[3] Analyze service       - View status, boot config, and errors
[4] View failed services  - Show all services in failed state
```

### 5. Batch Operations

Manage multiple services at once:

```
[1] Enable multiple services
[2] Disable multiple services
[3] Restart multiple services
```

### 6. System Management

```
[1] View system info      - Display service statistics
[2] Reload daemon         - Reload systemd after file changes
[3] Check systemd version - Show OS and systemd version
```

---

## 💡 Usage Examples

### Example 1: Enable Nginx at Startup

```bash
$ sudo ./systemctl-manager.sh
Menu > 3  (Manage Services)
Menu > 1  (Enable Service)
Enter service name: nginx

✓ Service 'nginx' has been enabled on boot
```

### Example 2: Troubleshoot a Failed Service

```bash
$ sudo ./systemctl-manager.sh
Menu > 1  (View Services)
Menu > 5  (Services in failed state)
[View failed services]

Menu > 4  (Logs & Analysis)
Menu > 3  (Analyze Service)
Enter service name: postgresql
[View status, boot config, and error logs]
```

### Example 3: Create a Custom Service

```bash
$ sudo ./systemctl-manager.sh
Menu > 3  (Manage Services)
Menu > 3  (Create Service)

Service name: myapp
Description: My Custom Application
Command: /usr/local/bin/myapp --daemon
User: appuser
Restart policy: on-failure

✓ Service file created successfully
✓ Daemon reloaded
```

### Example 4: Monitor Service Logs in Real-Time

```bash
$ sudo ./systemctl-manager.sh
Menu > 4  (Logs & Analysis)
Menu > 2  (Follow Logs)
Enter service name: nginx
[Live log stream displays - Press Ctrl+C to exit]
```

### Example 5: Enable Multiple Services at Startup

```bash
$ sudo ./systemctl-manager.sh
Menu > 5  (Batch Operations)
Menu > 1  (Enable Multiple Services)

Enter services to enable: nginx mysql openssh-server

✓ Enabled: nginx
✓ Enabled: mysql
✓ Enabled: openssh-server
```

---

## 🎨 Color Legend

The tool uses color coding for immediate visual feedback:

| Symbol | Color | Meaning | Example |
|--------|-------|---------|---------|
| ✓ | 🟢 Green | Success | ✓ Service started |
| ✗ | 🔴 Red | Error | ✗ Service failed |
| ⚠ | 🟡 Yellow | Warning | ⚠ Service already running |
| ℹ | 🔵 Blue | Information | ℹ Service location: /etc/systemd/system |
| ► | 🟣 Magenta | Headers | Section titles |
| ═ | 🔷 Cyan | Borders | Menu frames |

---

## 🔧 Troubleshooting

### "This script must be run as root"

**Problem:** Script executed without sudo  
**Solution:**
```bash
sudo ./systemctl-manager.sh
```

### "systemd is not installed"

**Problem:** Your system doesn't use systemd  
**Solution:** Upgrade to a modern Linux distribution with systemd

### "Service file not found"

**Problem:** Incorrect service name entered  
**Solution:** Use option 1 (View Services) to see available services first

### Changes not taking effect

**Problem:** Didn't reload systemd daemon after editing  
**Solution:** Use option 6.2 (Reload Daemon) after editing service files

### Permission denied when editing

**Problem:** Nano couldn't save the file  
**Solution:** Ensure you're running with `sudo`

### Service won't start

**Problem:** Service has errors or missing dependencies  
**Solution:** Use option 4.3 (Analyze Service) to view error logs

### Script not found after installation

**Problem:** Directory not in PATH  
**Solution:** Run the full path or add `/usr/local/bin` to your PATH:
```bash
echo $PATH
```

---

## 💡 Best Practices

### Security
- ✓ Always use `sudo` for system-wide service management
- ✓ Be cautious when deleting services
- ✓ Verify service commands before creating new services
- ✓ Review service files before editing
- ✓ Keep backups of critical service files

### Maintenance
- ✓ Regularly check failed services (View > Failed Services)
- ✓ Monitor service logs for errors
- ✓ Keep service files backed up
- ✓ Document custom services you create
- ✓ Test service configurations before production deployment

### Performance
- ✓ Disable unnecessary services at boot
- ✓ Restart services during low-traffic periods
- ✓ Use reload instead of restart when possible
- ✓ Monitor critical services with logs
- ✓ Set appropriate restart policies

### Advanced Tips

**Creating a Database Service:**
```
Service name: customdb
Description: Custom Database Service
Command: /opt/customdb/bin/start.sh
User: customdb
Restart policy: always
After: network.target
```

**Viewing Logs for the Last Hour:**
```bash
# Using the tool
Menu > 4 (Logs & Analysis)
Menu > 1 (View Recent Logs)
Service: nginx
Lines: 100

# Or directly with journalctl
journalctl -u nginx --since "1 hour ago"
```

**Auto-Restart on Failure:**
When creating services, set restart policy to `always` or `on-failure` for automatic recovery.

---

## 📚 Direct systemctl Commands Reference

While the interactive menu is recommended, here are equivalent systemctl commands:

```bash
# View services
systemctl list-units --type=service
systemctl status nginx

# Control services
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx

# Enable/disable on boot
sudo systemctl enable nginx
sudo systemctl disable nginx

# View logs
journalctl -u nginx
journalctl -u nginx -f                    # Real-time
journalctl -u nginx --since "1 hour ago"  # Time-based
journalctl -u nginx -n 50                 # Last 50 lines

# Check status
systemctl is-active nginx
systemctl is-enabled nginx
```

---

## ⚠️ Limitations

- **User Services:** This tool manages system services. For user-level services, use `systemctl --user`
- **Custom Editors:** Script uses nano by default; edit files directly for other editors
- **Remote Systems:** Tool works locally; SSH into the server first for remote management
- **Non-systemd Systems:** Won't work on systems using SysVinit or OpenRC

---

## ❓ FAQ

**Q: Can I use this tool on remote servers?**  
A: Yes! SSH into the server first, then run the script locally on that machine.

**Q: Will this work on systems without systemd?**  
A: No. This tool is specifically designed for systemd. Older systems using SysVinit won't work.

**Q: Can I create services to run as a specific user?**  
A: Yes! The service creation menu allows you to specify the user account.

**Q: Is there a way to undo changes?**  
A: Service files are backed up by systemd. Manually revert by editing the file again.

**Q: Can I use this in scripts or cron jobs?**  
A: This tool is interactive. For scripting, use `systemctl` commands directly.

**Q: How often should I check failed services?**  
A: Regularly—ideally daily for production systems.

**Q: What if I accidentally delete a service file?**  
A: Systemd keeps backups. Manually recreate the file or restore from your backup.

**Q: Can I use this on macOS?**  
A: No. macOS uses launchd, not systemd. This tool is Linux-only.

**Q: How do I contribute improvements?**  
A: Fork the repository, make changes, and submit a pull request!

---

## 🐛 Reporting Issues

Found a bug? Please report it with:

- Your Linux distribution and version
- Systemd version (from option 6.3)
- The exact steps to reproduce the issue
- Error messages (if any)
- Output of `uname -a`

---

## 📄 License

This tool is provided as-is for educational and professional use. Modify and distribute as needed for your organization.

---

## 📝 Changelog

### Version 1.0 (Current)
- ✓ Complete service management interface
- ✓ 24 menu options covering all common tasks
- ✓ Color-coded output for clarity
- ✓ Batch operations support
- ✓ Log viewing and streaming
- ✓ Service creation and editing
- ✓ System information dashboard
- ✓ Error handling and validation

---

## 🤝 Contributing

Found a bug? Have a feature request? Contributions welcome!

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch:** `git checkout -b feature/your-feature`
3. **Make your changes** and test thoroughly
4. **Commit your changes:** `git commit -m "Add your feature"`
5. **Push to the branch:** `git push origin feature/your-feature`
6. **Submit a Pull Request**

---

## 💬 Support

If you encounter issues:

1. **Check the troubleshooting section** above
2. **Verify your permissions** with option 6.1
3. **View service-specific logs** with option 4.1
4. **Test with systemctl directly** for comparison
5. **Review systemd documentation:** `man systemctl`
6. **Check the GitHub Issues** for similar problems

---

## 🎯 Roadmap

Future features under consideration:

- [ ] Service dependency visualization
- [ ] Performance metrics and monitoring
- [ ] Automated backup of service files
- [ ] Web-based interface option
- [ ] Integration with monitoring tools
- [ ] Multi-server management capabilities

---

## 👨‍💻 Author

**Jdhdx**

For questions, feedback, or suggestions, please open an issue on GitHub.

---

**Happy managing! 🚀**

*Making systemd service management simple, safe, and enjoyable.*
