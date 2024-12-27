package holos

#Values: {
	defaultPodOptions: securityContext: fsGroup: 65532
	controllers: main: {
		strategy: "RollingUpdate"
		annotations: "reloader.stakater.com/auto": "true"
		containers: main: {
			image: {
				repository: "cgr.dev/chainguard/nginx"
				tag:        "latest"
				pullPolicy: "Always"
			}
			resources: {
				requests: {
					cpu:    "10m"
					memory: "64M"
				}
				limits: memory: "256M"
			}
		}
	}
	service: main: {
		controller: "main"
		type:       "LoadBalancer"
		annotations: "lbipam.cilium.io/ips": "192.168.2.15"
		externalTrafficPolicy: "Local"
		ports: http: {
			port:       80
			targetPort: 8080
		}
	}
	persistence: {
		cache: {
			enabled:       true
			existingClaim: "nix-cache"
			globalMounts: [{path: "/cache"}]
		}
		"public-nix-cache": {
			enabled: true
			type:    "emptyDir"
			globalMounts: [{path: "/public-nix-cache"}]
		}
		config: {
			enabled: true
			name:    "nix-cache-config"
			type:    "configMap"
			globalMounts: [{
				path:    "/etc/nginx/conf.d/nginx.default.conf"
				subPath: "nginx.default.conf"
			}]
		}
	}
	// TODO: clean this up somehow
	configMaps: config: {
		enabled: true
		data: "nginx.default.conf": """
			server {
			\tlisten 8080;
			\tserver_name nix-cache ;
			\tlocation / {
			\t\troot /public-nix-cache;
			\t\texpires max;
			\t\tadd_header Cache-Control $cache_header always;
			\t\t# Ask the upstream server if a file isn't available locally
			\t\terror_page 404 = @fallback;
			\t}
			\tlocation = /nix-cache-info {
			\t\tproxy_pass $upstream_endpoint;
			\t\tproxy_cache cachecache;
			\t\tproxy_cache_valid  200 302  60d;
			\t\texpires max;
			\t\tadd_header Cache-Control $cache_header always;
			\t}
			\tlocation @fallback {
			\t\tproxy_pass $upstream_endpoint;
			\t\tproxy_cache cachecache;
			\t\tproxy_cache_valid  200 302  60d;
			\t\texpires max;
			\t\tadd_header Cache-Control $cache_header always;
			\t}
			\tresolver 1.1.1.1 ipv6=off;
			\tset $upstream_endpoint http://cache.nixos.org;
			}
			proxy_cache_path /cache levels=1:2 keys_zone=cachecache:100m max_size=25g inactive=365d use_temp_path=off;
			map $status $cache_header {
			\t200     "public";
			\t302     "public";
			\tdefault "no-cache";
			}

			"""
	}
}
