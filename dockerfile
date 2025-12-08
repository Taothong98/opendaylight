FROM opendaylight/odl-ubuntu-image

USER root

# --- ส่วนเตรียมไฟล์ ---
# Copy ไฟล์ Requirements ไปวาง
RUN mkdir -p /home/master
COPY requirements_python.txt /home/master/requirements_python.txt
COPY requirements_java.txt /home/master/requirements_java.txt

# --- ส่วนติดตั้ง (Installation Layer) ---
# 1. Copy และรัน Script ติดตั้ง OVS
COPY install_ovs.sh /usr/local/bin/install_ovs.sh
RUN chmod +x /usr/local/bin/install_ovs.sh && \
    /usr/local/bin/install_ovs.sh

# 2. Copy และรัน Script ติดตั้ง Jupyter
COPY install_jupyter.sh /usr/local/bin/install_jupyter.sh
RUN chmod +x /usr/local/bin/install_jupyter.sh && \
    /usr/local/bin/install_jupyter.sh

# --- ส่วน Runtime ---
# Copy Entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# เปิด Port ที่จำเป็น
# 8181: ODL Web UI
# 8888: Jupyter Lab
# 6633, 6653: OpenFlow Controller Ports
EXPOSE 8181 8888 6633 6653

# กำหนด Entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# คำสั่งรัน ODL (แก้ path ตามที่คุณหาเจอในเครื่องจริง)
CMD ["/home/user/karaf-0.18.1/bin/karaf", "run"]