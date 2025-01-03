// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f https://raw.githubusercontent.com/kubernetes-sigs/external-dns/refs/heads/master/charts/external-dns/crds/dnsendpoint.yaml

package v1alpha1

import "strings"

#DNSEndpoint: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "externaldns.k8s.io/v1alpha1"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "DNSEndpoint"
	metadata!: {
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			string
		}
		namespace!: strings.MaxRunes(63) & strings.MinRunes(1) & {
			string
		}
		labels?: {
			[string]: string
		}
		annotations?: {
			[string]: string
		}
	}

	// DNSEndpointSpec defines the desired state of DNSEndpoint
	spec!: #DNSEndpointSpec
}
#DNSEndpointSpec: {
	endpoints?: [...{
		// The hostname of the DNS record
		dnsName?: string

		// Labels stores labels defined for the Endpoint
		labels?: {
			[string]: string
		}

		// ProviderSpecific stores provider specific config
		providerSpecific?: [...{
			name?:  string
			value?: string
		}]

		// TTL for the record
		recordTTL?: int

		// RecordType type of record, e.g. CNAME, A, AAAA, SRV, TXT etc
		recordType?: string

		// Identifier to distinguish multiple records with the same name
		// and type (e.g. Route53 records with routing policies other
		// than 'simple')
		setIdentifier?: string

		// The targets the DNS record points to
		targets?: [...string]
	}]
}
