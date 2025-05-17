package holos

#Values: {
	controllers: main: {
		replicas: 1
		strategy: "Recreate"
		annotations: "reloader.stakater.com/auto": "true"
		containers: main: {
			image: {
				repository: "ghcr.io/anatol/pacoloco"
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
		annotations: "lbipam.cilium.io/ips": "192.168.2.16"
		externalTrafficPolicy: "Local"
		ports: http: {
			port:       80
			targetPort: 9129
		}
	}
	persistence: {
		cache: {
			enabled:       true
			existingClaim: "pacoloco"
			globalMounts: [{path: "/var/cache/pacoloco"}]
		}
		config: {
			enabled: true
			name:    "pacoloco"
			type:    "configMap"
			globalMounts: [{
				path:    "/etc/pacoloco.yaml"
				subPath: "pacoloco.yaml"
			}]
		}
	}
	configMaps: config: {
		enabled: true
		data: "pacoloco.yaml": """
			port: 9129
			cache_dir: /var/cache/pacoloco
			purge_files_after: 360000
			download_timeout: 3600
			repos:
			  archlinux:
			    urls:
			      # - https://archlinux.cachyos.org/repo/$repo/os/$arch
			      - https://arch.hu.fo/archlinux
			      - https://arch.jsc.mx
			      - https://mirror.osbeck.com/archlinux
			      - https://mirrors.lahansons.com/archlinux
			      - https://mirror.theash.xyz/arch
			      - http://cdnmirror.com/archlinux
			      - http://arch.hu.fo/archlinux
			      - https://irltoolkit.mm.fcix.net/archlinux
			      - https://cdnmirror.com/archlinux
			      - https://us-mnz.soulharsh007.dev/archlinux
			      - http://mirrors.ocf.berkeley.edu/archlinux
			  chaotic:
			    urls:
			      - https://geo-mirror.chaotic.cx
			      - https://us-ut-mirror.chaotic.cx
			      - https://us-tx-mirror.chaotic.cx
			      - https://us-mi-mirror.chaotic.cx
			      - https://cdn-mirror.chaotic.cx
			  cachyos:
			    urls:
			      - https://cdn-1.cachyos.org
			      - https://cdn77.cachyos.org/repo
			      - https://mirror.scholarshub.world/repo
			      - https://us.cachyos.org/repo
			      - https://mirror.cachyos.org/repo
			      - https://aur.cachyos.org/repo
			      - https://cdn.cachyos.org/repo
			      - https://mirror.fast0ne.com/repo
			      - https://cachy-mirror.wtako.net/repo
			      - https://at.cachyos.org/repo
			      - https://de-nue.soulharsh007.dev/cachyos/repo
			      - https://no.mirror.cx/cachyos/repo
			      - https://mirror.lesviallon.fr/cachy/repo
			      - https://mirrors.ustc.edu.cn/cachyos/repo
			      - https://mirror.nju.edu.cn/cachyos/repo
			  cachyos-v3:
			    urls:
			      - https://cdn-1.cachyos.org
			      - https://cdn77.cachyos.org/repo
			      - https://mirror.scholarshub.world/repo
			      - https://us.cachyos.org/repo
			      - https://mirror.cachyos.org/repo
			      - https://aur.cachyos.org/repo
			      - https://cdn.cachyos.org/repo
			      - https://mirror.fast0ne.com/repo
			      - https://cachy-mirror.wtako.net/repo
			      - https://at.cachyos.org/repo
			      - https://de-nue.soulharsh007.dev/cachyos/repo
			      - https://no.mirror.cx/cachyos/repo
			      - https://mirror.lesviallon.fr/cachy/repo
			      - https://mirrors.ustc.edu.cn/cachyos/repo
			      - https://mirror.nju.edu.cn/cachyos/repo
			  cachyos-v4:
			    urls:
			      - https://cdn-1.cachyos.org
			      - https://cdn77.cachyos.org/repo
			      - https://mirror.scholarshub.world/repo
			      - https://us.cachyos.org/repo
			      - https://mirror.cachyos.org/repo
			      - https://aur.cachyos.org/repo
			      - https://cdn.cachyos.org/repo
			      - https://mirror.fast0ne.com/repo
			      - https://cachy-mirror.wtako.net/repo
			      - https://at.cachyos.org/repo
			      - https://de-nue.soulharsh007.dev/cachyos/repo
			      - https://no.mirror.cx/cachyos/repo
			      - https://mirror.lesviallon.fr/cachy/repo
			      - https://mirrors.ustc.edu.cn/cachyos/repo
			      - https://mirror.nju.edu.cn/cachyos/repo
			"""
	}
}
