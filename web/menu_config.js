const appConfig = {
    title: "My Network Controller",
    menus: [
        {
            name: "Home (Login)",
            url: "home.html", 
            active: true
        },
        {
            // Hawtio อยู่ Port 8181
            name: "Hawtio (ODL)",
            // url: "/proxy/8181/hawtio/",  // <--- ใส่เลข port ตรงนี้
            url: "http://opendaylight:8181/hawtio/auth/login",  // <--- ใส่เลข port ตรงนี้

            active: false
        },
        {
            // Jupyter อยู่ Port 8888
            name: "Jupyter Lab",
            // url: "/proxy/8888/lab?", // <--- ใส่เลข port ตรงนี้ (Jupyter Lab มักใช้ /lab)
            url: "http://opendaylight:8888", // <--- ใส่เลข port ตรงนี้ (Jupyter Lab มักใช้ /lab)

            active: false
        },
        {
            // (อนาคต) Web App ใหม่ อยู่ Port 9000
            name: "Simulated Web",
            url: "http://localhost:8077",    // <--- ใส่เลข port ตรงนี้ จบเลย!
            active: false
        }
    ]
};