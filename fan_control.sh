#!/bin/bash

# Legion Fan Control Script
# Usage: ./fan_control.sh [enable|disable|status]

case "$1" in
    "enable")
        echo "🔥 Enabling high-performance fan mode..."
        echo 1 | sudo tee /sys/module/legion_laptop/drivers/platform:legion/PNP0C09:00/fan_fullspeed > /dev/null
        echo 1 | sudo tee /sys/module/legion_laptop/drivers/platform:legion/PNP0C09:00/fan_maxspeed > /dev/null
        echo 2 | sudo tee /sys/module/legion_laptop/drivers/platform:legion/PNP0C09:00/powermode > /dev/null
        sudo /home/xuananh/Downloads/LenovoLegionLinux/.venv/bin/legion_cli maximumfanspeed-enable
        echo "✅ High-performance fan mode enabled!"
        echo "📊 Current fan speeds:"
        sensors legion_hwmon-isa-0000
        ;;
    "disable")
        echo "🌡️ Disabling high-performance fan mode..."
        echo 0 | sudo tee /sys/module/legion_laptop/drivers/platform:legion/PNP0C09:00/fan_fullspeed > /dev/null
        echo 0 | sudo tee /sys/module/legion_laptop/drivers/platform:legion/PNP0C09:00/fan_maxspeed > /dev/null
        echo 3 | sudo tee /sys/module/legion_laptop/drivers/platform:legion/PNP0C09:00/powermode > /dev/null
        sudo /home/xuananh/Downloads/LenovoLegionLinux/.venv/bin/legion_cli maximumfanspeed-disable
        echo "✅ Automatic fan mode restored!"
        echo "📊 Current fan speeds:"
        sensors legion_hwmon-isa-0000
        ;;
    "status")
        echo "📊 Current Legion Fan Status:"
        echo "================================"
        sensors legion_hwmon-isa-0000
        echo ""
        echo "🎛️ Current Settings:"
        echo "Fan Full Speed: $(cat /sys/module/legion_laptop/drivers/platform:legion/PNP0C09:00/fan_fullspeed)"
        echo "Fan Max Speed:  $(cat /sys/module/legion_laptop/drivers/platform:legion/PNP0C09:00/fan_maxspeed)"
        echo "Power Mode:     $(cat /sys/module/legion_laptop/drivers/platform:legion/PNP0C09:00/powermode)"
        ;;
    *)
        echo "Legion Fan Control Script"
        echo "========================"
        echo "Usage: $0 [enable|disable|status]"
        echo ""
        echo "Commands:"
        echo "  enable  - Enable high-performance fan mode (~2900 RPM)"
        echo "  disable - Return to automatic fan control (~2300 RPM)"
        echo "  status  - Show current fan speeds and settings"
        echo ""
        echo "Note: Requires sudo privileges"
        ;;
esac