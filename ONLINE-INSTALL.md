# LXD 多系统容器 - 在线安装

## 🚀 一键安装（推荐）

在任何 Linux 系统上运行：

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash
```

或使用 wget：

```bash
wget -qO- https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash
```

## 📋 安装步骤

安装脚本会自动：

1. ✅ 检测并安装 LXD（支持 apt, dnf, pacman, snap）
2. ✅ 配置用户权限
3. ✅ 下载所有必需文件
4. ✅ 安装到系统目录
5. ✅ 创建初始化脚本

## 🎯 使用方法

### 1. 安装后刷新权限

```bash
newgrp lxd
```

### 2. 初始化容器

```bash
multi-system-setup
```

这将创建 4 个容器：
- **my-arch** - Arch Linux
- **my-debian** - Debian 12
- **my-fedora** - Fedora 39
- **my-kali** - Kali Linux

### 3. 快速进入容器

```bash
my-arch       # 进入 Arch Linux
my-debian     # 进入 Debian
my-fedora     # 进入 Fedora
my-kali       # 进入 Kali Linux
```

### 4. 管理容器

```bash
container-menu        # 交互式菜单
list-containers       # 查看状态
check-containers      # 检查完整性
```

## 🛠️ 支持的 Linux 发行版

- ✅ Ubuntu 20.04+
- ✅ Debian 11+
- ✅ Fedora 35+
- ✅ Arch Linux
- ✅ CentOS Stream 8+
- ✅ openSUSE Leap 15+
- ✅ 其他支持 LXD 的发行版

## 📦 安装内容

### 命令（/usr/local/bin/）

- `my-arch`, `my-debian`, `my-fedora`, `my-kali` - 快速进入
- `multi-system-setup` - 初始化脚本
- `container-menu` - 交互式菜单
- `list-containers`, `check-containers` - 状态检查
- `start-container`, `stop-container`, `stop-all` - 控制
- `snapshot-container`, `restore-snapshot` - 快照
- `backup-all` - 备份
- `set-limits` - 资源限制
- `copy-to-container`, `copy-from-container` - 文件传输

### 工具（/usr/local/share/lxd-multi-system/）

- `install-arch-tools` - Arch Linux 开发工具
- `install-debian-tools` - Debian 开发工具
- `install-fedora-tools` - Fedora 开发工具
- `install-kali-tools` - Kali 安全工具
- `fix-kali-install` - 修复 Kali 安装
- `list-kali-tools` - 列出 Kali 工具

### 文档（/usr/local/share/doc/lxd-multi-system/）

- `README.md` - 主文档
- `INSTALL-TOOLS.md` - 工具安装指南
- `KALI-TOOLS.md` - Kali 工具说明

## 🗑️ 卸载

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/uninstall.sh | sudo bash
```

或手动卸载：

```bash
# 删除命令
sudo rm -f /usr/local/bin/my-*
sudo rm -f /usr/local/bin/multi-system-setup
sudo rm -f /usr/local/bin/container-menu
sudo rm -f /usr/local/bin/list-containers
sudo rm -f /usr/local/bin/check-containers
sudo rm -f /usr/local/bin/start-container
sudo rm -f /usr/local/bin/stop-container
sudo rm -f /usr/local/bin/stop-all
sudo rm -f /usr/local/bin/snapshot-container
sudo rm -f /usr/local/bin/restore-snapshot
sudo rm -f /usr/local/bin/backup-all
sudo rm -f /usr/local/bin/set-limits
sudo rm -f /usr/local/bin/copy-*-container

# 删除工具和文档
sudo rm -rf /usr/local/share/lxd-multi-system
sudo rm -rf /usr/local/share/doc/lxd-multi-system

# 可选：删除容器
lxc delete my-arch --force
lxc delete my-debian --force
lxc delete my-fedora --force
lxc delete my-kali --force
lxc storage delete duoxitong
```

## 🔧 故障排查

### 问题 1: curl 或 wget 未安装

```bash
# Ubuntu/Debian
sudo apt install curl

# Fedora
sudo dnf install curl

# Arch
sudo pacman -S curl
```

### 问题 2: 权限被拒绝

```bash
# 确保在 lxd 组中
groups | grep lxd

# 重新登录或运行
newgrp lxd
```

### 问题 3: LXD 安装失败

手动安装 LXD：

```bash
# Ubuntu/Debian
sudo snap install lxd
sudo lxd init --auto

# Fedora
sudo dnf install lxd
sudo systemctl enable --now lxd
sudo lxd init --auto

# Arch
sudo pacman -S lxd
sudo systemctl enable --now lxd
sudo lxd init --auto
```

### 问题 4: 网络连接失败

如果无法访问 GitHub，可以使用镜像：

```bash
# 使用 Gitee 镜像（如果有）
curl -fsSL https://gitee.com/yourusername/lxd-multi-system/raw/main/online-install.sh | sudo bash
```

或下载到本地安装：

```bash
git clone https://github.com/yourusername/lxd-multi-system.git
cd lxd-multi-system
sudo bash install.sh
```

## 📊 系统要求

- 至少 4GB 可用磁盘空间
- 至少 2GB 可用内存
- root 权限（用于安装）
- 网络连接（用于下载）

## 🌟 特性

- ✅ 一键在线安装
- ✅ 支持所有主流 Linux 发行版
- ✅ 自动检测并安装依赖
- ✅ 4 个预配置容器
- ✅ 快速进入命令
- ✅ 完整的管理工具
- ✅ 开发工具安装脚本
- ✅ 交互式菜单

## 📝 完整使用流程

```bash
# 1. 在线安装
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash

# 2. 刷新权限
newgrp lxd

# 3. 初始化容器
multi-system-setup

# 4. 进入容器
my-arch

# 5. 安装开发工具（在容器内）
/usr/local/share/lxd-multi-system/install-arch-tools

# 6. 管理容器
container-menu
```

## 📄 许可证

MIT License

## 🔗 相关链接

- 项目仓库: https://github.com/yourusername/lxd-multi-system
- LXD 文档: https://documentation.ubuntu.com/lxd/
