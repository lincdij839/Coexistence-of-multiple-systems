# 创建 APT 仓库指南

要实现 `apt install multi-system`，需要创建并发布 APT 仓库。

## 📦 步骤 1: 创建 .deb 包

虽然我们之前删除了 .deb 包，但要使用 apt 安装，必须有 .deb 包。

```bash
# 重新创建 .deb 包结构
mkdir -p multi-system_1.0.0/DEBIAN
mkdir -p multi-system_1.0.0/usr/local/bin
mkdir -p multi-system_1.0.0/usr/local/share/lxd-multi-system
mkdir -p multi-system_1.0.0/usr/local/share/doc/lxd-multi-system

# 复制文件
cp my-* container-menu list-containers check-containers start-container stop-container stop-all snapshot-container restore-snapshot backup-all set-limits copy-*-container multi-system_1.0.0/usr/local/bin/
cp install-*-tools fix-kali-install list-kali-tools multi-system_1.0.0/usr/local/share/lxd-multi-system/
cp README.md INSTALL-TOOLS.md KALI-TOOLS.md multi-system_1.0.0/usr/local/share/doc/lxd-multi-system/

# 创建 control 文件
cat > multi-system_1.0.0/DEBIAN/control << 'EOF'
Package: multi-system
Version: 1.0.0
Section: utils
Priority: optional
Architecture: all
Depends: lxd (>= 5.0) | snapd
Maintainer: Yuan <yuan@example.com>
Description: LXD 多系统容器管理工具
 提供便捷的 LXD 容器管理，包括：
 - 4个预配置容器：Arch, Debian, Fedora, Kali
 - 快速进入命令
 - 完整的管理工具
EOF

# 创建 postinst 脚本
cat > multi-system_1.0.0/DEBIAN/postinst << 'EOF'
#!/bin/bash
set -e
echo "multi-system 安装完成"
echo "运行: multi-system-setup 初始化容器"
EOF

chmod 755 multi-system_1.0.0/DEBIAN/postinst

# 构建 .deb 包
dpkg-deb --build multi-system_1.0.0
```

## 📦 步骤 2: 创建本地 APT 仓库

### 方法 A: 使用 GitHub Releases（推荐）

1. 上传 .deb 包到 GitHub Releases
2. 用户下载安装：

```bash
wget https://github.com/yourusername/lxd-multi-system/releases/download/v1.0.0/multi-system_1.0.0.deb
sudo apt install ./multi-system_1.0.0.deb
```

### 方法 B: 创建 PPA（Ubuntu）

1. 注册 Launchpad 账号
2. 创建 PPA
3. 上传包

用户使用：
```bash
sudo add-apt-repository ppa:yourusername/multi-system
sudo apt update
sudo apt install multi-system
```

### 方法 C: 自建 APT 仓库

```bash
# 1. 创建仓库目录
mkdir -p /var/www/apt/pool/main
mkdir -p /var/www/apt/dists/stable/main/binary-amd64

# 2. 复制 .deb 包
cp multi-system_1.0.0.deb /var/www/apt/pool/main/

# 3. 生成 Packages 文件
cd /var/www/apt
dpkg-scanpackages pool/main /dev/null | gzip -9c > dists/stable/main/binary-amd64/Packages.gz

# 4. 生成 Release 文件
cat > dists/stable/Release << 'EOF'
Origin: Multi-System
Label: Multi-System
Suite: stable
Codename: stable
Architectures: amd64
Components: main
Description: LXD Multi-System Repository
EOF

# 5. 配置 Web 服务器（nginx/apache）
# 用户添加仓库：
echo "deb [trusted=yes] http://your-server.com/apt stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list
sudo apt update
sudo apt install multi-system
```

## 🚀 最简单的方案：使用在线安装脚本

由于创建和维护 APT 仓库比较复杂，推荐使用在线安装脚本：

```bash
# 一键安装（效果类似 apt install）
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash
```

这个方案：
- ✅ 无需维护 APT 仓库
- ✅ 自动安装依赖
- ✅ 支持所有 Linux 发行版
- ✅ 一条命令完成安装
- ✅ 自动更新到最新版本

## 📝 总结

| 方案 | 优点 | 缺点 |
|------|------|------|
| 在线安装脚本 | 简单、快速、跨平台 | 不是标准 apt 包 |
| GitHub Releases | 简单、可靠 | 需要手动下载 |
| PPA | 标准 apt 方式 | 仅限 Ubuntu |
| 自建仓库 | 完全控制 | 需要服务器和维护 |

**推荐**: 使用在线安装脚本，它提供了最好的用户体验。
