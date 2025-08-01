// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f https://raw.githubusercontent.com/cilium/cilium/refs/tags/v1.18.0/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumnodes.yaml

package v2

import "strings"

// CiliumNode represents a node managed by Cilium. It contains a
// specification
// to control various node specific configuration aspects and a
// status section
// to represent the status of the node.
#CiliumNode: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "cilium.io/v2"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "CiliumNode"
	metadata: {
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			string
		}
		namespace?: strings.MaxRunes(63) & strings.MinRunes(1) & {
			string
		}
		labels?: {
			[string]: string
		}
		annotations?: {
			[string]: string
		}
	}

	// Spec defines the desired specification/configuration of the
	// node.
	spec!: #CiliumNodeSpec
}

// Spec defines the desired specification/configuration of the
// node.
#CiliumNodeSpec: {
	// Addresses is the list of all node addresses.
	addresses?: [...{
		// IP is an IP of a node
		ip?: string

		// Type is the type of the node address
		type?: string
	}]

	// AlibabaCloud is the AlibabaCloud IPAM specific configuration.
	"alibaba-cloud"?: {
		// AvailabilityZone is the availability zone to use when
		// allocating
		// ENIs.
		"availability-zone"?: string

		// CIDRBlock is vpc ipv4 CIDR
		"cidr-block"?: string

		// InstanceType is the ECS instance type, e.g. "ecs.g6.2xlarge"
		"instance-type"?: string

		// SecurityGroupTags is the list of tags to use when evaluating
		// which
		// security groups to use for the ENI.
		"security-group-tags"?: {
			[string]: string
		}

		// SecurityGroups is the list of security groups to attach to any
		// ENI
		// that is created and attached to the instance.
		"security-groups"?: [...string]

		// VPCID is the VPC ID to use when allocating ENIs.
		"vpc-id"?: string

		// VSwitchTags is the list of tags to use when evaluating which
		// vSwitch to use for the ENI.
		"vswitch-tags"?: {
			[string]: string
		}

		// VSwitches is the ID of vSwitch available for ENI
		vswitches?: [...string]
	}
	azure?: {
		// InterfaceName is the name of the interface the cilium-operator
		// will use to allocate all the IPs on
		"interface-name"?: string
	}

	// BootID is a unique node identifier generated on boot
	bootid?: string
	encryption?: {
		// Key is the index to the key to use for encryption or 0 if
		// encryption is
		// disabled.
		key?: int
	}

	// ENI is the AWS ENI specific configuration.
	eni?: {
		// AvailabilityZone is the availability zone to use when
		// allocating
		// ENIs.
		"availability-zone"?: string

		// DeleteOnTermination defines that the ENI should be deleted when
		// the
		// associated instance is terminated. If the parameter is not set
		// the
		// default behavior is to delete the ENI on instance termination.
		"delete-on-termination"?: bool

		// DisablePrefixDelegation determines whether ENI prefix
		// delegation should be
		// disabled on this node.
		"disable-prefix-delegation"?: bool

		// ExcludeInterfaceTags is the list of tags to use when excluding
		// ENIs for
		// Cilium IP allocation. Any interface matching this set of tags
		// will not
		// be managed by Cilium.
		"exclude-interface-tags"?: {
			[string]: string
		}

		// FirstInterfaceIndex is the index of the first ENI to use for IP
		// allocation, e.g. if the node has eth0, eth1, eth2 and
		// FirstInterfaceIndex is set to 1, then only eth1 and eth2 will
		// be
		// used for IP allocation, eth0 will be ignored for PodIP
		// allocation.
		"first-interface-index"?: >=0 & int

		// InstanceID is the AWS InstanceId of the node. The InstanceID is
		// used
		// to retrieve AWS metadata for the node.
		//
		// OBSOLETE: This field is obsolete, please use Spec.InstanceID
		"instance-id"?: string

		// InstanceType is the AWS EC2 instance type, e.g. "m5.large"
		"instance-type"?: string

		// MaxAboveWatermark is the maximum number of addresses to
		// allocate
		// beyond the addresses needed to reach the PreAllocate watermark.
		// Going above the watermark can help reduce the number of API
		// calls to
		// allocate IPs, e.g. when a new ENI is allocated, as many
		// secondary
		// IPs as possible are allocated. Limiting the amount can help
		// reduce
		// waste of IPs.
		//
		// OBSOLETE: This field is obsolete, please use
		// Spec.IPAM.MaxAboveWatermark
		"max-above-watermark"?: >=0 & int

		// MinAllocate is the minimum number of IPs that must be allocated
		// when
		// the node is first bootstrapped. It defines the minimum base
		// socket
		// of addresses that must be available. After reaching this
		// watermark,
		// the PreAllocate and MaxAboveWatermark logic takes over to
		// continue
		// allocating IPs.
		//
		// OBSOLETE: This field is obsolete, please use
		// Spec.IPAM.MinAllocate
		"min-allocate"?: >=0 & int

		// NodeSubnetID is the subnet of the primary ENI the instance was
		// brought up
		// with. It is used as a sensible default subnet to create ENIs
		// in.
		"node-subnet-id"?: string

		// PreAllocate defines the number of IP addresses that must be
		// available for allocation in the IPAMspec. It defines the buffer
		// of
		// addresses available immediately without requiring
		// cilium-operator to
		// get involved.
		//
		// OBSOLETE: This field is obsolete, please use
		// Spec.IPAM.PreAllocate
		"pre-allocate"?: >=0 & int

		// SecurityGroupTags is the list of tags to use when evaliating
		// what
		// AWS security groups to use for the ENI.
		"security-group-tags"?: {
			[string]: string
		}

		// SecurityGroups is the list of security groups to attach to any
		// ENI
		// that is created and attached to the instance.
		"security-groups"?: [...string]

		// SubnetIDs is the list of subnet ids to use when evaluating what
		// AWS
		// subnets to use for ENI and IP allocation.
		"subnet-ids"?: [...string]

		// SubnetTags is the list of tags to use when evaluating what AWS
		// subnets to use for ENI and IP allocation.
		"subnet-tags"?: {
			[string]: string
		}

		// UsePrimaryAddress determines whether an ENI's primary address
		// should be available for allocations on the node
		"use-primary-address"?: bool

		// VpcID is the VPC ID to use when allocating ENIs.
		"vpc-id"?: string
	}

	// HealthAddressing is the addressing information for health
	// connectivity
	// checking.
	health?: {
		// IPv4 is the IPv4 address of the IPv4 health endpoint.
		ipv4?: string

		// IPv6 is the IPv6 address of the IPv4 health endpoint.
		ipv6?: string
	}

	// IngressAddressing is the addressing information for Ingress
	// listener.
	ingress?: {
		ipv4?: string
		ipv6?: string
	}

	// InstanceID is the identifier of the node. This is different
	// from the
	// node name which is typically the FQDN of the node. The
	// InstanceID
	// typically refers to the identifier used by the cloud provider
	// or
	// some other means of identification.
	"instance-id"?: string

	// IPAM is the address management specification. This section can
	// be
	// populated by a user or it can be automatically populated by an
	// IPAM
	// operator.
	ipam?: {
		// IPv6Pool is the list of IPv6 addresses available to the node
		// for allocation.
		// When an IPv6 address is used, it will remain on this list but
		// will be added to
		// Status.IPAM.IPv6Used
		"ipv6-pool"?: {
			[string]: {
				// Owner is the owner of the IP. This field is set if the IP has
				// been
				// allocated. It will be set to the pod name or another identifier
				// representing the usage of the IP
				//
				// The owner field is left blank for an entry in Spec.IPAM.Pool
				// and
				// filled out as the IP is used and also added to
				// Status.IPAM.Used.
				owner?: string

				// Resource is set for both available and allocated IPs, it
				// represents
				// what resource the IP is associated with, e.g. in combination
				// with
				// AWS ENI, this will refer to the ID of the ENI
				resource?: string
			}
		}

		// MaxAboveWatermark is the maximum number of addresses to
		// allocate
		// beyond the addresses needed to reach the PreAllocate watermark.
		// Going above the watermark can help reduce the number of API
		// calls to
		// allocate IPs, e.g. when a new ENI is allocated, as many
		// secondary
		// IPs as possible are allocated. Limiting the amount can help
		// reduce
		// waste of IPs.
		"max-above-watermark"?: >=0 & int

		// MaxAllocate is the maximum number of IPs that can be allocated
		// to the
		// node. When the current amount of allocated IPs will approach
		// this value,
		// the considered value for PreAllocate will decrease down to 0 in
		// order to
		// not attempt to allocate more addresses than defined.
		"max-allocate"?: >=0 & int

		// MinAllocate is the minimum number of IPs that must be allocated
		// when
		// the node is first bootstrapped. It defines the minimum base
		// socket
		// of addresses that must be available. After reaching this
		// watermark,
		// the PreAllocate and MaxAboveWatermark logic takes over to
		// continue
		// allocating IPs.
		"min-allocate"?: >=0 & int

		// PodCIDRs is the list of CIDRs available to the node for
		// allocation.
		// When an IP is used, the IP will be added to Status.IPAM.Used
		podCIDRs?: [...string]

		// Pool is the list of IPv4 addresses available to the node for
		// allocation.
		// When an IPv4 address is used, it will remain on this list but
		// will be added to
		// Status.IPAM.Used
		pool?: {
			[string]: {
				// Owner is the owner of the IP. This field is set if the IP has
				// been
				// allocated. It will be set to the pod name or another identifier
				// representing the usage of the IP
				//
				// The owner field is left blank for an entry in Spec.IPAM.Pool
				// and
				// filled out as the IP is used and also added to
				// Status.IPAM.Used.
				owner?: string

				// Resource is set for both available and allocated IPs, it
				// represents
				// what resource the IP is associated with, e.g. in combination
				// with
				// AWS ENI, this will refer to the ID of the ENI
				resource?: string
			}
		}

		// Pools contains the list of assigned IPAM pools for this node.
		pools?: {
			// Allocated contains the list of pooled CIDR assigned to this
			// node. The
			// operator will add new pod CIDRs to this field, whereas the
			// agent will
			// remove CIDRs it has released.
			allocated?: [...{
				// CIDRs contains a list of pod CIDRs currently allocated from
				// this pool
				cidrs?: [...string]

				// Pool is the name of the IPAM pool backing this allocation
				pool: strings.MinRunes(1)
			}]

			// Requested contains a list of IPAM pool requests, i.e. indicates
			// how many
			// addresses this node requests out of each pool listed here. This
			// field
			// is owned and written to by cilium-agent and read by the
			// operator.
			requested?: [...{
				// Needed indicates how many IPs out of the above Pool this node
				// requests
				// from the operator. The operator runs a reconciliation loop to
				// ensure each
				// node always has enough PodCIDRs allocated in each pool to
				// fulfill the
				// requested number of IPs here.
				needed?: {
					// IPv4Addrs contains the number of requested IPv4 addresses out
					// of a given
					// pool
					"ipv4-addrs"?: int

					// IPv6Addrs contains the number of requested IPv6 addresses out
					// of a given
					// pool
					"ipv6-addrs"?: int
				}

				// Pool is the name of the IPAM pool backing this request
				pool: strings.MinRunes(1)
			}]
		}

		// PreAllocate defines the number of IP addresses that must be
		// available for allocation in the IPAMspec. It defines the buffer
		// of
		// addresses available immediately without requiring
		// cilium-operator to
		// get involved.
		"pre-allocate"?: >=0 & int

		// StaticIPTags are used to determine the pool of IPs from which
		// to
		// attribute a static IP to the node. For example in AWS this is
		// used to
		// filter Elastic IP Addresses.
		"static-ip-tags"?: {
			[string]: string
		}
	}

	// NodeIdentity is the Cilium numeric identity allocated for the
	// node, if any.
	nodeidentity?: int
}
