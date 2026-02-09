# 快速安装指南

## 🚀 推荐方式：在线安装（一键完成）

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash
newgrp lxd
multi-system-setup
```

**效果等同于 `apt install multi-system`**，会自动：
- ✅ 检测并安装 LXD
- ✅ 配置用户权限
- ✅ 安装所有命令和工具
- ✅ 创建初始化脚本

## 📦 为什么不是 `apt install multi-system`？

要实现 `apt install multi-system`，需要：

1. **创建 .deb 包** - 已完成
2. **发布到 APT 仓库** - 需要以下之一：
   - 创建 PPA（仅限 Ubuntu）
   - 自建 APT 服务器（需要服务器）
   - 使用 GitHub Releases（需要手动下载）

这些方案都比较复杂，而在线安装脚本提供了相同的便利性。

## 🎯 使用对比

### 传统 APT 方式
```bash
sudo apt install multi-system    # 需要配置仓库
multi-system-setup
```

### 当前在线安装方式
```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash
newgrp lxd
multi-system-setup
```

**两者效果完全相同！**

## 💡 如果你坚持要 apt 方式

可以下载 .deb 包手动安装：

```bash
# 下载 .deb 包
wget https://github.com/yourusername/lxd-multi-system/releases/download/v1.0.0/multi-system_1.0.0.deb

# 安装
sudo apt install ./multi-system_1.0.0.deb

# 或使用 dpkg
sudo dpkg -i multi-system_1.0.0.deb
sudo apt-get install -f  # 修复依赖
```

## 🌟 推荐：使用在线安装

在线安装脚本是最佳选择，因为：

1. **一条命令完成** - 无需额外配置
2. **自动更新** - 每次运行都是最新版本
3. **跨平台** - 支持所有 Linux 发行版
4. **无需维护** - 不需要管理仓库
5. **更安全** - 直接从源码安装

## 📚 安装后使用

```bash
# 快速进入容器
my-arch       # Arch Linux
my-debian     # Debian
my-fedora     # Fedora
my-kali       # Kali Linux

# 管理工具
container-menu        # 交互式菜单
list-containers       # 查看状态
check-containers      # 检查完整性
```

## 🗑️ 卸载

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/uninstall.sh | sudo bash
```

---

**结论**: 在线安装脚本提供了与 `apt install` 相同的便利性，无需复杂的仓库配置。
