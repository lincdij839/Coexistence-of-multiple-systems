# Kali Linux 工具安装指南

## 快速安装

### 方式 1: 使用安装脚本（推荐）
```bash
install-kali-tools
```
然后选择安装方案：
- **选项 5（推荐）**: 常用渗透测试工具 (~2GB)
- **选项 3**: 默认工具集 (~3.5GB)
- **选项 2**: 大型工具集 (~9GB)
- **选项 1**: 完整工具集 (~15GB) ⚠️ 需要大量空间和时间

### 方式 2: 手动安装
```bash
my-kali
apt update
apt install -y kali-linux-default
```

## 查看已安装工具
```bash
list-kali-tools
```

## 工具分类包

### 信息收集
```bash
apt install -y kali-tools-information-gathering
```
包含: nmap, masscan, dnsenum, dnsrecon, fierce, nikto, whatweb 等

### 漏洞分析
```bash
apt install -y kali-tools-vulnerability
```
包含: OpenVAS, Nessus, Nikto 等

### Web 应用测试
```bash
apt install -y kali-tools-web
```
包含: Burp Suite, sqlmap, dirb, gobuster, wfuzz, ZAP 等

### 密码攻击
```bash
apt install -y kali-tools-passwords
```
包含: John the Ripper, Hashcat, Hydra, Medusa 等

### 无线攻击
```bash
apt install -y kali-tools-wireless
```
包含: Aircrack-ng, Reaver, Wifite, Bully 等

### 漏洞利用
```bash
apt install -y kali-tools-exploitation
```
包含: Metasploit Framework, SearchSploit 等

### 嗅探/欺骗
```bash
apt install -y kali-tools-sniffing-spoofing
```
包含: Wireshark, tcpdump, Ettercap, Bettercap 等

### 后渗透
```bash
apt install -y kali-tools-post-exploitation
```
包含: Mimikatz, CrackMapExec, Evil-WinRM, BloodHound 等

### 逆向工程
```bash
apt install -y kali-tools-reverse-engineering
```
包含: Ghidra, radare2, IDA Free 等

### 取证
```bash
apt install -y kali-tools-forensics
```
包含: Autopsy, Volatility, Foremost 等

## 常用单个工具安装

### 网络扫描
```bash
apt install -y nmap masscan
```

### Web 测试
```bash
apt install -y burpsuite sqlmap nikto dirb gobuster wpscan
```

### 密码破解
```bash
apt install -y john hashcat hydra medusa
```

### 漏洞利用框架
```bash
apt install -y metasploit-framework
```

### 无线工具
```bash
apt install -y aircrack-ng reaver wifite
```

### 网络分析
```bash
apt install -y wireshark tcpdump
```

### Windows 渗透
```bash
apt install -y crackmapexec evil-winrm impacket-scripts bloodhound
```

## 推荐工具组合

### 基础渗透测试 (~500MB)
```bash
apt install -y \
    nmap \
    nikto \
    dirb \
    sqlmap \
    hydra \
    john \
    netcat-traditional \
    tcpdump
```

### Web 应用测试 (~1GB)
```bash
apt install -y \
    burpsuite \
    zaproxy \
    sqlmap \
    nikto \
    dirb \
    gobuster \
    wfuzz \
    wpscan \
    whatweb
```

### 内网渗透 (~1.5GB)
```bash
apt install -y \
    metasploit-framework \
    crackmapexec \
    evil-winrm \
    impacket-scripts \
    bloodhound \
    responder \
    enum4linux \
    smbclient
```

### 无线安全 (~300MB)
```bash
apt install -y \
    aircrack-ng \
    reaver \
    wifite \
    bully \
    bettercap
```

## 使用技巧

### 1. 在安装前创建快照
```bash
snapshot-container my-kali before-tools
```

### 2. 设置资源限制
```bash
# 安装时给予更多资源
set-limits my-kali 2048 2

# 安装后恢复
set-limits my-kali medium
```

### 3. 清理不需要的包
```bash
my-kali
apt autoremove
apt clean
```

### 4. 更新工具
```bash
my-kali
apt update && apt upgrade -y
```

### 5. 搜索特定工具
```bash
my-kali
apt search <工具名>
apt show <工具名>
```

## 常见问题

### Q: 安装需要多长时间？
- 核心工具: 10 分钟
- 默认工具集: 15-30 分钟
- 大型工具集: 30-60 分钟
- 完整工具集: 1-2 小时

### Q: 需要多少磁盘空间？
- 核心: ~1.5GB
- 默认: ~3.5GB
- 大型: ~9GB
- 完整: ~15GB

### Q: 如何节省空间？
1. 只安装需要的工具分类
2. 定期运行 `apt autoremove` 和 `apt clean`
3. 删除不用的工具包

### Q: Metasploit 无法启动？
```bash
my-kali
msfdb init
msfconsole
```

### Q: 如何更新 Exploit 数据库？
```bash
my-kali
searchsploit -u
```

## 工具使用示例

### Nmap 扫描
```bash
nmap -sV -sC 192.168.1.1
```

### Nikto Web 扫描
```bash
nikto -h http://example.com
```

### SQLMap 注入测试
```bash
sqlmap -u "http://example.com/page?id=1" --dbs
```

### Hydra 暴力破解
```bash
hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://192.168.1.1
```

### Metasploit
```bash
msfconsole
search exploit
use exploit/...
set RHOST 192.168.1.1
exploit
```

## 资源链接

- Kali 官方文档: https://www.kali.org/docs/
- 工具列表: https://www.kali.org/tools/
- Metasploit 文档: https://docs.metasploit.com/
- OWASP 测试指南: https://owasp.org/www-project-web-security-testing-guide/

## 法律声明

⚠️ **重要**: 这些工具仅用于合法的安全测试和教育目的。未经授权对系统进行渗透测试是违法的。请确保：

1. 获得明确的书面授权
2. 在隔离的测试环境中练习
3. 遵守当地法律法规
4. 负责任地使用这些工具
