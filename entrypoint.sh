#!/bin/bash

echo "=== [Step 1] Starting Open vSwitch ==="

# สั่ง start แบบไม่สน error (เพราะ WSL2 จะ error เรื่อง kernel module เสมอ)
/usr/share/openvswitch/scripts/ovs-ctl start --system-id=random || true

# ตรวจสอบว่า process หลัก (ovs-vswitchd) ขึ้นหรือไม่ ถ้าไม่ขึ้นให้บังคับรัน
if ! pgrep -x "ovs-vswitchd" > /dev/null; then
    echo "Warning: ovs-vswitchd not running. Force starting it..."
    ovs-vswitchd --pidfile --detach --log-file
fi

# โชว์สถานะเพื่อความชัวร์
/usr/share/openvswitch/scripts/ovs-ctl status

echo "=== [Step 2] Starting OpenDaylight ==="
# ส่งต่อไปยังคำสั่งใน CMD
exec "$@"