// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni mod vendor crd -f https://raw.githubusercontent.com/external-secrets/external-secrets/refs/tags/v0.16.1/deploy/crds/bundle.yaml

package v1alpha1

import "strings"

// QuayAccessToken generates Quay oauth token for pulling/pushing
// images
#QuayAccessToken: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "generators.external-secrets.io/v1alpha1"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "QuayAccessToken"
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
	spec!: #QuayAccessTokenSpec
}
#QuayAccessTokenSpec: {
	// Name of the robot account you are federating with
	robotAccount!: string

	// Name of the service account you are federating with
	serviceAccountRef!: {
		// Audience specifies the `aud` claim for the service account
		// token
		// If the service account uses a well-known annotation for e.g.
		// IRSA or GCP Workload Identity
		// then this audiences will be appended to the list
		audiences?: [...string]

		// The name of the ServiceAccount resource being referred to.
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
		}

		// Namespace of the resource being referred to.
		// Ignored if referent is not cluster-scoped, otherwise defaults
		// to the namespace of the referent.
		namespace?: strings.MaxRunes(63) & strings.MinRunes(1) & {
			=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
		}
	}

	// URL configures the Quay instance URL. Defaults to quay.io.
	url?: string
}
