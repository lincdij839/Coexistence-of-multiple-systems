# LXD 多系统容器管理工具

一键安装，支持所有 Linux 发行版的容器管理系统。

## 🚀 快速安装

### 方法 1: APT 仓库（推荐）

```bash
# 添加仓库
echo "deb [trusted=yes] https://lincdij839.github.io/Coexistence-of-multiple-systems/debian-repo stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list

# 安装
sudo apt update
sudo apt install multi-system

# 初始化
newgrp lxd
multi-system-setup
```

### 方法 2: 在线安装脚本

```bash
curl -fsSL https://raw.githubusercontent.com/lincdij839/Coexistence-of-multiple-systems/main/online-install.sh | sudo bash
newgrp lxd
multi-system-setup
```

## 📦 包含内容

### 4 个预配置容器

- **my-arch** - Arch Linux (滚动更新)
- **my-debian** - Debian 12 (稳定开发)
- **my-fedora** - Fedora 39 (最新特性)
- **my-kali** - Kali Linux (安全测试)

### 快速命令

```bash
my-arch       # 进入 Arch Linux
my-debian     # 进入 Debian
my-fedora     # 进入 Fedora
my-kali       # 进入 Kali Linux
```

### 管理工具

```bash
container-menu        # 交互式菜单
list-containers       # 查看状态
check-containers      # 检查完整性
snapshot-container    # 创建快照
backup-all            # 备份所有容器
```

## 🛠️ 支持的系统

- Ubuntu 20.04+
- Debian 11+
- Fedora 35+
- Arch Linux
- CentOS Stream 8+
- openSUSE Leap 15+

## 📚 文档

- [在线安装指南](ONLINE-INSTALL.md) - 详细安装步骤
- [工具安装指南](INSTALL-TOOLS.md) - 开发工具安装
- [Kali 工具说明](KALI-TOOLS.md) - Kali Linux 安全工具

## 🎯 使用示例

```bash
# 进入容器
my-arch

# 查看状态
list-containers

# 管理菜单
container-menu

# 创建快照
snapshot-container my-arch backup

# 安装开发工具
lxc exec my-arch -- bash /usr/local/share/lxd-multi-system/install-arch-tools
```

## 🗑️ 卸载

```bash
# 使用 apt
sudo apt remove multi-system

# 或使用卸载脚本
curl -fsSL https://raw.githubusercontent.com/lincdij839/Coexistence-of-multiple-systems/main/uninstall.sh | sudo bash
```

## 🌟 特性

- ✅ 一键在线安装
- ✅ 支持所有主流 Linux 发行版
- ✅ 自动检测并安装依赖
- ✅ 4 个预配置容器
- ✅ 快速进入命令
- ✅ 完整的管理工具
- ✅ 开发工具安装脚本
- ✅ 交互式菜单

## 📄 许可证

MIT License

## 🔗 相关链接

- 项目仓库: https://github.com/lincdij839/Coexistence-of-multiple-systems
- APT 仓库: https://lincdij839.github.io/Coexistence-of-multiple-systems/debian-repo
- LXD 文档: https://documentation.ubuntu.com/lxd/
