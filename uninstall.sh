#!/bin/bash

set -e

echo "================================"
echo "  卸载 LXD 多系统容器管理工具"
echo "================================"
echo ""

# 检查是否为 root
if [ "$EUID" -ne 0 ]; then
    echo "请使用 sudo 运行此脚本"
    echo "用法: sudo bash uninstall.sh"
    exit 1
fi

read -p "是否删除所有容器? (yes/no): " delete_containers

if [ "$delete_containers" = "yes" ]; then
    echo ""
    echo "删除容器..."
    for container in my-arch my-debian my-fedora my-kali; do
        if lxc info "$container" &>/dev/null; then
            echo "  删除: $container"
            lxc delete "$container" --force
        fi
    done
    
    # 删除存储池
    if lxc storage list | grep -q "duoxitong"; then
        echo "  删除存储池: duoxitong"
        lxc storage delete duoxitong
    fi
fi

echo ""
echo "删除脚本..."

# 删除命令
SCRIPTS=(
    "my-arch" "my-debian" "my-fedora" "my-kali"
    "list-containers" "start-container" "stop-container" "stop-all"
    "backup-all" "container-menu" "check-containers"
    "set-limits" "snapshot-container" "restore-snapshot"
    "copy-to-container" "copy-from-container"
    "lxd-multi-system-setup"
)

for script in "${SCRIPTS[@]}"; do
    if [ -f "/usr/local/bin/$script" ]; then
        rm -f "/usr/local/bin/$script"
        echo "  ✓ 删除 $script"
    fi
done

# 删除工具和文档
echo ""
echo "删除工具和文档..."
rm -rf /usr/local/share/lxd-multi-system
rm -rf /usr/local/share/doc/lxd-multi-system
echo "  ✓ 完成"

echo ""
echo "================================"
echo "  ✓ 卸载完成！"
echo "================================"
echo ""

if [ "$delete_containers" != "yes" ]; then
    echo "注意: 容器和数据已保留"
    echo "如需删除，请手动运行:"
    echo "  lxc delete my-arch --force"
    echo "  lxc delete my-debian --force"
    echo "  lxc delete my-fedora --force"
    echo "  lxc delete my-kali --force"
    echo ""
fi
