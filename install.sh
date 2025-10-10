#!/bin/bash

# Git Aliases Installer
# This script helps you install git aliases to your global git config

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ALIASES_FILE="$SCRIPT_DIR/gitconfig-aliases"
GITCONFIG="$HOME/.gitconfig"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Print colored output
print_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_status() {
    echo -e "${CYAN}→${NC} $1"
}

# Check installation status
check_installation() {
    local installed=false
    local method=""
    
    # Check if included
    if git config --global --get-all include.path 2>/dev/null | grep -q "$ALIASES_FILE"; then
        installed=true
        method="include"
    # Check if aliases exist directly in config
    elif git config --global --get alias.st > /dev/null 2>&1; then
        installed=true
        method="direct"
    fi
    
    echo "$installed|$method"
}

# Backup existing gitconfig
backup_gitconfig() {
    if [ -f "$GITCONFIG" ]; then
        BACKUP_FILE="${GITCONFIG}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$GITCONFIG" "$BACKUP_FILE"
        print_success "Backed up existing config to: $BACKUP_FILE"
    fi
}

# Option 1: Include file (recommended)
install_include() {
    print_info "Installing using [include] directive..."
    
    # Check if already included
    if git config --global --get-all include.path 2>/dev/null | grep -q "$ALIASES_FILE"; then
        print_warning "Aliases file is already included in your config!"
        print_info "No changes needed - you're already using the latest version."
        return
    fi
    
    backup_gitconfig
    
    # Add include directive
    git config --global --add include.path "$ALIASES_FILE"
    print_success "Added include directive to $GITCONFIG"
    print_success "Path: $ALIASES_FILE"
}

# Update aliases (for include method)
update_aliases() {
    local status=$(check_installation)
    local installed=$(echo $status | cut -d'|' -f1)
    local method=$(echo $status | cut -d'|' -f2)
    
    if [ "$installed" = "false" ]; then
        print_error "No installation detected. Please install first."
        return
    fi
    
    if [ "$method" = "include" ]; then
        print_success "Using include method - aliases are automatically up to date!"
        print_info "The aliases are loaded from: $ALIASES_FILE"
        print_info "Any changes to that file are immediately available."
    else
        print_warning "Aliases were installed directly to .gitconfig"
        print_info "To update, you need to reinstall (option 2 in the menu)"
    fi
}

# Reinstall (for direct method)
reinstall_aliases() {
    print_warning "This will reinstall the aliases."
    print_info "A backup will be created before making changes."
    echo -n "Continue? (yes/no): "
    read -r confirm
    
    if [ "$confirm" != "yes" ]; then
        print_info "Cancelled."
        return
    fi
    
    # First try to clean up old installation
    local status=$(check_installation)
    local method=$(echo $status | cut -d'|' -f2)
    
    if [ "$method" = "include" ]; then
        git config --global --unset-all include.path "$ALIASES_FILE" 2>/dev/null || true
    fi
    
    # Now reinstall
    install_append
}

# Option 2: Append aliases
install_append() {
    print_info "Appending aliases to your config..."
    backup_gitconfig
    
    echo "" >> "$GITCONFIG"
    echo "# Git Aliases - Added $(date)" >> "$GITCONFIG"
    cat "$ALIASES_FILE" >> "$GITCONFIG"
    
    print_success "Aliases appended to $GITCONFIG"
}

# Option 3: Copy as primary config
install_copy() {
    print_warning "This will replace your entire .gitconfig file!"
    echo -n "Are you sure? (yes/no): "
    read -r confirm
    
    if [ "$confirm" != "yes" ]; then
        print_info "Cancelled."
        return
    fi
    
    backup_gitconfig
    cp "$ALIASES_FILE" "$GITCONFIG"
    print_success "Copied aliases to $GITCONFIG"
}

# Verify installation
verify_installation() {
    print_info "Verifying installation..."
    
    # Test a few aliases
    if git config --get alias.st > /dev/null 2>&1; then
        print_success "Aliases are loaded correctly!"
        echo ""
        print_info "Try these commands:"
        echo "  git la        - List all aliases"
        echo "  git st        - Short status"
        echo "  git ls        - Compact log"
        echo "  git hist      - Log with graph"
    else
        print_error "Aliases don't seem to be loaded. Please check your config."
    fi
}

# Uninstall option
uninstall() {
    print_info "Uninstalling git aliases..."
    
    # Remove include directive if it exists
    if git config --global --get-all include.path | grep -q "$ALIASES_FILE"; then
        git config --global --unset-all include.path "$ALIASES_FILE" || true
        print_success "Removed include directive"
    fi
    
    print_success "Uninstall complete"
    print_info "Note: If you appended aliases directly, you'll need to remove them manually"
}

