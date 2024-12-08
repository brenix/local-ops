package holos

Component: Resources: {
	BGPAdvertisement: default: {
		metadata: name:      "default"
		metadata: namespace: "kube-system"
		spec: {}
	}

	BGPPeer: opnsense: {
		metadata: name:      "opnsense"
		metadata: namespace: "kube-system"
		spec: {
			myASN:       64513
			peerASN:     64512
			peerAddress: "192.168.1.1"
		}
	}

	IPAddressPool: default: {
		metadata: name:      "default"
		metadata: namespace: "kube-system"
		spec: {
			addresses: ["192.168.2.0-192.168.2.255"]
			autoAssign:    true
			avoidBuggyIPs: false
		}
	}
}
