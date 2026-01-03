# 🛡️ LogWarden v1.3

<p align="center">
  <img src="https://img.shields.io/badge/Security-Tool-00FF41?style=flat-square&logo=linux&logoColor=black" />
  <img src="https://img.shields.io/badge/Language-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white" />
  <img src="https://img.shields.io/badge/Focus-Blue%20Team-007ACC?style=flat-square" />
</p>

### 📜 Overview
**LogWarden** is a lightweight, high-speed Bash utility designed for security analysts to perform quick triage on web server access logs. It identifies common attack signatures and malicious patterns before deeper forensic analysis.

```bash
[SYSTEM_INFO]: Scanning for SQLi, XSS, and Path Traversal indicators.
```
---


```markdown
### 🔍 Key Features
* **Path Traversal Detection:** Identifies `../` and directory climbing attempts.
* **SQLi Pattern Matching:** Scans for keywords like `UNION`, `SELECT`, and `HEX` in URLs.
* **XSS Indicator Check:** Flags `<script>` tags and common JS event handlers.
* **Traffic Intelligence:** Automatically generates a Top 5 list of the most active (suspicious) source IPs.
```
---
### ⚙️ Installation & Usage

```bash
# Clone the repository
$ git clone https://github.com/Tiok0D/LogWarden.git

# Enter the directory
$ cd LogWarden

# Set execution permissions
$ chmod +x log-warden.sh

# Run analysis
$ ./log-warden.sh /path/to/access.log

```
---


### 🛠️ Technical Breakdown

| Module | Function | Priority |
| :--- | :--- | :--- |
| **Grep/Regex** | Pattern matching for known IoCs | Critical |
| **AWK Parser** | Data extraction and IP mapping | High |
| **Sort/Uniq** | Frequency analysis and deduplication | Medium |

---
### ⚠️ Disclaimer
This tool is for **educational and defensive purposes only**. Unauthorized access or analysis of logs from systems you do not own or have explicit permission to audit is illegal.

---

<p align="center">
  <code>[STATUS]: Developed by Bruno "KoD" Oliveira</code><br>
  <code>[BUILD]: Stable v1.3</code>
</p>
