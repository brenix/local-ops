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
			tag:        "1.37.0"
		}
	}
	ingress: main: {
		className: "internal"
		hosts: [{
			host: "{{ .Release.Name }}.brenix.com"
			paths: [{
				path: "/"
				service: {
					identifier: "main"
					port:       "http"
				}
			}]
		}]
		tls: [{
			hosts: ["{{ .Release.Name }}.brenix.com"]
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
