#!/bin/sh

interval=1

# ONLY FOREGROUND COLORS
reset="^d^"

cpu_col="^c#ff5f87^"
mem_col="^c#5fffaf^"
disk_col="^c#5fafff^"
vol_col="^c#af5fff^"
bat_col="^c#ffaf5f^"
time_col="^c#5fffff^"

# ICONS
cpu_icon=""
mem_icon=""
disk_icon="󰋊"
vol_icon=""
bat_icon=""
plug_icon=""
time_icon=""

gap="   "
inner="  "

get_cpu() {
    usage=$(top -b -n 1 | awk -F',' '/CPU:/ {print 100 - $5}' | awk '{printf "%.0f", $1}')
    printf "%s%s%sCPU: %s%%%s" "$cpu_col" "$cpu_icon" "$inner" "$usage" "$reset"
}

get_mem() {
    mem=$(sysctl -n vm.stats.vm.v_page_count)
    free=$(sysctl -n vm.stats.vm.v_free_count)
    used=$((mem - free))
    percent=$((used * 100 / mem))
    printf "%s%s%sMemory: %s%%%s" "$mem_col" "$mem_icon" "$inner" "$percent" "$reset"
}

get_disk() {
    disk=$(df -h / | awk 'NR==2 {print $5}')
    printf "%s%s%sDisk: %s%s" "$disk_col" "$disk_icon" "$inner" "$disk" "$reset"
}

get_vol() {
    raw=$(mixer vol | awk -F: '{print $2}' | awk '{print $1}')

    if echo "$raw" | grep -q '\.'; then
        vol=$(printf "%.0f" "$(echo "$raw * 100" | bc -l)")
    else
        vol=$raw
    fi

    printf "%s%s%sVolume: %s%%%s" "$vol_col" "$vol_icon" "$inner" "$vol" "$reset"
}

get_bat() {
    if sysctl hw.acpi.battery.life >/dev/null 2>&1; then
        bat=$(sysctl -n hw.acpi.battery.life)
        state=$(sysctl -n hw.acpi.acline)

        if [ "$state" -eq 1 ]; then
            printf "%s%s%sBattery: %s%% (Charging)%s" "$bat_col" "$plug_icon" "$inner" "$bat" "$reset"
        else
            printf "%s%s%sBattery: %s%%%s" "$bat_col" "$bat_icon" "$inner" "$bat" "$reset"
        fi
    fi
}

get_time() {
    time=$(date '+%H:%M:%S')
    printf "%s%s%sTime: %s%s" "$time_col" "$time_icon" "$inner" "$time" "$reset"
}

while :; do
    status=" $(get_cpu)$gap$(get_mem)$gap$(get_disk)$gap$(get_vol)$gap$(get_bat)$gap$(get_time) "
    xsetroot -name "$status"
    sleep $interval
done
