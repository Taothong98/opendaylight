FROM opendaylight/odl-ubuntu-image

USER root

# ติดตั้ง OVS และ procps (เพื่อให้ใช้คำสั่ง pgrep ใน script ได้)
RUN apt-get update && \
    apt-get install -y openvswitch-switch net-tools iproute2 procps && \
    rm -rf /var/lib/apt/lists/*

# สร้างโฟลเดอร์ runtime ของ OVS
RUN mkdir -p /var/run/openvswitch

# Copy script เข้าไป
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# กำหนด Entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# --- ใช้ Path ที่คุณหาเจอ (เปลี่ยนจาก client เป็น karaf) ---
CMD ["/home/user/karaf-0.18.1/bin/karaf", "run"]