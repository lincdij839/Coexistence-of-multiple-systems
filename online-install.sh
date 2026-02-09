#!/bin/bash

set -e

REPO_URL="https://raw.githubusercontent.com/yourusername/lxd-multi-system/main"
INSTALL_DIR="/tmp/lxd-multi-system-install"

echo "================================"
echo "  LXD 多系统容器管理工具"
echo "  在线安装"
echo "================================"
echo ""

# 检查是否为 root
if [ "$EUID" -ne 0 ]; then
    echo "请使用 sudo 运行此脚本"
    echo "用法: curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash"
    exit 1
fi

# 获取实际用户
REAL_USER=${SUDO_USER:-$USER}
REAL_HOME=$(eval echo ~$REAL_USER)

echo "安装用户: $REAL_USER"
echo "工作目录: $REAL_HOME/多系统"
echo ""

# 创建临时目录
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

echo "【1/6】下载安装文件..."

# 下载所有必需文件
FILES=(
    "my-arch" "my-debian" "my-fedora" "my-kali"
    "list-containers" "start-container" "stop-container" "stop-all"
    "backup-all" "container-menu" "check-containers"
    "set-limits" "snapshot-container" "restore-snapshot"
    "copy-to-container" "copy-from-container"
    "install-arch-tools" "install-debian-tools" 
    "install-fedora-tools" "install-kali-tools"
    "fix-kali-install" "list-kali-tools"
    "README.md" "INSTALL-TOOLS.md" "KALI-TOOLS.md"
)

for file in "${FILES[@]}"; do
    echo "  下载: $file"
    curl -fsSL "$REPO_URL/$file" -o "$file" || {
        echo "  ✗ 下载失败: $file"
        exit 1
    }
done

echo "  ✓ 下载完成"

# 检查依赖
echo ""
echo "【2/6】检查依赖..."
if ! command -v lxc &>/dev/null; then
    echo "  安装 LXD..."
    if command -v snap &>/dev/null; then
        snap install lxd
    elif command -v apt &>/dev/null; then
        apt update && apt install -y lxd
    elif command -v dnf &>/dev/null; then
        dnf install -y lxd
    elif command -v pacman &>/dev/null; then
        pacman -S --noconfirm lxd
    else
        echo "  ✗ 无法自动安装 LXD，请手动安装"
        exit 1
    fi
    echo "  初始化 LXD..."
    lxd init --auto
else
    echo "  ✓ LXD 已安装"
fi

# 添加用户到 lxd 组
echo ""
echo "【3/6】配置用户权限..."
if ! groups $REAL_USER | grep -q lxd; then
    usermod -aG lxd $REAL_USER
    echo "  ✓ 已添加 $REAL_USER 到 lxd 组"
else
    echo "  ✓ 用户已在 lxd 组中"
fi

# 创建工作目录
echo ""
echo "【4/6】创建工作目录..."
WORK_DIR="$REAL_HOME/多系统"
mkdir -p "$WORK_DIR"
chown $REAL_USER:$REAL_USER "$WORK_DIR"
echo "  ✓ $WORK_DIR"

# 安装脚本
echo ""
echo "【5/6】安装管理脚本..."

# 复制命令到 /usr/local/bin
SCRIPTS=(
    "my-arch" "my-debian" "my-fedora" "my-kali"
    "list-containers" "start-container" "stop-container" "stop-all"
    "backup-all" "container-menu" "check-containers"
    "set-limits" "snapshot-container" "restore-snapshot"
    "copy-to-container" "copy-from-container"
)

for script in "${SCRIPTS[@]}"; do
    cp "$script" /usr/local/bin/
    chmod 755 /usr/local/bin/$script
    echo "  ✓ $script"
done

# 安装工具脚本
TOOL_DIR="/usr/local/share/lxd-multi-system"
mkdir -p "$TOOL_DIR"

TOOLS=(
    "install-arch-tools" "install-debian-tools" 
    "install-fedora-tools" "install-kali-tools"
    "fix-kali-install" "list-kali-tools"
)

for tool in "${TOOLS[@]}"; do
    cp "$tool" "$TOOL_DIR/"
    chmod 755 "$TOOL_DIR/$tool"
    echo "  ✓ $tool"
done

# 安装文档
DOC_DIR="/usr/local/share/doc/lxd-multi-system"
mkdir -p "$DOC_DIR"

