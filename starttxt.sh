docker exec -it odl_controller /bin/bash



/home/user/karaf-0.18.1/bin/client
ssh -p 8101 karaf@localhost

feature:install odl-restconf odl-openflowplugin-flow-services-rest odl-openflowplugin-app-table-miss-enforcer

# odl-restconf: เปิดประตูให้คนภายนอก (เช่น Postman, Python, Browser) เข้ามาสั่งงานได้ (ผ่าน Port 8181)
# odl-openflowplugin-flow-services-rest: เปิดระบบ OpenFlow ให้ ODL สามารถไปสั่ง Switch/Router ได้
# odl-openflowplugin-app-table-miss-enforcer: กฎพื้นฐานที่บอก Switch ว่า "ถ้ามีข้อมูลวิ่งมาแล้วไม่รู้จะไปไหน ให้ส่งมาถาม Controller นะ"

feature:list -i | grep openflow
feature:list -i | grep odl-restconf
feature:list -i | grep odl-openflowplugin-flow-services-rest
feature:list -i | grep odl-openflowplugin-app-table-miss-enforcer
