package holos

#Values: {
	// FIXME: Remove after upgrading to 1.16.1 (https://github.com/rook/rook/issues/15195)
	image: tag: "v1.16.0-4.g6da8ef89d"
	// FIXME: Remove after upgrading to 1.16.1 (https://github.com/rook/rook/issues/15195)
	csi: snapshotter: tag: "v8.2.0"

	resources: limits: null
	csi: {
		enableVolumeGroupSnapshot: false // TODO: enable when v1beta1 CRDs are available
		cephFSKernelMountOptions:  "ms_mode=prefer-crc"
		enableLiveness:            true
	}
	enableDiscoveryDaemon: true
}
