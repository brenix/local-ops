package holos

#Values: {
	controllers: fstrim: {
		type: "cronjob"
		cronjob: {
			schedule:              "0 0 * * 0"
			parallelism:           3 // Set to total number of nodes
			successfulJobsHistory: 1
			failedJobsHistory:     1
		}
		containers: app: {
			image: {
				repository: "ghcr.io/onedr0p/kubanetics"
				tag:        "2024.12.4@sha256:4941a46bd7c05ce1de1f0f2e98137db44cf116312b33d9c7d0e3619679250bd4"
			}
			env: SCRIPT_NAME: "fstrim.sh"
			resources: {
				requests: cpu:  "25m"
				limits: memory: "128Mi"
			}
			securityContext: privileged: true
		}
	}
	defaultPodOptions: {
		hostNetwork: true
		hostPID:     true
		topologySpreadConstraints: [{
			maxSkew:           1
			topologyKey:       "kubernetes.io/hostname"
			whenUnsatisfiable: "DoNotSchedule"
			labelSelector: matchLabels: "app.kubernetes.io/name": "fstrim"
		}]
	}
	persistence: {
		procfs: {
			type:         "hostPath"
			hostPath:     "/proc"
			hostPathType: "Directory"
			globalMounts: [{
				path:     "/host/proc"
				readOnly: true
			}]
		}
		netfs: {
			type:         "hostPath"
			hostPath:     "/sys"
			hostPathType: "Directory"
			globalMounts: [{
				path:     "/host/net"
				readOnly: true
			}]
		}
	}
}
