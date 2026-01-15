#!/bin/bash
# 🚀 AUTOMATED SSH KEY SETUP FOR GITHUB ACTIONS
# This script automates the entire SSH key setup process

set -e

echo "====================================="
echo "🚀 RPP AUTO - Automated SSH Setup"
echo "====================================="
echo ""

# Configuration
SSH_KEY_PATH="$HOME/.ssh/ionos_github_actions"
SSH_USER="u102176229"
SSH_HOST="access5019379793.webspacehost.com"
REPO_OWNER="Owwmann"
REPO_NAME="RPP-AUTO-FullStack"

# Step 1: Generate SSH Key
echo "🔑 Step 1/4: Generating SSH key pair..."
if [ -f "$SSH_KEY_PATH" ]; then
    echo "⚠️  SSH key already exists at $SSH_KEY_PATH"
    read -p "Do you want to regenerate it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Using existing key..."
    else
        rm -f "$SSH_KEY_PATH" "${SSH_KEY_PATH}.pub"
        ssh-keygen -t ed25519 -C "github-actions-$REPO_NAME" -f "$SSH_KEY_PATH" -N ""
        echo "✅ New SSH key generated!"
    fi
else
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    ssh-keygen -t ed25519 -C "github-actions-$REPO_NAME" -f "$SSH_KEY_PATH" -N ""
    echo "✅ SSH key generated at $SSH_KEY_PATH"
fi

echo ""

# Step 2: Add public key to IONOS server
echo "🔐 Step 2/4: Adding public key to IONOS server..."
echo "You'll be prompted for your IONOS SSH password"
echo ""

PUBLIC_KEY=$(cat "${SSH_KEY_PATH}.pub")

ssh -o StrictHostKeyChecking=no "$SSH_USER@$SSH_HOST" << EOF
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Add the key if it doesn't exist
if ! grep -q "$PUBLIC_KEY" ~/.ssh/authorized_keys 2>/dev/null; then
    echo "$PUBLIC_KEY" >> ~/.ssh/authorized_keys
    echo "✅ Public key added to authorized_keys"
else
    echo "ℹ️  Public key already exists in authorized_keys"
fi
EOF

if [ $? -eq 0 ]; then
    echo "✅ Successfully configured IONOS server!"
else
    echo "❌ Failed to configure IONOS server"
    exit 1
fi

echo ""

# Step 3: Test SSH connection
echo "🧪 Step 3/4: Testing SSH connection (passwordless)..."
if ssh -i "$SSH_KEY_PATH" -o BatchMode=yes -o ConnectTimeout=10 "$SSH_USER@$SSH_HOST" "echo 'Connection successful!'" 2>/dev/null; then
    echo "✅ SSH connection works without password!"
else
    echo "❌ SSH test failed. Please check your setup."
    exit 1
fi

echo ""

# Step 4: Prepare GitHub secret
echo "📦 Step 4/4: Preparing GitHub secret..."
PRIVATE_KEY=$(cat "$SSH_KEY_PATH")

echo ""
echo "====================================="
echo "✅ SETUP COMPLETE!"
echo "====================================="
echo ""
echo "🔑 Your private key is ready for GitHub!"
echo ""
echo "---------------------------------------"
echo "COPY THIS PRIVATE KEY TO GITHUB SECRETS:"
echo "---------------------------------------"
echo ""
echo "$PRIVATE_KEY"
echo ""
echo "---------------------------------------"
echo ""
echo "📌 NEXT STEPS:"
echo "1. Go to: https://github.com/$REPO_OWNER/$REPO_NAME/settings/secrets/actions"
echo "2. Click 'New repository secret'"
echo "3. Name: IONOS_SSH_KEY"
echo "4. Value: Copy the ENTIRE key above (including BEGIN and END lines)"
echo "5. Click 'Add secret'"
echo ""
echo "🎉 After adding the secret, push any code to trigger automatic deployment!"
echo ""

# Save to file for easy copying
echo "$PRIVATE_KEY" > /tmp/ionos_github_key.txt
echo "💾 Private key also saved to: /tmp/ionos_github_key.txt"
echo ""
