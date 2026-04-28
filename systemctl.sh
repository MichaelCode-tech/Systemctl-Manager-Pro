#!/bin/bash

################################################################################
# SYSTEMD SERVICE MANAGER TOOL
# Author: sheild_tech
# Comprehensive utility for managing systemd services across Linux
################################################################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

SERVICE_DIR="/etc/systemd/system"

print_header() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}        ${BLUE}SYSTEMD SERVICE MANAGER${NC}                       ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}              ${MAGENTA}by sheild_tech${NC}                         ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }

check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_error "This requires root access"
        print_info "Use: sudo $0"
        exit 1
    fi
}

pause_menu() {
    echo ""
    read -p "Press ENTER to continue..."
}

view_all_services() {
    print_header
    echo -e "${MAGENTA}All System Services:${NC}\n"
    systemctl list-units --type=service --all --no-pager
    pause_menu
}

view_active_services() {
    print_header
    echo -e "${MAGENTA}Active Services:${NC}\n"
    systemctl list-units --type=service --state=running --no-pager
    pause_menu
}

view_enabled_services() {
    print_header
    echo -e "${MAGENTA}Enabled Services:${NC}\n"
    systemctl list-unit-files --type=service --state=enabled --no-pager
    pause_menu
}

view_disabled_services() {
    print_header
    echo -e "${MAGENTA}Disabled Services:${NC}\n"
    systemctl list-unit-files --type=service --state=disabled --no-pager
    pause_menu
}

view_failed_services() {
    print_header
    echo -e "${MAGENTA}Failed Services:${NC}\n"
    systemctl list-units --type=service --state=failed --no-pager
    pause_menu
}

view_service_status() {
    print_header
    read -p "Enter service name: " service_name
    echo ""
    systemctl status "$service_name"
    pause_menu
}

start_service() {
    print_header
    read -p "Enter service name to start: " service_name
    
    if systemctl start "$service_name" 2>/dev/null; then
        print_success "Service '$service_name' started"
    else
        print_error "Failed to start service '$service_name'"
    fi
    pause_menu
}

stop_service() {
    print_header
    read -p "Enter service name to stop: " service_name
    
    if systemctl stop "$service_name" 2>/dev/null; then
        print_success "Service '$service_name' stopped"
    else
        print_error "Failed to stop service '$service_name'"
    fi
    pause_menu
}

restart_service() {
    print_header
    read -p "Enter service name to restart: " service_name
    
    if systemctl restart "$service_name" 2>/dev/null; then
        print_success "Service '$service_name' restarted"
    else
        print_error "Failed to restart service '$service_name'"
    fi
    pause_menu
}

reload_service() {
    print_header
    read -p "Enter service name to reload: " service_name
    
    if systemctl reload "$service_name" 2>/dev/null; then
        print_success "Service '$service_name' reloaded"
    else
        print_error "Failed to reload service '$service_name'"
    fi
    pause_menu
}

enable_service() {
    print_header
    read -p "Enter service name to enable: " service_name
    
    if systemctl enable "$service_name" 2>/dev/null; then
        print_success "Service '$service_name' enabled on boot"
    else
        print_error "Failed to enable service '$service_name'"
    fi
    pause_menu
}

disable_service() {
    print_header
    read -p "Enter service name to disable: " service_name
    
    if systemctl disable "$service_name" 2>/dev/null; then
        print_success "Service '$service_name' disabled on boot"
    else
        print_error "Failed to disable service '$service_name'"
    fi
    pause_menu
}

create_service() {
    print_header
    echo -e "${MAGENTA}Create New Service${NC}\n"
    
    read -p "Service name (no .service): " service_name
    read -p "Description: " description
    read -p "Command to execute: " exec_command
    read -p "User [root]: " service_user
    service_user=${service_user:-root}
    read -p "Restart policy [on-failure]: " restart_policy
    restart_policy=${restart_policy:-on-failure}
    
    SERVICE_FILE="$SERVICE_DIR/${service_name}.service"
    
    cat > "$SERVICE_FILE" << 'EOF'
[Unit]
Description=DESC_PLACEHOLDER
After=network.target

[Service]
Type=simple
User=USER_PLACEHOLDER
ExecStart=EXEC_PLACEHOLDER
Restart=RESTART_PLACEHOLDER
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

    sed -i "s|DESC_PLACEHOLDER|$description|g" "$SERVICE_FILE"
    sed -i "s|USER_PLACEHOLDER|$service_user|g" "$SERVICE_FILE"
    sed -i "s|EXEC_PLACEHOLDER|$exec_command|g" "$SERVICE_FILE"
    sed -i "s|RESTART_PLACEHOLDER|$restart_policy|g" "$SERVICE_FILE"

    chmod 644 "$SERVICE_FILE"
    systemctl daemon-reload
    print_success "Service created: $SERVICE_FILE"
    echo ""
    cat "$SERVICE_FILE"
    pause_menu
}

edit_service() {
    print_header
    read -p "Enter service name to edit: " service_name
    
    SERVICE_FILE="$SERVICE_DIR/${service_name}.service"
    
    if [[ ! -f "$SERVICE_FILE" ]]; then
        print_error "Service file not found"
        pause_menu
        return
    fi
    
    nano "$SERVICE_FILE"
    systemctl daemon-reload
    print_success "Service reloaded"
    pause_menu
}

