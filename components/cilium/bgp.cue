package holos

Component: {
	Name:      string
	Namespace: string

	Resources: CiliumBGPClusterConfig: (Name): {
		metadata: name: "cilium-bgp"
		spec: bgpInstances: [{
			name:     "node"
			localASN: 64513
			peers: [{
				name:        "opnsense"
				peerASN:     64512
				peerAddress: "192.168.1.1"
				peerConfigRef: name: "cilium-peer"
			}]
		}]
	}

	Resources: CiliumBGPPeerConfig: (Name): {
		metadata: name: "cilium-peer"
		spec: {
			authSecretRef: "bgp-auth-secret"
			gracefulRestart: {
				enabled:            true
				restartTimeSeconds: 15
			}
			families: [{
				afi:  "ipv4"
				safi: "unicast"
				advertisements: matchLabels: advertise: "bgp"
			}]
		}
	}

	Resources: CiliumBGPAdvertisement: (Name): {
		metadata: name: "bgp-advertisements"
		metadata: labels: advertise: "bgp"
		spec: advertisements: [{
			advertisementType: "Service"
			service: addresses: ["LoadBalancerIP"]
			selector: matchExpressions: [{key: "somekey", operator: "NotIn", values: ["never-used-value"]}]
			attributes: communities: standard: ["64512"]
		}]
	}

	Resources: CiliumLoadBalancerIPPool: (Name): {
		metadata: name: "default"
		spec: blocks: [{cidr: "192.168.2.0/24"}]
	}
}
