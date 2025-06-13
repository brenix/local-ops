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
				tag:        "1.40.0"
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
	route: main: {
		hostnames: ["{{ .Release.Name }}.brenix.com"]
		parentRefs: [{
			name:        "internal"
			namespace:   "kube-system"
			sectionName: "https"
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
