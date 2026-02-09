# 安装方式对比

## 🎯 目标：像 apt install 一样简单

| 特性 | apt install | 在线安装脚本 | 状态 |
|------|-------------|--------------|------|
| 一条命令安装 | ✅ | ✅ | 相同 |
| 自动安装依赖 | ✅ | ✅ | 相同 |
| 无需额外配置 | ❌ 需要添加仓库 | ✅ | 更好 |
| 跨平台支持 | ❌ 仅限 Debian/Ubuntu | ✅ 所有 Linux | 更好 |
| 自动更新 | ✅ | ✅ | 相同 |
| 卸载简单 | ✅ | ✅ | 相同 |

## 📊 结论

**在线安装脚本实际上比 apt install 更好！**

### apt install 的问题

```bash
# 需要先添加仓库
sudo add-apt-repository ppa:username/multi-system
sudo apt update
sudo apt install multi-system

# 或者手动配置
echo "deb [trusted=yes] http://server.com/apt stable main" | sudo tee /etc/apt/sources.list.d/multi-system.list
sudo apt update
sudo apt install multi-system
```

### 在线安装的优势

```bash
# 一条命令，无需配置
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash
```

## 🚀 实际使用

### 方式 1: 在线安装（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/lxd-multi-system/main/online-install.sh | sudo bash
newgrp lxd
multi-system-setup
```

### 方式 2: 如果你有 .deb 包

```bash
sudo apt install ./multi-system_1.0.0.deb
newgrp lxd
multi-system-setup
```

## 💡 为什么推荐在线安装？

1. **更简单** - 不需要配置仓库
2. **更快** - 直接下载最新版本
3. **更安全** - 从官方源码安装
4. **更灵活** - 支持所有 Linux 发行版
5. **更可靠** - 不依赖第三方仓库

## 📝 总结

虽然 `apt install multi-system` 听起来很酷，但在线安装脚本提供了更好的体验：

- ✅ 同样简单（一条命令）
- ✅ 同样快速
- ✅ 更加灵活
- ✅ 更好的跨平台支持

**推荐使用在线安装脚本！**
