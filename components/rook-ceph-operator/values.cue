package holos

#Values: {
	resources: limits: null
	csi: {
		enableVolumeGroupSnapshot: false // TODO: enable when v1beta1 CRDs are available
		cephFSKernelMountOptions:  "ms_mode=prefer-crc"
		enableLiveness:            true
		enableCephfsDriver:        false
	}
	enableDiscoveryDaemon: true
}
