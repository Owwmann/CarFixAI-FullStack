# 🚀 Automated Deployment Setup

Complete automation for RPP AUTO deployment to IONOS using GitHub Actions.

## ⚡ Quick Start (ONE COMMAND!)

### **Option 1: Super Quick Setup** (Recommended)

Just copy and paste this into your Termux:

```bash
curl -sSL https://raw.githubusercontent.com/Owwmann/RPP-AUTO-FullStack/main/scripts/quick-setup.sh | bash
```

**What it does:**
1. ✅ Generates SSH key automatically
2. ✅ Adds it to your IONOS server
3. ✅ Tests the connection
4. ✅ Displays the GitHub secret for you to copy

**You just need to:**
- Enter your IONOS password once
- Copy the displayed key to GitHub

That's it! 🎉

---

### **Option 2: Manual Download & Run**

If you prefer to review the script first:

```bash
# Clone the repo
git clone https://github.com/Owwmann/RPP-AUTO-FullStack.git
cd RPP-AUTO-FullStack

# Make script executable
chmod +x scripts/quick-setup.sh

# Run it
./scripts/quick-setup.sh
```

---

## 📝 What You'll Get

After running the script, you'll see:

```
====================================
✅ SETUP COMPLETE!
====================================

🔑 GITHUB SECRET (Copy everything below):

---BEGIN KEY---
-----BEGIN OPENSSH PRIVATE KEY-----
[YOUR KEY HERE]
-----END OPENSSH PRIVATE KEY-----
---END KEY---

📍 INSTRUCTIONS:
1. Copy the ENTIRE key above
2. Go to: https://github.com/Owwmann/RPP-AUTO-FullStack/settings/secrets/actions
3. Click 'New repository secret'
4. Name: IONOS_SSH_KEY
5. Value: Paste the key
6. Click 'Add secret'

🎉 Then just: git push origin main
✨ Auto-deployment will happen!
```

---

## 🔐 Adding the Secret to GitHub

### Step-by-Step:

1. **Copy the private key** from the script output (everything between `---BEGIN KEY---` and `---END KEY---`)

2. **Go to GitHub Secrets page**:
   - Direct link: https://github.com/Owwmann/RPP-AUTO-FullStack/settings/secrets/actions
   - Or navigate: Repository → Settings → Secrets and variables → Actions

3. **Create new secret**:
   - Click **"New repository secret"**
   - **Name**: `IONOS_SSH_KEY`
   - **Value**: Paste the entire private key
   - Click **"Add secret"**

4. **Verify**:
   - You should see `IONOS_SSH_KEY` in your secrets list
   - It will show "Updated X seconds ago"

---

## 🎯 Testing Automated Deployment

Once the secret is added:

```bash
# Make any change
echo "# Test deployment" >> README.md

# Commit and push
git add .
git commit -m "Test automated deployment"
git push origin main
```

**Watch it deploy automatically!**
- Go to: https://github.com/Owwmann/RPP-AUTO-FullStack/actions
- You'll see the deployment running in real-time
- Takes about 2-3 minutes

---

## 🔍 Monitoring & Logs

### View Deployment Logs:
- **GitHub Actions**: https://github.com/Owwmann/RPP-AUTO-FullStack/actions
- **Server Logs**: `ssh u102176229@access5019379793.webspacehost.com "tail -f /tmp/rpp_auto.log"`

### Check API Health:
```bash
curl http://s1080048923.onlinehome.us/api/health
```

### View Running Processes:
```bash
ssh u102176229@access5019379793.webspacehost.com "ps aux | grep uvicorn"
```

---

## 🐛 Troubleshooting

### Script fails to connect to IONOS:
```bash
# Test your password manually first:
ssh u102176229@access5019379793.webspacehost.com
```

### Key not working:
```bash
# Test the generated key manually:
ssh -i ~/.ssh/ionos_deploy u102176229@access5019379793.webspacehost.com
```

### GitHub Actions fails:
1. Check if secret is added correctly
2. View detailed logs in Actions tab
3. Verify key format (must include BEGIN/END lines)

### Deployment succeeds but app not responding:
```bash
# SSH into server and check logs
ssh u102176229@access5019379793.webspacehost.com
cd /kunden/homepages/39/d4299589649/htdocs/RPP_AUTO/rpp-auto-backend
tail -100 /tmp/rpp_auto.log
```

---

## 📄 Files Created

The automation creates these files:

| File | Purpose |
|------|----------|
| `~/.ssh/ionos_deploy` | Private SSH key (keep secret!) |
| `~/.ssh/ionos_deploy.pub` | Public key (added to server) |
| `/tmp/github_secret.txt` | Copy of private key for easy access |

---

## 🔒 Security Notes

- ✅ Private key is only stored locally and in GitHub Secrets
- ✅ GitHub encrypts all secrets
- ✅ Key is passwordless for automation (industry standard for CI/CD)
- ✅ Only has access to your IONOS server
- ⚠️  Never commit private keys to Git!

---

## ❓ FAQ

**Q: Is it safe to use a passwordless SSH key?**  
A: Yes! This is standard practice for CI/CD. The key is encrypted by GitHub and only accessible during deployments.

**Q: Can I use the same key for multiple repos?**  
A: Yes, but it's better to generate separate keys for each repo for security.

**Q: What if I lose the private key?**  
A: Just run the setup script again to generate a new key pair.

**Q: How do I revoke access?**  
A: Remove the public key from `~/.ssh/authorized_keys` on the IONOS server and delete the GitHub secret.

---

## 🔗 Quick Links

- 🔑 [GitHub Secrets](https://github.com/Owwmann/RPP-AUTO-FullStack/settings/secrets/actions)
- 🚀 [GitHub Actions](https://github.com/Owwmann/RPP-AUTO-FullStack/actions)
- 🧪 [API Health Check](http://s1080048923.onlinehome.us/api/health)
- 📚 [Deployment Workflow](.github/workflows/deploy.yml)

---

## 🎉 Success Checklist

- [ ] Run the quick setup script
- [ ] Enter IONOS password when prompted
- [ ] Copy the displayed private key
- [ ] Add `IONOS_SSH_KEY` secret to GitHub
- [ ] Push code to trigger deployment
- [ ] Watch it deploy in Actions tab
- [ ] Test API endpoint
- [ ] Celebrate! 🎊

---

## 💬 Need Help?

If you encounter any issues:

1. Check the troubleshooting section above
2. Review GitHub Actions logs
3. Test SSH connection manually
4. Check server logs at `/tmp/rpp_auto.log`

---

**Made with ❤️ by RPP AUTO Team**
