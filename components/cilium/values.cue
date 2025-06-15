package holos

#Values: {
	rollOutCiliumPods:     true
	priorityClassName:     "system-cluster-critical"
	autoDirectNodeRoutes:  true
	routingMode:           "native"
	ipv4NativeRoutingCIDR: "10.244.0.0/16"
	bandwidthManager: {
		bbr:     true
		enabled: true
	}
	endpointRoutes: enabled: true
	bpf: {
		datapathMode:    "netkit"
		masquerade:      true
		preallocateMaps: true
		events: trace: enabled: false
	}
	// bpfClockProbe: true
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
	envoy: {
		rollOutPods: true
		prometheus: serviceMonitor: enabled: true
	}
	k8sNetworkPolicy: {
		enabled: false
	}
	gatewayAPI: {
		enabled:               true
		enableAlpn:            true
		xffNumTrustedHops:     1
		externalTrafficPolicy: "Local"
	}
	hubble: enabled: false
	localRedirectPolicy: true
	loadBalancer: {
		acceleration: "best-effort"
		algorithm:    "maglev"
		mode:         "dsr"
	}
	operator: {
		enabled:           true
		rollOutPods:       true
		replicas:          1
		priorityClassName: "system-cluster-critical"
		dashboards: enabled: true
	}
	enableCriticalPriorityClass: false
	prometheus: {
		enabled: true
		serviceMonitor: enabled:        true
		serviceMonitor: trustCRDsExist: true
	}

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
