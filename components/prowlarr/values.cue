package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 1000
			PUID: 1000
			TZ:   "America/Los_Angeles"
		}
		image: {
			repository: "lscr.io/linuxserver/prowlarr"
			tag:        "2.0.5"
		}
	}
	route: main: {
		hostnames: ["{{ .Release.Name }}.brenix.com"]
		parentRefs: [{
			name:        "internal"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	persistence: config: {
		existingClaim: "prowlarr"
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.5"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 9696
		type: "LoadBalancer"
	}
}
