# 本地安装指南

## 🚀 快速安装（推荐）

由于 APT 仓库还未发布到 GitHub Pages，使用以下方法安装：

### 方法 1: 使用本地 .deb 包

```bash
# 进入项目目录
cd ~/多系统

# 安装 .deb 包
sudo apt install ./multi-system_1.0.0.deb

# 或使用 dpkg
sudo dpkg -i multi-system_1.0.0.deb
sudo apt-get install -f  # 修复依赖

# 初始化
newgrp lxd
multi-system-setup
```

### 方法 2: 使用在线安装脚本（最简单）

```bash
cd ~/多系统
sudo bash online-install.sh
newgrp lxd
multi-system-setup
```

## 📦 发布到 GitHub Pages 后

完成以下步骤后，用户可以使用 `apt install multi-system`：

### 1. 创建 GitHub 仓库

```bash
# 初始化 git
git init
git add .
git commit -m "Initial commit with APT repository"

# 创建 GitHub 仓库
# 访问 https://github.com/new
# 创建名为 lxd-multi-system 的公开仓库

# 推送代码
git remote add origin https://github.com/yourusername/lxd-multi-system.git
git branch -M main
git push -u origin main
```

### 2. 启用 GitHub Pages

1. 访问: `https://github.com/yourusername/lxd-multi-system/settings/pages`
2. Source: 选择 `main` 分支
3. Folder: 选择 `/ (root)`
4. 点击 Save

等待 1-2 分钟后生效。

### 3. 用户使用

```bash
# 添加仓库
echo "deb [trusted=yes] https://yourusername.github.io/lxd-multi-system/debian-repo stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list

# 安装
sudo apt update
sudo apt install multi-system
```

## ✅ 验证安装

```bash
# 检查命令是否可用
which my-arch
which multi-system-setup

# 查看包信息
dpkg -l | grep multi-system

# 查看安装的文件
dpkg -L multi-system
```

## 🗑️ 卸载

```bash
# 保留容器
sudo apt remove multi-system

# 完全删除
sudo apt purge multi-system
```

## 🔧 故障排查

### 问题: 依赖问题

```bash
# 修复依赖
sudo apt-get install -f
```

### 问题: 权限问题

```bash
# 确保在 lxd 组
sudo usermod -aG lxd $USER
newgrp lxd
```

### 问题: LXD 未安装

```bash
# 安装 LXD
sudo snap install lxd
sudo lxd init --auto
```
