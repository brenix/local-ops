package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			LOG_LEVEL: "info"
			TZ:        "America/Los_Angeles"
		}
		image: {
			repository: "docker.io/fallenbagel/jellyseerr"
			tag:        "2.1.0"
		}
	}
	ingress: main: {
		annotations: "external-dns.alpha.kubernetes.io/target": "external.brenix.com"
		className: "external"
		hosts: [{
			host: "{{.Release.Name }}.brenix.com"
			paths: [{
				path: "/"
				service: {
					identifier: "main"
					port:       "http"
				}
			}]
		}]
		tls: [{
			hosts: ["{{.Release.Name }}.brenix.com"]
		}]
	}
	persistence: config: {
		accessMode: "ReadWriteOnce"
		enabled:    true
		globalMounts: [{path: "/app/config"}]
		size: "1Gi"
		type: "persistentVolumeClaim"
	}
	service: main: {
		annotations: "metallb.universe.tf/loadBalancerIPs": "192.168.2.8"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 5055
		type: "LoadBalancer"
	}
}
