# Multi-System APT Repository

## 添加仓库

```bash
# 添加仓库
echo "deb [trusted=yes] https://lincdij839.github.io/Coexistence-of-multiple-systems/debian-repo stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list

# 更新并安装
sudo apt update
sudo apt install multi-system
```

## 使用

```bash
# 初始化
newgrp lxd
multi-system-setup

# 使用
my-arch
my-debian
my-fedora
my-kali
```

## 卸载

```bash
sudo apt remove multi-system
```
