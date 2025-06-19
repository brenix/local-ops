package holos

import (
	corev1 "k8s.io/api/core/v1"
	bgpadv "metallb.io/bgpadvertisement/v1beta1"
	bgppeer "metallb.io/bgppeer/v1beta2"
	css "external-secrets.io/clustersecretstore/v1"
	ps "external-secrets.io/pushsecret/v1alpha1"
	ed "externaldns.k8s.io/dnsendpoint/v1alpha1"
	ipaddresspool "metallb.io/ipaddresspool/v1beta1"
	gwcv1 "gateway.networking.k8s.io/gatewayclass/v1"
	ks "kustomize.toolkit.fluxcd.io/kustomization/v1"
	ocirepository "source.toolkit.fluxcd.io/ocirepository/v1"
	ciliuml2announcementpolicy "cilium.io/ciliuml2announcementpolicy/v2alpha1"
	ciliumbgpadvertisement "cilium.io/ciliumbgpadvertisement/v2"
	ciliumbgpclusterconfig "cilium.io/ciliumbgpclusterconfig/v2"
	ciliumbgppeerconfig "cilium.io/ciliumbgppeerconfig/v2"
	ciliumloadbalancerippool "cilium.io/ciliumloadbalancerippool/v2"
	// backend "gateway.envoyproxy.io/backend/v1alpha1"
	backendtrafficpolicy "gateway.envoyproxy.io/backendtrafficpolicy/v1alpha1"
	clienttrafficpolicy "gateway.envoyproxy.io/clienttrafficpolicy/v1alpha1"
	// envoyextensionpolicy "gateway.envoyproxy.io/envoyextensionpolicy/v1alpha1"
	// envoypatchpolicy "gateway.envoyproxy.io/envoypatchpolicy/v1alpha1"
	envoyproxy "gateway.envoyproxy.io/envoyproxy/v1alpha1"
	// httproutefilter "gateway.envoyproxy.io/httproutefilter/v1alpha1"
	// securitypolicy "gateway.envoyproxy.io/securitypolicy/v1alpha1"

)

#Resources: {
	BGPAdvertisement?: [_]:      bgpadv.#BGPAdvertisement
	BGPPeer?: [_]:               bgppeer.#BGPPeer
	ClusterSecretStore?: [_]:    css.#ClusterSecretStore
	DNSEndpoint?: [_]:           ed.#DNSEndpoint
	IPAddressPool?: [_]:         ipaddresspool.#IPAddressPool
	Kustomization?: [_]:         ks.#Kustomization
	OCIRepository?: [_]:         ocirepository.#OCIRepository
	PersistentVolumeClaim?: [_]: corev1.#PersistentVolumeClaim
	GatewayClass?: [_]:          gwcv1.#GatewayClass
	BackendTrafficPolicy?: [_]:  backendtrafficpolicy.#BackendTrafficPolicy
	ClientTrafficPolicy?: [_]:   clienttrafficpolicy.#ClientTrafficPolicy
	EnvoyProxy?: [_]:            envoyproxy.#EnvoyProxy
	PushSecret?: [_]:            ps.#PushSecret

	CiliumBGPAdvertisement?: [_]:     ciliumbgpadvertisement.#CiliumBGPAdvertisement
	CiliumBGPClusterConfig?: [_]:     ciliumbgpclusterconfig.#CiliumBGPClusterConfig
	CiliumBGPPeerConfig?: [_]:        ciliumbgppeerconfig.#CiliumBGPPeerConfig
	CiliumL2AnnouncementPolicy?: [_]: ciliuml2announcementpolicy.#CiliumL2AnnouncementPolicy
	CiliumLoadBalancerIPPool?: [_]:   ciliumloadbalancerippool.#CiliumLoadBalancerIPPool
}
