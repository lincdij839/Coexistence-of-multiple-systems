# 更新说明

## v1.0.0 - 新终端窗口支持

### 新功能

现在进入容器时会自动在新的终端窗口中打开，而不是在当前终端中运行。

### 支持的终端

脚本会自动检测并使用以下终端模拟器（按优先级）：

1. **gnome-terminal** - GNOME 默认终端
2. **konsole** - KDE 默认终端
3. **xfce4-terminal** - XFCE 默认终端
4. **xterm** - 通用 X 终端
5. **tilix** - 平铺式终端
6. **terminator** - 多窗口终端

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

# 安装新版本
sudo apt update
sudo apt install multi-system
```

## 测试

运行以下命令测试新功能：

```bash
my-arch
```

应该会打开一个新的终端窗口并进入 Arch Linux 容器。
