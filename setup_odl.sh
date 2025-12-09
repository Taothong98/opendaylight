#!/bin/bash

# ตั้งค่า Path ให้ถูกต้อง
KARAF_DIR="/home/user/karaf-0.18.1"
SYS_PROP="$KARAF_DIR/etc/system.properties"
CLIENT_BIN="$KARAF_DIR/bin/client"

echo "--- [Setup] Configuring OpenDaylight & Hawtio ---"

# ==========================================
# ส่วนที่ 1: ปลดล็อก Security (ทำก่อน ODL Start)
# ==========================================
if [ -f "$SYS_PROP" ]; then
    echo " >> Unlocking Hawtio Security in system.properties..."
    
    # เช็คก่อนว่าเคยเติมไปรึยัง กันการเขียนซ้ำ
    if ! grep -q "hawtio.xframeOptionsEnabled" "$SYS_PROP"; then
        echo "" >> "$SYS_PROP"
        echo "# --- Custom Config by setup_odl.sh ---" >> "$SYS_PROP"
        # ปิด X-Frame เพื่อให้ใส่ใน iFrame (Nginx) ได้
        echo "hawtio.xframeOptionsEnabled = false" >> "$SYS_PROP"
        # ปิด CSP เพื่อให้โหลด Script ข้าม Domain ได้
        echo "hawtio.contentSecurityPolicyEnabled = false" >> "$SYS_PROP"
        # ปิด Strict Transport (ถ้าไม่ได้ใช้ HTTPS)
        echo "hawtio.http.strictTransportSecurity = false" >> "$SYS_PROP"
        # อนุญาต Error Detail
        echo "jolokia.allowErrorDetails = true" >> "$SYS_PROP"
        # ถ้าจำเป็นต้องปิด Auth (ไม่แนะนำถ้าขึ้น Production)
        # echo "hawtio.authenticationEnabled = false" >> "$SYS_PROP"
    else
        echo " >> Configuration already exists. Skipping."
    fi
else
    echo " !! ERROR: system.properties not found at $SYS_PROP"
fi

# ==========================================
# ส่วนที่ 2: ฟังก์ชันติดตั้ง Feature (ทำทีหลัง)
# ==========================================
install_features_task() {
    # รอจนกว่า Karaf จะตื่นและเปิด Port 8101 (SSH)
    echo " >> Waiting for Karaf to start..."
    until $CLIENT_BIN "system:version" > /dev/null 2>&1; do
        sleep 5
        echo "    ... waiting for Karaf SSH ..."
    done

    echo " >> Karaf is UP! Installing features..."
    # สั่งติดตั้ง Feature
    $CLIENT_BIN "feature:install odl-restconf odl-openflowplugin-flow-services-rest odl-openflowplugin-app-table-miss-enforcer"
    
    echo " >> Feature installation command sent."
}

# สั่งให้ฟังก์ชันนี้ทำงานใน Background (&) โดยไม่บล็อก Process หลัก
install_features_task &

echo "--- [Setup] Configuration Prepared (Background tasks started) ---"