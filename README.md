# Git Configuration & Aliases

A comprehensive collection of Git aliases and shortcuts to boost your productivity.

## 📦 Installation

### Option 1: Copy Aliases to Your Global Git Config

```bash
# Backup your current config (optional)
cp ~/.gitconfig ~/.gitconfig.backup

# Append aliases to your global git config
cat gitconfig-aliases >> ~/.gitconfig
```

### Option 2: Include This Config File (Recommended)

Add this line to your `~/.gitconfig`:

```ini
[include]
  path = /path/to/this/repo/gitconfig-aliases
```

### Option 3: Use as Your Primary Config

```bash
# Backup your current config (optional)
cp ~/.gitconfig ~/.gitconfig.backup

# Copy this config as your main config
cp gitconfig-aliases ~/.gitconfig
```

### Verification

To verify the aliases are loaded:

```bash
git la  # List all aliases
```

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

## 🔍 Tips

1. **List all available aliases**: `git la` or `git alias`
2. **Check what an alias does**: `git config alias.<alias-name>`
3. **Force push safely**: Always use `git pushf` (force-with-lease) instead of `git push --force`
4. **Before using dangerous commands**: Make sure you know what they do!

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
