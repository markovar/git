# Git Configuration & Aliases

A comprehensive collection of Git aliases and shortcuts to boost your productivity.

## 🚀 Quick Start

```bash
# Clone or download this repository
cd /path/to/this/repo

# Make the installer executable
chmod +x install.sh

# Run the smart installer
./install.sh

# Start using your new aliases!
git st              # Short status
git ls              # Beautiful log
git hist            # Graph history
```

The installer automatically detects existing installations and offers appropriate options for updates, reinstalls, or method changes.

## 📦 Installation

### Quick Install (Recommended)

Run the interactive installation script:

```bash
# Make the script executable (first time only)
chmod +x install.sh

# Run the installer
./install.sh
```

#### Smart Installation

The script automatically detects if aliases are already installed and adapts accordingly:

**First Time Installation:**
- **Include file** (recommended) - Keeps aliases modular and auto-updates
- **Append to config** - Adds aliases directly to your `.gitconfig`
- **Copy as primary** - Replaces your entire `.gitconfig` (with backup)
- **Verify** - Check current git configuration

**Already Installed:**
- **Check for updates** - Verify your aliases are current
- **Reinstall/Change method** - Switch installation methods or repair
- **Uninstall** - Clean removal of aliases
- **Verify installation** - Test if aliases work correctly
- **Show alias info** - Display installation details and statistics

#### Features:
- ✓ Automatic installation detection
- ✓ Shows current installation status and method
- ✓ Timestamped backups before any changes
- ✓ Safe reinstallation and method switching
- ✓ Color-coded output for easy reading
- ✓ Duplicate detection to prevent conflicts

### Manual Installation

#### Option 1: Copy Aliases to Your Global Git Config

```bash
# Backup your current config (optional)
cp ~/.gitconfig ~/.gitconfig.backup

# Append aliases to your global git config
cat aliases >> ~/.gitconfig
```

#### Option 2: Include This Config File

Add this line to your `~/.gitconfig`:

```ini
[include]
  path = /path/to/this/repo/aliases
```

#### Option 3: Use as Your Primary Config

```bash
# Backup your current config (optional)
cp ~/.gitconfig ~/.gitconfig.backup

# Copy this config as your main config
cp aliases ~/.gitconfig
```

### Verification

To verify the aliases are loaded:

```bash
git la  # List all aliases
git st  # Test short status
```

You can also run `./install.sh` again anytime to:
- Check your installation status
- Update or reinstall aliases
- Switch between installation methods
- View detailed installation information

## 📚 Alias Categories

### Basic Shortcuts
- `git st` - Short status
- `git co <branch>` - Checkout branch
- `git br` - List branches
- `git bra` - List all branches (including remotes)
- `git ci` - Commit
- `git current` - Show current branch name

### Commit Operations
- `git cm "message"` - Commit with message
- `git cma "message"` - Commit all changes with message
- `git ca` - Amend last commit
- `git amend` - Amend last commit without editing message
- `git author "Name <email>"` - Change author of last commit

### Branch Management
- `git clean` - Delete local branches except main/master/develop
- `git cleanup` - Delete merged branches
- `git rename <new-name>` - Rename current branch locally and remotely

### Log & History
- `git ls` - Compact log with relative dates
- `git ll` - Detailed log with numstat
- `git hist` - Log with graph
- `git recent` - Show most recent commit
- `git notin <branch>` - Show commits not in another branch

### Diff Operations
- `git d` - Word diff
- `git dc` - Diff of staged changes
- `git dlc` - Diff of last commit

### Stash Operations
- `git sl` - List stashes
- `git sa` - Apply stash
- `git ss` - Save stash

### Remote Operations
- `git up` - Pull with rebase and autostash
- `git pushf` - Force push with lease (safer than --force)
- `git remdel <branch>` - Delete remote branch
- `git miedo <file>` - Amend, commit, and force push with lease

### Rebase Operations
- `git rb <branch>` - Fetch and rebase onto branch
- `git redev` - Rebase onto origin/develop
- `git remas` - Rebase onto origin/master
- `git irb` - Interactive rebase last 3 commits
- `git squash <branch>` - Interactive rebase onto branch

### Merge Operations
- `git mergeinto <branch>` - Merge current branch into another
- `git mergenoff` - No fast-forward merge
- `git ours <file>` - Resolve conflict using our changes
- `git theirs <file>` - Resolve conflict using their changes

### Tag Operations
- `git lt` - Show last tag
- `git lasttag` - Show last tag

### Search & Utility
- `git gr <pattern>` - Case-insensitive grep
- `git f <pattern>` - Find files by name
- `git alias` - Show all aliases
- `git la` - List all aliases

## ⚠️ Dangerous Commands

These aliases can modify or delete data. Use with caution:

- `git rh` - Hard reset (DESTRUCTIVE)
- `git rh1` - Hard reset to previous commit (DESTRUCTIVE)
- `git rh2` - Hard reset to two commits ago (DESTRUCTIVE)
- `git undo` - Undo last change using reflog (DESTRUCTIVE)
- `git pushf` - Force push with lease
- `git miedo` - Amend and force push
- `git localdel` - Delete ALL local branches except current
- `git clean` - Delete all local branches except main/master/develop

## 💡 Usage Examples

### Quick commit and push
```bash
git cma "fix: resolve bug in authentication"
git pushf
```

### Update branch from develop
```bash
git redev
```

### Clean up merged branches
```bash
git cleanup
```

### Interactive rebase for cleaning commits
```bash
git irb  # Rebase last 3 commits
git squash develop  # Squash commits before merging to develop
```

### Resolve merge conflicts
```bash
git ours conflicted-file.js
git theirs another-file.js
```

### Find commits not in another branch
```bash
git notin main
```

## 🔧 Managing Your Installation

The `install.sh` script is designed to be run multiple times safely:

### First Installation
- Presents clean installation options
- Creates automatic backups
- Verifies installation success

### Subsequent Runs
- Detects your current installation method
- Shows installation status (include vs. direct)
- Offers to check for updates
- Allows method switching (e.g., from append to include)
- Provides detailed installation information

### Switching Methods
You can safely switch from one installation method to another:
```bash
./install.sh
# Choose option 2 (Reinstall/Change method)
# Select your preferred new method
```

The script automatically cleans up the old installation before applying the new one.

## 🔍 Tips

1. **List all available aliases**: `git la` or `git alias`
2. **Check what an alias does**: `git config alias.<alias-name>`
3. **Force push safely**: Always use `git pushf` (force-with-lease) instead of `git push --force`
4. **Before using dangerous commands**: Make sure you know what they do!
5. **Keep aliases updated**: If using include method, aliases auto-update. For direct installation, run `./install.sh` to reinstall
6. **Check installation status**: Run `./install.sh` and choose "Show alias info" option

## 📝 Notes

- Many aliases use `--force-with-lease` instead of `--force` for safer force pushes
- Branch cleanup commands protect main/master/develop branches
- File operations (last, newmd) are configured for Visual Studio Code

## 🤝 Contributing

Feel free to add more aliases or improve existing ones. Make sure to:
1. Add comments explaining what the alias does
2. Place it in the appropriate category
3. Test it before committing

## 📄 License

Free to use and modify as needed.
