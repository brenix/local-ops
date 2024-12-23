package holos

#Values: {
	args: [
		"--v=1",
		"--cert-dir=/tmp",
		"--kubelet-insecure-tls",
		"--requestheader-client-ca-file=/var/run/ssl/auth-proxy-ca/requestheader-client-ca-file",
	]
	extraVolumes: [{
		name: "auth-proxy-ca-cert"
		configMap: name: "extension-apiserver-authentication"
	}]
	extraVolumeMounts: [{
		mountPath: "/var/run/ssl/auth-proxy-ca"
		name:      "auth-proxy-ca-cert"
		readOnly:  true
	}]
}
