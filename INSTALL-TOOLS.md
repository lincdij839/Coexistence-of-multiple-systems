# 容器工具完整安装指南

## 快速开始

### 1. Kali Linux（安全测试工具）

#### 修复并安装
```bash
# 先创建快照
snapshot-container my-kali before-tools

# 修复依赖并安装工具
fix-kali-install
```

这将安装：
- kali-linux-large（避免依赖冲突）
- 常用渗透测试工具：nmap, metasploit, sqlmap, burpsuite, hydra 等

#### 查看已安装工具
```bash
list-kali-tools
```

---

### 2. Arch Linux（滚动更新开发）

```bash
# 先创建快照
snapshot-container my-arch before-tools

# 运行安装向导
install-arch-tools
```

#### 安装方案：

**方案 1: 完整开发环境 (~4GB)**
- 所有编程语言：Python, Node.js, Go, Rust, PHP, Java, Ruby
- Web 服务器：Nginx, Apache
- 数据库：MariaDB, PostgreSQL, Redis
- 容器工具：Docker
- 开发工具：Git, Vim, Tmux 等

**方案 2: Web 开发 (~1.5GB)**
- Node.js + npm
- Python + pip
- PHP + Composer
- Nginx
- MariaDB, PostgreSQL, Redis

**方案 3: 系统开发 (~1GB)**
- C/C++ (GCC, Clang)
- Go
- Rust
- 调试工具：GDB, Valgrind

**方案 4: Python 开发 (~600MB)**
- Python + pip
- 常用库：Flask, Django, FastAPI, NumPy, Pandas
- 开发工具：pytest, black, pylint

**方案 5: 容器开发 (~400MB)**
- Docker + Docker Compose
- Podman, Buildah

---

### 3. Debian（稳定开发）

```bash
# 先创建快照
snapshot-container my-debian before-tools

# 运行安装向导
install-debian-tools
```

#### 安装方案：

**方案 1: 完整开发环境 (~5GB)**
- 所有编程语言：Python, Node.js, Go, Rust, PHP, Java, Ruby
- Web 服务器：Nginx, Apache
- 数据库：MySQL, PostgreSQL, Redis
- 容器工具：Docker
- 开发工具：Git, Vim, Tmux 等

**方案 2: Web 开发 (~2GB)**
- Node.js + npm
- Python3 + pip
- PHP + Composer
- Nginx
- MySQL, PostgreSQL, Redis

**方案 3: 系统开发 (~1.5GB)**
- C/C++ (GCC, Clang)
- Go
- Rust
- 调试工具：GDB, Valgrind

**方案 4: Python 开发 (~800MB)**
- Python3 + pip
- 常用库：Flask, Django, FastAPI, NumPy, Pandas
- 开发工具：pytest, black, pylint

**方案 5: 容器开发 (~500MB)**
- Docker + Docker Compose
- Podman, Buildah

---

### 4. Fedora（最新特性开发）

```bash
# 先创建快照
snapshot-container my-fedora before-tools

# 运行安装向导
install-fedora-tools
```

#### 安装方案（与 Debian 类似）：

1. 完整开发环境 (~5GB)
2. Web 开发 (~2GB)
3. 系统开发 (~1.5GB)
4. Python 开发 (~800MB)
5. 容器开发 (~500MB) - 使用 Podman（Fedora 默认）

---

## 推荐工作流程

### 场景 1: 安全测试
```bash
# 1. 进入 Kali
my-kali

# 2. 使用工具
nmap -sV target.com
sqlmap -u "http://target.com/page?id=1"
msfconsole
```

### 场景 2: Web 开发
```bash
# 1. 在 Debian 安装 Web 开发环境
install-debian-tools  # 选择方案 2

# 2. 进入容器
my-debian

# 3. 创建项目
mkdir myproject && cd myproject
python3 -m venv venv
source venv/bin/activate
pip install flask
```

### 场景 3: 系统编程
```bash
# 1. 在 Fedora 安装系统开发环境
install-fedora-tools  # 选择方案 3

# 2. 进入容器
my-fedora

# 3. 编译项目
gcc -o myapp main.c
go build
cargo build --release
```

---

## 资源管理建议

### 安装前
```bash
# 1. 创建快照
snapshot-container <容器名> before-install

# 2. 分配更多资源（安装时）
set-limits <容器名> 2048 2
```

### 安装后
```bash
# 1. 恢复资源限制
set-limits <容器名> medium

# 2. 清理缓存
my-debian
apt autoremove && apt clean

my-fedora
dnf clean all

my-kali
apt autoremove && apt clean
```

### 如果安装失败
```bash
# 恢复快照
restore-snapshot <容器名> before-install
```

---

## 各容器推荐配置

| 容器 | 用途 | 推荐方案 | 资源限制 |
|------|------|----------|----------|
| my-kali | 安全测试 | fix-kali-install | 1GB RAM, 2 CPU |
| my-arch | 滚动更新开发 | 完整开发环境 | 1GB RAM, 2 CPU |
| my-debian | 稳定开发 | Web开发/Python开发 | 512MB RAM, 2 CPU |
| my-fedora | 最新特性 | 完整开发环境 | 1GB RAM, 2 CPU |

---

## 常用命令速查

### 容器管理
```bash
list-containers          # 查看所有容器状态
start-container <名称>   # 启动容器
stop-container <名称>    # 停止容器
my-<系统名>              # 进入容器
```

### 工具安装
```bash
fix-kali-install         # 修复并安装 Kali 工具
install-arch-tools       # 安装 Arch Linux 开发工具
install-debian-tools     # 安装 Debian 开发工具
install-fedora-tools     # 安装 Fedora 开发工具
list-kali-tools          # 查看 Kali 工具清单
```

### 快照管理
```bash
snapshot-container <名称> <快照名>     # 创建快照
restore-snapshot <名称> <快照名>       # 恢复快照
```

### 文件传输
```bash
copy-to-container <容器> <文件> <目标路径>
copy-from-container <容器> <文件> <本地路径>
```

---

## 故障排查

### Kali 依赖冲突
```bash
# 使用修复脚本
fix-kali-install

# 或手动修复
my-kali
apt --fix-broken install
apt install -y kali-linux-large
```

### Debian/Fedora 安装失败
```bash
# 更新软件源
my-debian
apt update && apt upgrade

my-fedora
dnf update
```

### 磁盘空间不足
```bash
# 清理所有容器
for c in my-kali my-debian my-fedora; do
    lxc exec $c -- bash -c "apt autoremove -y && apt clean" 2>/dev/null
    lxc exec $c -- bash -c "dnf clean all" 2>/dev/null
done

# 查看占用
du -sh containers/*/rootfs
```

---

## 下一步

安装完成后，你可以：

1. **学习工具使用** - 查看 KALI-TOOLS.md
2. **配置开发环境** - 安装 IDE、配置 Git
3. **创建项目** - 在容器中开始开发
4. **定期备份** - 使用 `backup-all` 导出容器

详细文档：
- [README.md](README.md) - 总体使用说明
- [KALI-TOOLS.md](KALI-TOOLS.md) - Kali 工具详细指南
