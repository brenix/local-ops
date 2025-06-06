// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni mod vendor crd -f https://raw.githubusercontent.com/external-secrets/external-secrets/refs/tags/v0.16.1/deploy/crds/bundle.yaml

package v1alpha1

import (
	"strings"
	"time"
)

#GeneratorState: {
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
	kind: "GeneratorState"
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
	spec!: #GeneratorStateSpec
}
#GeneratorStateSpec: {
	// GarbageCollectionDeadline is the time after which the generator
	// state
	// will be deleted.
	// It is set by the controller which creates the generator state
	// and
	// can be set configured by the user.
	// If the garbage collection deadline is not set the generator
	// state will not be deleted.
	garbageCollectionDeadline?: time.Time

	// Resource is the generator manifest that produced the state.
	// It is a snapshot of the generator manifest at the time the
	// state was produced.
	// This manifest will be used to delete the resource. Any
	// configuration that is referenced
	// in the manifest should be available at the time of garbage
	// collection. If that is not the case deletion will
	// be blocked by a finalizer.
	resource!: _

	// State is the state that was produced by the generator
	// implementation.
	state!: _
}