delete_service() {
    print_header
    read -p "Enter service name to delete: " service_name
    
    SERVICE_FILE="$SERVICE_DIR/${service_name}.service"
    
    if [[ ! -f "$SERVICE_FILE" ]]; then
        print_error "Service file not found"
        pause_menu
        return
    fi
    
    if systemctl is-active --quiet "$service_name"; then
        systemctl stop "$service_name"
    fi
    
    read -p "Delete '$service_name'? (y/n): " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        systemctl disable "$service_name" 2>/dev/null
        rm "$SERVICE_FILE"
        systemctl daemon-reload
        print_success "Service deleted"
    fi
    pause_menu
}

view_service_logs() {
    print_header
    read -p "Enter service name: " service_name
    read -p "Number of lines [50]: " lines
    lines=${lines:-50}
    
    echo ""
    journalctl -u "$service_name" -n "$lines" --no-pager
    pause_menu
}

follow_logs() {
    print_header
    read -p "Enter service name: " service_name
    echo -e "\n${MAGENTA}Following logs (Ctrl+C to exit)${NC}\n"
    journalctl -u "$service_name" -f
}

analyze_service() {
    print_header
    read -p "Enter service name: " service_name
    echo ""
    
    echo -e "${BLUE}Status:${NC}"
    systemctl is-active "$service_name" &>/dev/null && \
        print_success "RUNNING" || print_error "STOPPED"
    
    echo -e "\n${BLUE}Enabled on Boot:${NC}"
    systemctl is-enabled "$service_name" &>/dev/null && \
        print_success "YES" || print_error "NO"
    
    echo -e "\n${BLUE}Unit File:${NC}"
    systemctl show -p FragmentPath "$service_name"
    
    echo -e "\n${BLUE}Recent Errors:${NC}"
    journalctl -u "$service_name" -p err -n 3 --no-pager
    
    pause_menu
}

enable_multiple() {
    print_header
    read -p "Services to enable (space-separated): " -a services
    
    for svc in "${services[@]}"; do
        if systemctl enable "$svc" 2>/dev/null; then
            print_success "Enabled: $svc"
        else
            print_error "Failed: $svc"
        fi
    done
    pause_menu
}

disable_multiple() {
    print_header
    read -p "Services to disable (space-separated): " -a services
    
    for svc in "${services[@]}"; do
        if systemctl disable "$svc" 2>/dev/null; then
            print_success "Disabled: $svc"
        else
            print_error "Failed: $svc"
        fi
    done
    pause_menu
}

restart_multiple() {
    print_header
    read -p "Services to restart (space-separated): " -a services
    
    for svc in "${services[@]}"; do
        if systemctl restart "$svc" 2>/dev/null; then
            print_success "Restarted: $svc"
        else
            print_error "Failed: $svc"
        fi
    done
    pause_menu
}

system_info() {
    print_header
    echo -e "${MAGENTA}System Information${NC}\n"
    
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "OS: $PRETTY_NAME"
    fi
    
    echo "Systemd: $(systemctl --version | head -1)"
    echo "Total Services: $(systemctl list-units --type=service --all --no-pager | wc -l)"
    echo "Running: $(systemctl list-units --type=service --state=running --no-pager | wc -l)"
    echo "Failed: $(systemctl list-units --type=service --state=failed --no-pager | wc -l)"
    
    pause_menu
}

main_menu() {
    while true; do
        print_header
        echo -e "${YELLOW}MAIN MENU${NC}\n"
        echo "  VIEW SERVICES"
        echo "  1.  All Services"
        echo "  2.  Active Services"
        echo "  3.  Enabled Services"
        echo "  4.  Disabled Services"
        echo "  5.  Failed Services"
        echo "  6.  Service Status"
        echo ""
        echo "  CONTROL SERVICES"
        echo "  7.  Start Service"
        echo "  8.  Stop Service"
        echo "  9.  Restart Service"
        echo "  10. Reload Service"
        echo ""
        echo "  MANAGE SERVICES"
        echo "  11. Enable Service"
        echo "  12. Disable Service"
        echo "  13. Create Service"
        echo "  14. Edit Service"
        echo "  15. Delete Service"
        echo ""
        echo "  LOGS & ANALYSIS"
        echo "  16. View Logs"
        echo "  17. Follow Logs"
        echo "  18. Analyze Service"
        echo ""
        echo "  BATCH OPERATIONS"
        echo "  19. Enable Multiple"
        echo "  20. Disable Multiple"
        echo "  21. Restart Multiple"
        echo ""
        echo "  SYSTEM"
        echo "  22. System Info"
        echo "  23. Reload Daemon"
        echo "  24. Exit"
        echo ""
        read -p "Select [1-24]: " choice
        
        case $choice in
            1) view_all_services ;;
            2) view_active_services ;;
            3) view_enabled_services ;;
            4) view_disabled_services ;;
            5) view_failed_services ;;
            6) view_service_status ;;
            7) check_root; start_service ;;
            8) check_root; stop_service ;;
            9) check_root; restart_service ;;
            10) check_root; reload_service ;;
            11) check_root; enable_service ;;
            12) check_root; disable_service ;;
            13) check_root; create_service ;;
            14) check_root; edit_service ;;
            15) check_root; delete_service ;;
            16) view_service_logs ;;
            17) follow_logs ;;
            18) analyze_service ;;
            19) check_root; enable_multiple ;;
            20) check_root; disable_multiple ;;
            21) check_root; restart_multiple ;;
            22) system_info ;;
            23) check_root; systemctl daemon-reload && print_success "Daemon reloaded"; pause_menu ;;
            24) print_info "Goodbye!"; exit 0 ;;
            *) print_error "Invalid option"; pause_menu ;;
        esac
    done
}

if ! command -v systemctl &> /dev/null; then
    echo "Error: systemd not installed"
    exit 1
fi

main_menu

