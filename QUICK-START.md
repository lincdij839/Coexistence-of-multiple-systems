# 🚀 快速开始

## 📦 安装 multi-system

### 方法 1: APT 仓库（推荐）

```bash
# 添加 APT 仓库
echo "deb [trusted=yes] https://lincdij839.github.io/Coexistence-of-multiple-systems/debian-repo stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list

# 更新并安装
sudo apt update
sudo apt install multi-system
```

### 方法 2: 在线安装脚本

```bash
curl -fsSL https://raw.githubusercontent.com/lincdij839/Coexistence-of-multiple-systems/main/online-install.sh | sudo bash
```

### 方法 3: 下载 .deb 包

```bash
wget https://lincdij839.github.io/Coexistence-of-multiple-systems/debian-repo/pool/main/multi-system_1.0.0.deb
sudo apt install ./multi-system_1.0.0.deb
```

## 🎯 初始化

```bash
# 重新加载用户组
newgrp lxd

# 初始化容器
multi-system-setup
```

## ✅ 使用

```bash
# 进入容器
my-arch       # Arch Linux
my-debian     # Debian 12
my-fedora     # Fedora 39
my-kali       # Kali Linux

# 管理工具
container-menu        # 交互式菜单
list-containers       # 查看状态
check-containers      # 检查完整性
```

## 📚 更多文档

- [完整文档](README.md)
- [工具安装](INSTALL-TOOLS.md)
- [Kali 工具](KALI-TOOLS.md)

## ⏱️ GitHub Pages 部署状态

如果 APT 安装失败，可能是 GitHub Pages 还在部署中（通常需要 1-5 分钟）。

检查部署状态：
- 访问: https://github.com/lincdij839/Coexistence-of-multiple-systems/actions
- 等待 "pages build and deployment" 完成

或者先使用方法 2 或方法 3 安装。
