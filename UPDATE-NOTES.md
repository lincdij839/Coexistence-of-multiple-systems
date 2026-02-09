# 更新说明

## v1.0.0 - 新终端窗口支持（已修复）

### ✅ 已修复问题

- ✅ 修复了 `dbus-launch` 缺失错误
- ✅ 添加了 DISPLAY 和 WAYLAND_DISPLAY 检测
- ✅ 添加了错误输出重定向（2>/dev/null）
- ✅ 添加了更好的错误处理和回退机制
- ✅ 支持更多终端模拟器（mate-terminal, lxterminal）
- ✅ 为每个容器添加了自定义窗口标题

### 依赖包

如果遇到 `dbus-launch` 错误，安装以下包：

```bash
sudo apt install dbus-x11
```

### 新功能

现在进入容器时会自动在新的终端窗口中打开，而不是在当前终端中运行。

### 支持的终端

脚本会自动检测并使用以下终端模拟器（按优先级）：

1. **gnome-terminal** - GNOME 默认终端（带标题）
2. **konsole** - KDE 默认终端（带标题）
3. **xfce4-terminal** - XFCE 默认终端（带标题）
4. **xterm** - 通用 X 终端（带标题）
5. **tilix** - 平铺式终端（带标题）
6. **terminator** - 多窗口终端（带标题）
7. **mate-terminal** - MATE 默认终端（带标题）
8. **lxterminal** - LXDE 默认终端（带标题）

### 窗口标题

每个容器都有自定义的窗口标题：
- my-arch → "Arch Linux Container"
- my-debian → "Debian Container"
- my-fedora → "Fedora Container"
- my-kali → "Kali Linux Container"

### 使用方法

```bash
# 直接运行命令，会在新终端窗口中打开
my-arch
my-debian
my-fedora
my-kali
```

### 回退模式

如果系统中没有安装图形终端模拟器（例如在 SSH 会话中），脚本会自动回退到在当前终端中运行。

### 手动更新

如果已经安装了旧版本，可以手动更新脚本：

```bash
# 下载新版本的脚本
sudo wget -O /usr/local/bin/my-arch https://raw.githubusercontent.com/lincdij839/Coexistence-of-multiple-systems/main/my-arch
sudo wget -O /usr/local/bin/my-debian https://raw.githubusercontent.com/lincdij839/Coexistence-of-multiple-systems/main/my-debian
sudo wget -O /usr/local/bin/my-fedora https://raw.githubusercontent.com/lincdij839/Coexistence-of-multiple-systems/main/my-fedora
sudo wget -O /usr/local/bin/my-kali https://raw.githubusercontent.com/lincdij839/Coexistence-of-multiple-systems/main/my-kali

# 添加执行权限
sudo chmod +x /usr/local/bin/my-*
```

### 或者重新安装

```bash
# 卸载旧版本
sudo apt remove multi-system

# 清除缓存
sudo rm -rf /var/lib/apt/lists/lincdij839*

# 安装新版本
sudo apt update
sudo apt install multi-system
```

## 测试

运行以下命令测试新功能：

```bash
my-kali
```

应该会打开一个新的终端窗口（标题为 "Kali Linux Container"）并进入 Kali Linux 容器。
