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
				tag:        "1.36.0"
			}
			resources: {
				limits: memory: "512M"
				requests: {
					cpu:    "12m"
					memory: "64M"
				}
			}
		}
		strategy: "RollingUpdate"
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
		accessMode: "ReadWriteOnce"
		enabled:    true
		globalMounts: [{path: "/etc/linkding/data"}]
		retain: true
		size:   "1Gi"
		type:   "persistentVolumeClaim"
	}
	service: main: {
		annotations: "metallb.universe.tf/loadBalancerIPs": "192.168.2.9"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 9090
		type: "LoadBalancer"
	}
}
