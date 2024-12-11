package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 100
			PUID: 1000
			TZ:   "America/Los_Angeles"
		}
		image: {
			repository: "lscr.io/linuxserver/jellyfin"
			tag:        "10.10.3"
		}
	}
	defaultPodOptions: hostNetwork: true
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
	persistence: {
		config: {
			accessMode: "ReadWriteOnce"
			enabled:    true
			globalMounts: [{path: "/config"}]
			size: "1Gi"
			type: "persistentVolumeClaim"
		}
		media: {
			enabled: true
			globalMounts: [{path: "/media"}]
			hostPath:     "/media"
			hostPathType: "Directory"
			type:         "hostPath"
		}
		transcode: {
			enabled: true
			type:    "emptyDir"
		}
	}
	service: main: {
		annotations: "metallb.universe.tf/loadBalancerIPs": "192.168.2.7"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 8096
		type: "LoadBalancer"
	}
}
