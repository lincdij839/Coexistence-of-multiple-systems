#!/bin/bash

echo "================================"
echo "  multi-system 本地安装"
echo "================================"
echo ""

# 检查是否为 root
if [ "$EUID" -ne 0 ]; then
    echo "请使用 sudo 运行此脚本"
    echo "用法: sudo bash INSTALL-NOW.sh"
    exit 1
fi

# 检查 .deb 包
if [ ! -f "multi-system_1.0.0.deb" ]; then
    echo "❌ 找不到 multi-system_1.0.0.deb"
    echo "请确保在项目目录中运行此脚本"
    exit 1
fi

echo "【1/3】安装 .deb 包..."
apt install -y ./multi-system_1.0.0.deb

if [ $? -eq 0 ]; then
    echo "  ✓ 安装成功"
else
    echo "  ✗ 安装失败"
    echo "  尝试修复依赖..."
    apt-get install -f -y
fi

echo ""
echo "【2/3】检查 LXD..."
if ! command -v lxc &>/dev/null; then
    echo "  安装 LXD..."
    snap install lxd
    lxd init --auto
else
    echo "  ✓ LXD 已安装"
fi

echo ""
echo "【3/3】配置用户权限..."
REAL_USER=${SUDO_USER:-$USER}
if ! groups $REAL_USER | grep -q lxd; then
    usermod -aG lxd $REAL_USER
    echo "  ✓ 已添加 $REAL_USER 到 lxd 组"
else
    echo "  ✓ 用户已在 lxd 组中"
fi

echo ""
echo "================================"
echo "  ✓ 安装完成！"
echo "================================"
echo ""
echo "下一步："
echo "  1. 重新登录或运行: newgrp lxd"
echo "  2. 初始化容器: multi-system-setup"
echo "  3. 使用: my-arch, my-debian, my-fedora, my-kali"
echo ""
echo "验证安装:"
echo "  which multi-system-setup"
echo "  dpkg -l | grep multi-system"
echo ""
