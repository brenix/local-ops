package holos

#Values: {
	controllers: main: containers: main: {
		env: [{
			name:  "LANGS"
			value: "en_US"
		}]
		image: {
			repository: "frooodle/s-pdf"
			tag:        "0.39.0"
		}
	}
	ingress: main: {
		className: "internal"
		hosts: [{
			host: "pdf.brenix.com"
			paths: [{
				path: "/"
				service: {
					identifier: "main"
					port:       "http"
				}
			}]
		}]
		tls: [{
			hosts: ["pdf.brenix.com"]
		}]
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.14"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 8080
		type: "LoadBalancer"
	}
}
