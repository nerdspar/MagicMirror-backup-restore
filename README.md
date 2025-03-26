# MagicMirror-backup-restore

Scripts for backing up and restoring your MagicMirror configuration and installed modules.

This version supports:

- Saving your full `modules` directory (not just Git-cloned modules)
- Storing your `config.js` and `custom.css`
- Maintaining a list of installed modules and their GitHub source URLs (if available)
- Automatically pushing backups to a **private GitHub repository**
- Restoring a complete working setup using versioned git tags

---

## 🔄 Backup

To run a backup, use:

```bash
bash -c "$(curl -sL https://raw.githubusercontent.com/nerdspar/MagicMirror-backup-restore/main/mm_backup.sh)"
```

### ✅ Recommended with push to GitHub:

```bash
bash -c "$(curl -sL https://raw.githubusercontent.com/nerdspar/MagicMirror-backup-restore/main/mm_backup.sh)" -p -r username/reponame -u username -e your@email.com
```

### Backup Help

Run this to see help:

```bash
./mm_backup.sh -h
```

Supported flags:

| Flag | Description |
|------|-------------|
| `-s` | MagicMirror directory (default: `$HOME/MagicMirror`) |
| `-b` | Backup output directory (default: `$HOME/MM_backup`) |
| `-m` | Optional message to include with this backup/tag |
| `-p` | Auto-push to GitHub (requires `-r`, `-u`, and `-e`) |
| `-r` | GitHub repo name, e.g. `username/reponame` |
| `-u` | GitHub username |
| `-e` | GitHub email address |

---

## ♻️ Restore

To restore a backup (and all modules), use:

```bash
bash -c "$(curl -sL https://raw.githubusercontent.com/nerdspar/MagicMirror-backup-restore/main/mm_restore.sh)"
```

### Restore Help

Run this to see help:

```bash
./mm_restore.sh -h
```

Supported flags:

| Flag | Description |
|------|-------------|
| `-s` | MagicMirror directory (default: `$HOME/MagicMirror`) |
| `-b` | Backup directory (default: `$HOME/MM_backup`) |
| `-f` | Fetch & restore from GitHub using latest or specific tag number |
| `-r` | GitHub repository name (e.g. `username/repo.git`) |
| `-u` | GitHub username |

---

## 🏷️ Listing Tags

Each backup is tagged using an incrementing number (`1`, `2`, etc.). To list the tags:

```bash
bash -c "$(curl -sL https://raw.githubusercontent.com/nerdspar/MagicMirror-backup-restore/main/list_tags.sh)"
```

Or view manually from the GitHub repo.

---

## 🔑 GitHub Personal Access Token (PAT)

To push your backup to a private repo:

1. Go to GitHub > Settings > Developer Settings
2. Choose **"Personal Access Tokens"** → **Tokens (classic)**
3. Generate a new token with **repo** (read/write) permissions
4. Copy and save your token! GitHub will not show it again
5. Use this token in place of a password when prompted by `git`

---

## 🕓 Cron Example

To schedule a daily backup at 3:30 AM:

```cron
30 3 * * * bash -c "$(curl -sL https://raw.githubusercontent.com/nerdspar/MagicMirror-backup-restore/main/mm_backup.sh)" -p -r nerdspar/MagicMirror-Backup -u nerdspar -e your@email.com
```

---

Happy backing up! ✨
