package holos

import (
	bgpadv "metallb.io/bgpadvertisement/v1beta1"
	bgppeer "metallb.io/bgppeer/v1beta2"
	css "external-secrets.io/clustersecretstore/v1beta1"
	ed "externaldns.k8s.io/dnsendpoint/v1alpha1"
	ipaddresspool "metallb.io/ipaddresspool/v1beta1"
	ks "kustomize.toolkit.fluxcd.io/kustomization/v1"
	ocirepository "source.toolkit.fluxcd.io/ocirepository/v1beta2"
)

#Resources: {
	BGPAdvertisement?: [_]:   bgpadv.#BGPAdvertisement
	BGPPeer?: [_]:            bgppeer.#BGPPeer
	ClusterSecretStore?: [_]: css.#ClusterSecretStore
	DNSEndpoint?: [_]:        ed.#DNSEndpoint
	IPAddressPool?: [_]:      ipaddresspool.#IPAddressPool
	Kustomization?: [_]:      ks.#Kustomization
	OCIRepository?: [_]:      ocirepository.#OCIRepository
}
