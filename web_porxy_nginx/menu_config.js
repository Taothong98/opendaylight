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
            // url: "/proxy/8181/hawtio/",
            // url: "http://127.0.0.1/8181/hawtio/auth/login.html",
            url: "https://www.google.com",


            // url: "http://localhost:8181/hawtio/",
            // url: "http://localhost:8181/hawtio/auth/login.html",

            // url: "http://localhost:8181/rests/data/ietf-yang-library:modules-state",
             
            // url: "http://host.docker.internal:8181/hawtio", 
            active: false
        },
        {
            // Jupyter อยู่ Port 8888
            name: "Jupyter Lab",
            url: "/proxy/8888/lab",
            // url: "http://localhost:8888",

            active: false
        },
        {
            // (อนาคต) Web App ใหม่ อยู่ Port 9000
            name: "Simulated Web",
            // url: "http://localhost:8080",    
            url: "https://reg.rbru.ac.th/registrar2/login.asp", 
            active: false
        }
    ]
};