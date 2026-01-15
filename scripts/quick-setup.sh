#!/bin/bash
# 🚀 ONE-COMMAND COMPLETE AUTOMATION
# Generates SSH key, configures server, and displays instructions for GitHub secret

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}🚀 RPP AUTO - Quick Setup${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

# Quick config
SSH_USER="u102176229"
SSH_HOST="access5019379793.webspacehost.com"
KEY_NAME="ionos_deploy"

echo -e "${YELLOW}🔑 Generating SSH key...${NC}"
if [ ! -f ~/.ssh/$KEY_NAME ]; then
    ssh-keygen -t ed25519 -C "github-deploy" -f ~/.ssh/$KEY_NAME -N "" >/dev/null 2>&1
    echo -e "${GREEN}✅ SSH key created!${NC}"
else
    echo -e "${GREEN}ℹ️  Using existing key${NC}"
fi

echo ""
echo -e "${YELLOW}🔐 Adding key to IONOS server...${NC}"
echo -e "${YELLOW}Please enter your IONOS password when prompted:${NC}"
echo ""

ssh-copy-id -i ~/.ssh/${KEY_NAME}.pub -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST 2>/dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Server configured!${NC}"
else
    echo -e "${RED}❌ Failed. Trying alternative method...${NC}"
    cat ~/.ssh/${KEY_NAME}.pub | ssh $SSH_USER@$SSH_HOST "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
fi

echo ""
echo -e "${YELLOW}🧪 Testing connection...${NC}"
if ssh -i ~/.ssh/$KEY_NAME -o BatchMode=yes $SSH_USER@$SSH_HOST "echo 'Success'" >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Connection works!${NC}"
else
    echo -e "${RED}❌ Connection test failed${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}=====================================${NC}"
echo -e "${GREEN}✅ SETUP COMPLETE!${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""
echo -e "${YELLOW}🔑 GITHUB SECRET (Copy everything below):${NC}"
echo ""
echo "---BEGIN KEY---"
cat ~/.ssh/$KEY_NAME
echo "---END KEY---"
echo ""
echo -e "${BLUE}📍 INSTRUCTIONS:${NC}"
echo "1. Copy the ENTIRE key above (including BEGIN/END markers)"
echo "2. Go to: https://github.com/Owwmann/RPP-AUTO-FullStack/settings/secrets/actions"
echo "3. Click 'New repository secret'"
echo "4. Name: ${GREEN}IONOS_SSH_KEY${NC}"
echo "5. Value: Paste the key"
echo "6. Click 'Add secret'"
echo ""
echo -e "${GREEN}🎉 Then just: git push origin main${NC}"
echo -e "${GREEN}✨ Auto-deployment will happen!${NC}"
echo ""

# Save for easy access
cat ~/.ssh/$KEY_NAME > /tmp/github_secret.txt
echo -e "${BLUE}💾 Key saved to: /tmp/github_secret.txt${NC}"
