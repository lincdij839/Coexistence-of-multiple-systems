# GitHub Pages APT 仓库设置指南

## ✅ 已完成

1. ✅ 创建 .deb 包: `multi-system_1.0.0.deb`
2. ✅ 创建 APT 仓库结构: `debian-repo/`
3. ✅ 生成 Packages 文件
4. ✅ 生成 Release 文件

## 📦 仓库结构

```
debian-repo/
├── pool/main/
│   └── multi-system_1.0.0.deb
├── dists/stable/
│   ├── Release
│   └── main/binary-amd64/
│       ├── Packages
│       └── Packages.gz
└── README.md
```

## 🚀 发布步骤

### 步骤 1: 初始化 Git 仓库

```bash
# 如果还没有初始化
git init
git add .
git commit -m "Add APT repository"
```

### 步骤 2: 创建 GitHub 仓库

1. 访问 https://github.com/new
2. 仓库名: `lxd-multi-system`
3. 设置为 Public
4. 点击 "Create repository"

### 步骤 3: 推送代码

```bash
# 添加远程仓库
git remote add origin https://github.com/yourusername/lxd-multi-system.git

# 推送代码
git branch -M main
git push -u origin main
```

### 步骤 4: 启用 GitHub Pages

1. 访问仓库设置: `https://github.com/yourusername/lxd-multi-system/settings/pages`
2. **Source**: 选择 `main` 分支
3. **Folder**: 选择 `/ (root)`
4. 点击 **Save**

等待 1-2 分钟，GitHub Pages 将在以下地址可用：
`https://yourusername.github.io/lxd-multi-system/`

### 步骤 5: 验证仓库

访问以下 URL 确认文件可访问：

- https://yourusername.github.io/lxd-multi-system/debian-repo/dists/stable/Release
- https://yourusername.github.io/lxd-multi-system/debian-repo/dists/stable/main/binary-amd64/Packages
- https://yourusername.github.io/lxd-multi-system/debian-repo/pool/main/multi-system_1.0.0.deb

## 🎯 用户使用方法

### 添加仓库并安装

```bash
# 添加 APT 仓库
echo "deb [trusted=yes] https://yourusername.github.io/lxd-multi-system/debian-repo stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list

# 更新包列表
sudo apt update

# 安装
sudo apt install multi-system

# 初始化
newgrp lxd
multi-system-setup

# 使用
my-arch
my-debian
my-fedora
my-kali
```

### 更新

```bash
sudo apt update
sudo apt upgrade multi-system
```

### 卸载

```bash
# 保留容器
sudo apt remove multi-system

# 完全删除（包括配置）
sudo apt purge multi-system
```

## 📝 更新仓库

当有新版本时：

```bash
# 1. 更新版本号并重新构建
# 编辑 multi-system_1.0.1/DEBIAN/control
dpkg-deb --build multi-system_1.0.1

# 2. 复制到仓库
cp multi-system_1.0.1.deb debian-repo/pool/main/

# 3. 更新索引
dpkg-scanpackages debian-repo/pool/main /dev/null > debian-repo/dists/stable/main/binary-amd64/Packages
dpkg-scanpackages debian-repo/pool/main /dev/null | gzip -9c > debian-repo/dists/stable/main/binary-amd64/Packages.gz

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

## 🔧 故障排查

### 问题 1: 无法访问仓库

检查 GitHub Pages 是否已启用：
- 访问 `https://github.com/yourusername/lxd-multi-system/settings/pages`
- 确认显示 "Your site is published at..."

### 问题 2: apt update 失败

```bash
# 检查仓库 URL 是否正确
cat /etc/apt/sources.list.d/multi-system.list

# 手动测试 URL
curl -I https://yourusername.github.io/lxd-multi-system/debian-repo/dists/stable/Release
```

### 问题 3: 包签名问题

由于 GitHub Pages 不支持 GPG 签名，使用 `[trusted=yes]` 选项：

```bash
deb [trusted=yes] https://yourusername.github.io/lxd-multi-system/debian-repo stable main
```

## 🌟 完成！

现在用户可以通过标准的 `apt install` 命令安装你的包了！

```bash
sudo apt install multi-system
```

## 📚 相关文档

- [PUBLISH-TO-APT.md](PUBLISH-TO-APT.md) - 完整发布指南
- [debian-repo/README.md](debian-repo/README.md) - 仓库使用说明
- [README.md](README.md) - 项目主文档
