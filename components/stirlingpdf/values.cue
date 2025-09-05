package holos

#Values: {
	controllers: main: containers: main: {
		env: [{
			name:  "LANGS"
			value: "en_US"
		}]
		image: {
			repository: "frooodle/s-pdf"
			tag:        "1.3.1"
		}
	}
	route: main: {
		hostnames: ["pdf.brenix.com"]
		parentRefs: [{
			name:        "internal"
			namespace:   "kube-system"
			sectionName: "https"
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
