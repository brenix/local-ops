package holos

import (
	corev1 "k8s.io/api/core/v1"
	bgpadv "metallb.io/bgpadvertisement/v1beta1"
	bgppeer "metallb.io/bgppeer/v1beta2"
	css "external-secrets.io/clustersecretstore/v1"
	ed "externaldns.k8s.io/dnsendpoint/v1alpha1"
	ipaddresspool "metallb.io/ipaddresspool/v1beta1"
	ks "kustomize.toolkit.fluxcd.io/kustomization/v1"
	ocirepository "source.toolkit.fluxcd.io/ocirepository/v1beta2"
	ciliumbgpadvertisement "cilium.io/ciliumbgpadvertisement/v2alpha1"
	ciliumbgpclusterconfig "cilium.io/ciliumbgpclusterconfig/v2alpha1"
	ciliumbgppeerconfig "cilium.io/ciliumbgppeerconfig/v2alpha1"
	ciliumloadbalancerippool "cilium.io/ciliumloadbalancerippool/v2alpha1"
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

	CiliumBGPAdvertisement?: [_]:   ciliumbgpadvertisement.#CiliumBGPAdvertisement
	CiliumBGPClusterConfig?: [_]:   ciliumbgpclusterconfig.#CiliumBGPClusterConfig
	CiliumBGPPeerConfig?: [_]:      ciliumbgppeerconfig.#CiliumBGPPeerConfig
	CiliumLoadBalancerIPPool?: [_]: ciliumloadbalancerippool.#CiliumLoadBalancerIPPool
}
