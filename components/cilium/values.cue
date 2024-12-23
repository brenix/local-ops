package holos

#Values: {
	rollOutCiliumPods:    true
	priorityClassName:    "system-cluster-critical"
	autoDirectNodeRoutes: false
	bgp: {
		enabled: false
		announce: {
			loadbalancerIP: true
			podCIDR:        false
		}
	}
	bgpControlPlane: {
		enabled: true
	}
	k8sNetworkPolicy: {
		enabled: false
	}
	hubble: {
		enabled: false
	}
	operator: {
		enabled:           true
		rollOutPods:       true
		replicas:          1
		priorityClassName: "system-cluster-critical"
	}
	enableCriticalPriorityClass: false

	// Talos requirements
	ipam: mode: "kubernetes"
	kubeProxyReplacement: true
	securityContext: capabilities: {
		ciliumAgent: [
			"CHOWN",
			"KILL",
			"NET_ADMIN",
			"NET_RAW",
			"IPC_LOCK",
			"SYS_ADMIN",
			"SYS_RESOURCE",
			"DAC_OVERRIDE",
			"FOWNER",
			"SETGID",
			"SETUID",
		]
		cleanCiliumState: [
			"NET_ADMIN",
			"SYS_ADMIN",
			"SYS_RESOURCE",
		]
	}
	cgroup: autoMount: enabled: false
	cgroup: hostRoot: "/sys/fs/cgroup"

	k8sServiceHost: "127.0.0.1" // Kubeprism
	k8sServicePort: "7445"

	l2announcements: enabled: true
	externalIPs: enabled:     true
	devices: "eno+"
}
