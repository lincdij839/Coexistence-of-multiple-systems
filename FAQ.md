# 常见问题

## ❓ 为什么不能 `apt install multi-system`？

**简短回答**: 可以，但需要额外配置。在线安装脚本提供了更好的体验。

**详细说明**:

要实现 `apt install multi-system`，需要：

1. 创建 .deb 包 ✅（已完成）
2. 发布到 APT 仓库 ❌（需要服务器或 PPA）

### 当前推荐方式

```bash
# 一键安装（效果相同）
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash
```

这个方式：
- ✅ 一条命令完成
- ✅ 自动安装依赖
- ✅ 支持所有 Linux 发行版
- ✅ 无需配置仓库
- ✅ 自动更新到最新版本

### 如果你坚持要 apt 方式

查看 [CREATE-APT-REPO.md](CREATE-APT-REPO.md) 了解如何创建 APT 仓库。

---

## ❓ 安装后找不到命令？

```bash
# 刷新权限
newgrp lxd

# 或重新登录
exit
# 然后重新登录
```

---

## ❓ 容器创建失败？

```bash
# 检查 LXD 状态
lxc list

# 如果失败，重新初始化
sudo lxd init --auto
```

---

## ❓ 如何卸载？

```bash
# 保留容器
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/uninstall.sh | sudo bash
# 输入 "no"

# 完全删除（包括容器）
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/uninstall.sh | sudo bash
# 输入 "yes"
```

---

## ❓ 支持哪些 Linux 发行版？

- ✅ Ubuntu 20.04+
- ✅ Debian 11+
- ✅ Fedora 35+
- ✅ Arch Linux
- ✅ CentOS Stream 8+
- ✅ openSUSE Leap 15+
- ✅ 其他支持 LXD 的发行版

---

## ❓ 如何更新到最新版本？

```bash
# 重新运行安装脚本
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash
```

---

## ❓ 容器占用太多资源？

```bash
# 设置资源限制
set-limits my-arch 512 1      # 512MB 内存, 1 核 CPU
set-limits my-debian medium   # 预设: 512MB, 2 核
set-limits my-kali light      # 预设: 256MB, 1 核
```

---

## ❓ 如何备份容器？

```bash
# 创建快照
snapshot-container my-arch backup-20260209

# 备份所有容器
backup-all

# 恢复快照
restore-snapshot my-arch backup-20260209
```

---

## ❓ 如何在容器间传输文件？

```bash
# 复制到容器
copy-to-container my-arch file.txt /root/

# 从容器复制
copy-from-container my-arch /root/file.txt ./
```

---

## ❓ 如何安装开发工具？

```bash
# Arch Linux
lxc exec my-arch -- bash /usr/local/share/lxd-multi-system/install-arch-tools

# Debian
lxc exec my-debian -- bash /usr/local/share/lxd-multi-system/install-debian-tools

# Fedora
lxc exec my-fedora -- bash /usr/local/share/lxd-multi-system/install-fedora-tools

# Kali Linux
lxc exec my-kali -- bash /usr/local/share/lxd-multi-system/fix-kali-install
```

---

## ❓ 更多问题？

查看完整文档：
- [在线安装指南](ONLINE-INSTALL.md)
- [工具安装指南](INSTALL-TOOLS.md)
- [Kali 工具说明](KALI-TOOLS.md)
