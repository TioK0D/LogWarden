#!/bin/bash

# ==============================================================================
# LOG WARDEN v1.0
# Author: Bruno "KoD" Oliveira
# Description: Quick triage for web server access logs (SQLi, XSS, LFI/RFI)
# This tool is for **educational and defensive purposes only**.
# Unauthorized access or analysis of logs from systems is illegal. 
# I am not responsible for any damage :)
# ==============================================================================

# Terminal Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

LOG_FILE=$1

# Header
echo -e "${BLUE}==================================================${NC}"
echo -e "${GREEN}          LOG WARDEN - SECURITY SCANNER           ${NC}"
echo -e "${BLUE}==================================================${NC}"

# Check if file was provided
if [ -z "$1" ]; then
    echo -e "${RED}[!] ERROR: No log file specified.${NC}"
    echo -e "${YELLOW}Usage: ./log-warden.sh <path_to_access_log>${NC}"
    exit 1
fi

# Check if file exists
if [ ! -f "$LOG_FILE" ]; then
    echo -e "${RED}[!] ERROR: File $LOG_FILE not found!${NC}"
    exit 1
fi

echo -e "${YELLOW}[*] Target:${NC} $LOG_FILE"
echo -e "${YELLOW}[*] Time:${NC} $(date)"
echo -e "--------------------------------------------------"

# 1. Path Traversal / LFI Detection
echo -e "${RED}[!] Checking for Path Traversal attempts...${NC}"
grep -E "(\.\.\/|\.\.\\\\|\/etc\/passwd|\/bin\/bash)" "$LOG_FILE" | awk '{print "  [!] IP: " $1 " -> Request: " $7}' | sort | uniq -c | sort -nr
echo ""

# 2. SQL Injection Detection
echo -e "${RED}[!] Checking for SQL Injection patterns...${NC}"
grep -Ei "(UNION|SELECT|INSERT|DELETE|DROP|UPDATE|CAST|GROUP BY|ORDER BY|--|#|OR 1=1)" "$LOG_FILE" | awk '{print "  [!] IP: " $1 " -> Request: " $7}' | sort | uniq -c | sort -nr
echo ""

# 3. XSS Detection
echo -e "${RED}[!] Checking for Cross-Site Scripting (XSS)...${NC}"
grep -Ei "(<script>|alert\(|<img|onload=|onerror=|javascript:)" "$LOG_FILE" | awk '{print "  [!] IP: " $1 " -> Request: " $7}' | sort | uniq -c | sort -nr
echo ""

# 4. Suspicious IP Ranking
echo -e "${YELLOW}[+] Top 5 Most Active (Suspicious) IPs:${NC}"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | awk '{print "  [-] Count: " $1 " | IP: " $2}'
echo ""

echo -e "${BLUE}--------------------------------------------------${NC}"
echo -e "${GREEN}[V] Scan Completed Successfully.${NC}"
echo -e "${BLUE}==================================================${NC}"