DOCS=("README.md" "INSTALL-TOOLS.md" "KALI-TOOLS.md")
for doc in "${DOCS[@]}"; do
    cp "$doc" "$DOC_DIR/"
    echo "  ✓ $doc"
done

# 创建初始化脚本
echo ""
echo "【6/6】创建初始化脚本..."

cat > /usr/local/bin/multi-system-setup << 'SETUP_EOF'
#!/bin/bash

echo "================================"
echo "  LXD 多系统容器初始化"
echo "================================"
echo ""

# 检查是否以 root 运行
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  请不要使用 root 或 sudo 运行此脚本"
    echo "使用方法: multi-system-setup"
    exit 1
fi

# 检查 LXD
if ! command -v lxc &>/dev/null; then
    echo "❌ LXD 未安装"
    echo "请运行在线安装: curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash"
    exit 1
fi

# 检查权限
if ! lxc list &>/dev/null; then
    echo "❌ 没有 LXD 权限"
    echo "请重新登录或运行: newgrp lxd"
    exit 1
fi

# 创建工作目录
WORK_DIR="$HOME/多系统"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

echo "工作目录: $WORK_DIR"
echo ""

# 创建存储池
if ! lxc storage list | grep -q "duoxitong"; then
    echo "创建存储池: duoxitong"
    lxc storage create duoxitong dir source="$WORK_DIR"
fi

# 创建容器函数
create_container() {
    local name=$1
    local image=$2
    local desc=$3
    
    if lxc info "$name" &>/dev/null; then
        echo "✓ $name 已存在"
        return
    fi
    
    echo "创建容器: $name ($desc)"
    lxc launch "$image" "$name" -s duoxitong
    sleep 2
    
    # 等待网络就绪
    echo "  等待网络..."
    for i in {1..30}; do
        if lxc exec "$name" -- ping -c 1 8.8.8.8 &>/dev/null 2>&1; then
            break
        fi
        sleep 1
    done
    
    echo "  ✓ $name 创建完成"
}

echo "开始创建容器..."
echo ""

# 创建 4 个容器
create_container "my-arch" "images:archlinux" "Arch Linux"
create_container "my-debian" "images:debian/12" "Debian 12"
create_container "my-fedora" "images:fedora/39" "Fedora 39"
create_container "my-kali" "images:kali" "Kali Linux"

echo ""
echo "设置资源限制..."
set-limits my-arch 1024 2
set-limits my-debian 512 2
set-limits my-fedora 1024 2
set-limits my-kali 1024 2

echo ""
echo "创建初始快照..."
for container in my-arch my-debian my-fedora my-kali; do
    snapshot-container "$container" "initial-setup"
done

echo ""
echo "================================"
echo "  ✓ 初始化完成！"
echo "================================"
echo ""
echo "可用命令："
echo "  my-arch       - 进入 Arch Linux"
echo "  my-debian     - 进入 Debian"
echo "  my-fedora     - 进入 Fedora"
echo "  my-kali       - 进入 Kali Linux"
echo ""
echo "管理工具："
echo "  container-menu        - 交互式菜单"
echo "  list-containers       - 查看容器状态"
echo "  check-containers      - 检查容器完整性"
echo ""
echo "安装开发工具："
echo "  lxc exec my-arch -- bash /usr/local/share/lxd-multi-system/install-arch-tools"
echo "  lxc exec my-debian -- bash /usr/local/share/lxd-multi-system/install-debian-tools"
echo "  lxc exec my-fedora -- bash /usr/local/share/lxd-multi-system/install-fedora-tools"
echo "  lxc exec my-kali -- bash /usr/local/share/lxd-multi-system/fix-kali-install"
echo ""
echo "文档: /usr/local/share/doc/lxd-multi-system/"
echo ""
SETUP_EOF

chmod 755 /usr/local/bin/multi-system-setup
echo "  ✓ multi-system-setup"

# 清理临时文件
cd /
rm -rf "$INSTALL_DIR"

echo ""
echo "================================"
echo "  ✓ 安装完成！"
echo "================================"
echo ""
echo "下一步："
echo "  1. 重新登录或运行: newgrp lxd"
echo "  2. 创建容器: multi-system-setup"
echo "  3. 进入容器: my-arch, my-debian, my-fedora, my-kali"
echo ""
echo "文档位置: /usr/local/share/doc/lxd-multi-system/"
echo ""