# Main menu
show_menu() {
    local status=$(check_installation)
    local installed=$(echo $status | cut -d'|' -f1)
    local method=$(echo $status | cut -d'|' -f2)
    
    echo ""
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║          Git Aliases Installation Script                ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo ""
    
    # Show current status
    if [ "$installed" = "true" ]; then
        print_success "Status: Aliases are already installed"
        if [ "$method" = "include" ]; then
            print_status "Method: Include directive (auto-updates)"
        else
            print_status "Method: Direct installation in .gitconfig"
        fi
        echo ""
    else
        print_info "Status: Not installed"
        echo ""
    fi
    
    # Show appropriate menu based on installation status
    if [ "$installed" = "true" ]; then
        echo "Available options:"
        echo ""
        echo "  1) Check for updates"
        echo "     → Verify your aliases are up to date"
        echo ""
        echo "  2) Reinstall/Change method"
        echo "     → Switch installation method or repair installation"
        echo ""
        echo "  3) Uninstall"
        echo "     → Remove aliases from your config"
        echo ""
        echo "  4) Verify installation"
        echo "     → Test if aliases are working correctly"
        echo ""
        echo "  5) Show alias info"
        echo "     → Display installation details"
        echo ""
        echo "  6) Exit"
        echo ""
    else
        echo "Choose an installation method:"
        echo ""
        echo "  1) Include file (Recommended)"
        echo "     → Keeps aliases in separate file, easy to update"
        echo ""
        echo "  2) Append to .gitconfig"
        echo "     → Adds aliases directly to your config file"
        echo ""
        echo "  3) Copy as primary config"
        echo "     → Replaces your entire .gitconfig (creates backup)"
        echo ""
        echo "  4) Verify git configuration"
        echo "     → Check current git config"
        echo ""
        echo "  5) Exit"
        echo ""
    fi
}

# Show installation info
show_info() {
    local status=$(check_installation)
    local installed=$(echo $status | cut -d'|' -f1)
    local method=$(echo $status | cut -d'|' -f2)
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  Installation Information"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    if [ "$installed" = "true" ]; then
        print_success "Installed: Yes"
        print_info "Method: $method"
        print_info "Aliases file: $ALIASES_FILE"
        print_info "Git config: $GITCONFIG"
        echo ""
        print_info "Total aliases: $(git config --get-regexp '^alias\.' | wc -l)"
    else
        print_warning "Not installed"
    fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Main script
main() {
    # Check if aliases file exists
    if [ ! -f "$ALIASES_FILE" ]; then
        print_error "Aliases file not found: $ALIASES_FILE"
        exit 1
    fi
    
    while true; do
        local status=$(check_installation)
        local installed=$(echo $status | cut -d'|' -f1)
        
        show_menu
        
        if [ "$installed" = "true" ]; then
            # Menu for when already installed
            echo -n "Enter your choice (1-6): "
            read -r choice
            
            case $choice in
                1)
                    update_aliases
                    ;;
                2)
                    echo ""
                    echo "Choose reinstall method:"
                    echo "  1) Include file (Recommended)"
                    echo "  2) Append to .gitconfig"
                    echo "  3) Copy as primary config"
                    echo -n "Choice: "
                    read -r reinstall_choice
                    case $reinstall_choice in
                        1)
                            # Remove old include if exists
                            git config --global --unset-all include.path "$ALIASES_FILE" 2>/dev/null || true
                            install_include
                            verify_installation
                            ;;
                        2)
                            reinstall_aliases
                            verify_installation
                            ;;
                        3)
                            install_copy
                            verify_installation
                            ;;
                        *)
                            print_error "Invalid choice."
                            ;;
                    esac
                    ;;
                3)
                    uninstall
                    ;;
                4)
                    verify_installation
                    ;;
                5)
                    show_info
                    ;;
                6)
                    print_info "Goodbye!"
                    exit 0
                    ;;
                *)
                    print_error "Invalid choice. Please enter 1-6."
                    ;;
            esac
        else
            # Menu for fresh installation
            echo -n "Enter your choice (1-5): "
            read -r choice
            
            case $choice in
                1)
                    install_include
                    verify_installation
                    ;;
                2)
                    install_append
                    verify_installation
                    ;;
                3)
                    install_copy
                    verify_installation
                    ;;
                4)
                    verify_installation
                    ;;
                5)
                    print_info "Goodbye!"
                    exit 0
                    ;;
                *)
                    print_error "Invalid choice. Please enter 1-5."
                    ;;
            esac
        fi
        
        echo ""
        echo -n "Press Enter to continue..."
        read -r
    done
}

main

