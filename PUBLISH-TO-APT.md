# 发布到 APT 仓库指南

## ✅ 已完成的步骤

1. ✅ 创建 .deb 包
2. ✅ 创建 APT 仓库结构
3. ✅ 生成 Packages 文件
4. ✅ 生成 Release 文件

## 📦 生成的文件

```
debian-repo/
├── pool/main/
│   └── multi-system_1.0.0.deb    # .deb 包
├── dists/stable/
│   ├── Release                    # 仓库元数据
│   └── main/binary-amd64/
│       ├── Packages               # 包列表
│       └── Packages.gz            # 压缩的包列表
└── README.md                      # 使用说明
```

## 🚀 发布步骤

### 方法 1: 使用 GitHub Pages（推荐，免费）

#### 步骤 1: 创建 GitHub 仓库

```bash
# 初始化 git（如果还没有）
git init
git add .
git commit -m "Initial commit with APT repository"

# 创建 GitHub 仓库
# 访问 https://github.com/new
# 创建名为 lxd-multi-system 的仓库

# 推送代码
git remote add origin https://github.com/yourusername/lxd-multi-system.git
git branch -M main
git push -u origin main
```

#### 步骤 2: 启用 GitHub Pages

1. 访问仓库设置: `https://github.com/yourusername/lxd-multi-system/settings/pages`
2. Source 选择: `main` 分支
3. 文件夹选择: `/ (root)`
4. 点击 Save

等待几分钟后，仓库将在以下地址可用：
`https://yourusername.github.io/lxd-multi-system/`

#### 步骤 3: 用户使用

```bash
# 添加仓库
echo "deb [trusted=yes] https://yourusername.github.io/lxd-multi-system/debian-repo stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list

# 更新并安装
sudo apt update
sudo apt install multi-system

# 初始化
newgrp lxd
multi-system-setup

# 使用
my-arch
```

### 方法 2: 使用 GitHub Releases

#### 步骤 1: 创建 Release

```bash
# 创建 tag
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0

# 访问 GitHub 创建 Release
# https://github.com/yourusername/lxd-multi-system/releases/new
# 上传 multi-system_1.0.0.deb
```

#### 步骤 2: 用户使用

```bash
# 下载并安装
wget https://github.com/yourusername/lxd-multi-system/releases/download/v1.0.0/multi-system_1.0.0.deb
sudo apt install ./multi-system_1.0.0.deb

# 初始化
newgrp lxd
multi-system-setup
```

### 方法 3: 使用 Launchpad PPA（仅 Ubuntu）

#### 步骤 1: 注册 Launchpad

1. 访问 https://launchpad.net/
2. 注册账号
3. 创建 PPA

#### 步骤 2: 上传包

```bash
# 安装工具
sudo apt install devscripts dput

# 构建源码包
debuild -S -sa

# 上传到 PPA
dput ppa:yourusername/multi-system multi-system_1.0.0_source.changes
```

#### 步骤 3: 用户使用

```bash
# 添加 PPA
sudo add-apt-repository ppa:yourusername/multi-system
sudo apt update
sudo apt install multi-system
```

## 📝 推荐方案对比

| 方案 | 优点 | 缺点 | 推荐度 |
|------|------|------|--------|
| GitHub Pages | 免费、简单、快速 | 需要 [trusted=yes] | ⭐⭐⭐⭐⭐ |
| GitHub Releases | 简单、可靠 | 需要手动下载 | ⭐⭐⭐⭐ |
| Launchpad PPA | 标准 apt 方式 | 仅限 Ubuntu、复杂 | ⭐⭐⭐ |
| 在线安装脚本 | 最简单、跨平台 | 不是标准 apt | ⭐⭐⭐⭐⭐ |

## 🎯 最终推荐

### 对于用户

**使用 GitHub Pages APT 仓库**:

```bash
echo "deb [trusted=yes] https://yourusername.github.io/lxd-multi-system/debian-repo stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list
sudo apt update
sudo apt install multi-system
```

### 对于开发者

**同时提供多种方式**:

1. **APT 仓库** - 给喜欢 apt 的用户
2. **在线安装** - 给追求简单的用户
3. **GitHub Releases** - 给需要离线安装的用户

## 🔄 更新流程

当有新版本时：

```bash
# 1. 更新版本号
# 编辑 multi-system_1.0.1/DEBIAN/control

# 2. 重新构建
dpkg-deb --build multi-system_1.0.1

# 3. 更新仓库
cp multi-system_1.0.1.deb debian-repo/pool/main/
cd debian-repo
dpkg-scanpackages pool/main /dev/null | gzip -9c > dists/stable/main/binary-amd64/Packages.gz
dpkg-scanpackages pool/main /dev/null > dists/stable/main/binary-amd64/Packages

# 4. 提交并推送
git add .
git commit -m "Release v1.0.1"
git push
```

用户更新：

```bash
sudo apt update
sudo apt upgrade multi-system
```

## ✅ 验证

测试仓库是否正常工作：

```bash
# 添加仓库
echo "deb [trusted=yes] https://yourusername.github.io/lxd-multi-system/debian-repo stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list

# 更新
sudo apt update

# 搜索包
apt search multi-system

# 查看包信息
apt show multi-system

# 安装
sudo apt install multi-system
```

## 🎉 完成！

现在用户可以通过以下方式安装：

```bash
# 方式 1: APT 仓库（推荐）
echo "deb [trusted=yes] https://yourusername.github.io/lxd-multi-system/debian-repo stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list
sudo apt update
sudo apt install multi-system

# 方式 2: 在线安装（最简单）
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash

# 方式 3: 下载 .deb（离线）
wget https://github.com/yourusername/lxd-multi-system/releases/download/v1.0.0/multi-system_1.0.0.deb
sudo apt install ./multi-system_1.0.0.deb
```
