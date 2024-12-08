package holos

#Values: {
	alertmanager: enabled: false
	cleanPrometheusOperatorObjectNames: true
	coreDns: enabled:               false
	crds: enabled:                  true
	defaultRules: create:           false
	grafana: enabled:               false
	kubeApiServer: enabled:         false
	kubeControllerManager: enabled: false
	kubeEtcd: enabled:              false
	kubeProxy: enabled:             false
	kubeScheduler: enabled:         false
	kubeStateMetrics: enabled:      false
	kubelet: enabled:               false
	prometheus: {
		ingress: {
			enabled: true
			hosts: ["{{ .Release.Name }}.brenix.com"]
			ingressClassName: "internal"
			tls: [{
				hosts: ["{{ .Release.Name }}.brenix.com"]
			}]
		}
		prometheusSpec: {
			additionalScrapeConfigs: [{
				job_name:        "opnsense"
				scrape_interval: "10s"
				static_configs: [{
					targets: ["192.168.1.1:9273"]
				}]
			}]
			enableAdminAPI:                          true
			retention:                               "90d"
			ruleSelectorNilUsesHelmValues:           false
			serviceMonitorSelectorNilUsesHelmValues: false
			storageSpec: volumeClaimTemplate: spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "10Gi"
			}
		}
	}
	"prometheus-node-exporter": {
		extraArgs: [
			"--collector.filesystem.mount-points-exclude=^/(dev|proc|sys|run|var/lib/docker/.+|var/lib/kubelet/.+)($|/)",
			"--collector.filesystem.fs-types-exclude=^(autofs|binfmt_misc|bpf|cgroup2?|configfs|debugfs|devpts|devtmpfs|fusectl|hugetlbfs|iso9660|mqueue|nsfs|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|selinuxfs|squashfs|sysfs|tracefs)$",
			"--collector.netdev.device-exclude=^veth.+$",
		]
		podLabels: jobLabel: "node"
	}
}
