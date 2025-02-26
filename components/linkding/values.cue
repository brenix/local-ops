package holos

#Values: {
	controllers: main: {
		annotations: "reloader.stakater.com/auto": "true"
		containers: main: {
			envFrom: [{
				secretRef: name: "linkding"
			}]
			image: {
				repository: "sissbruecker/linkding"
				tag:        "1.38.1"
			}
			resources: {
				limits: memory: "512M"
				requests: {
					cpu:    "12m"
					memory: "64M"
				}
			}
		}
		strategy: "Recreate"
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
	persistence: data: {
		enabled:       true
		existingClaim: "linkding-data"
		globalMounts: [{path: "/etc/linkding/data"}]
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.9"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 9090
		type: "LoadBalancer"
	}
}
