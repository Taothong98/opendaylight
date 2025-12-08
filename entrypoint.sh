#!/bin/bash

# 1. Start Open vSwitch (รองรับ WSL2)
echo "=== [Boot] Starting Open vSwitch ==="
/usr/share/openvswitch/scripts/ovs-ctl start --system-id=random || true

# เช็คว่า process ขึ้นไหม ถ้าไม่ขึ้นให้ force start
if ! pgrep -x "ovs-vswitchd" > /dev/null; then
    echo "Warning: ovs-vswitchd not running. Force starting..."
    ovs-vswitchd --pidfile --detach --log-file
fi

# 2. Start Jupyter Lab (Background)
echo "=== [Boot] Starting Jupyter Lab ==="
nohup jupyter lab --allow-root > /var/log/jupyter.log 2>&1 &

# 3. Start OpenDaylight (Main Process)
echo "=== [Boot] Starting OpenDaylight ==="
exec "$@"