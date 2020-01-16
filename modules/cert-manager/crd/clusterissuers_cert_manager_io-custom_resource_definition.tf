resource "k8s_apiextensions_k8s_io_v1beta1_custom_resource_definition" "clusterissuers_cert_manager_io" {
  metadata {
    name = "clusterissuers.cert-manager.io"
  }
  spec {

    additional_printer_columns {
      json_path = <<-EOF
        .status.conditions[?(@.type=="Ready")].status
        EOF
      name      = "Ready"
      type      = "string"
    }
    additional_printer_columns {
      json_path = <<-EOF
        .status.conditions[?(@.type=="Ready")].message
        EOF
      name      = "Status"
      priority  = 1
      type      = "string"
    }
    additional_printer_columns {
      json_path   = ".metadata.creationTimestamp"
      description = "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
      name        = "Age"
      type        = "date"
    }
    group = "cert-manager.io"
    names {
      kind      = "ClusterIssuer"
      list_kind = "ClusterIssuerList"
      plural    = "clusterissuers"
      singular  = "clusterissuer"
    }
    preserve_unknown_fields = false
    scope                   = "Cluster"
    subresources {
      status = {
        "" = "" //hack since TF does not allow empty values
      }
    }
    validation {
      open_apiv3_schema = <<-JSON
        {
          "properties": {
            "apiVersion": {
              "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
              "type": "string"
            },
            "kind": {
              "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
              "type": "string"
            },
            "metadata": {
              "type": "object"
            },
            "spec": {
              "description": "IssuerSpec is the specification of an Issuer. This includes any configuration required for the issuer.",
              "properties": {
                "acme": {
                  "description": "ACMEIssuer contains the specification for an ACME issuer",
                  "properties": {
                    "email": {
                      "description": "Email is the email for this account",
                      "type": "string"
                    },
                    "privateKeySecretRef": {
                      "description": "PrivateKey is the name of a secret containing the private key for this user account.",
                      "properties": {
                        "key": {
                          "description": "The key of the secret to select from. Must be a valid secret key.",
                          "type": "string"
                        },
                        "name": {
                          "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                          "type": "string"
                        }
                      },
                      "required": [
                        "name"
                      ],
                      "type": "object"
                    },
                    "server": {
                      "description": "Server is the ACME server URL",
                      "type": "string"
                    },
                    "skipTLSVerify": {
                      "description": "If true, skip verifying the ACME server TLS certificate",
                      "type": "boolean"
                    },
                    "solvers": {
                      "description": "Solvers is a list of challenge solvers that will be used to solve ACME challenges for the matching domains.",
                      "items": {
                        "properties": {
                          "dns01": {
                            "properties": {
                              "acmedns": {
                                "description": "ACMEIssuerDNS01ProviderAcmeDNS is a structure containing the configuration for ACME-DNS servers",
                                "properties": {
                                  "accountSecretRef": {
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  },
                                  "host": {
                                    "type": "string"
                                  }
                                },
                                "required": [
                                  "accountSecretRef",
                                  "host"
                                ],
                                "type": "object"
                              },
                              "akamai": {
                                "description": "ACMEIssuerDNS01ProviderAkamai is a structure containing the DNS configuration for Akamai DNS—Zone Record Management API",
                                "properties": {
                                  "accessTokenSecretRef": {
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  },
                                  "clientSecretSecretRef": {
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  },
                                  "clientTokenSecretRef": {
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  },
                                  "serviceConsumerDomain": {
                                    "type": "string"
                                  }
                                },
                                "required": [
                                  "accessTokenSecretRef",
                                  "clientSecretSecretRef",
                                  "clientTokenSecretRef",
                                  "serviceConsumerDomain"
                                ],
                                "type": "object"
                              },
                              "azuredns": {
                                "description": "ACMEIssuerDNS01ProviderAzureDNS is a structure containing the configuration for Azure DNS",
                                "properties": {
                                  "clientID": {
                                    "type": "string"
                                  },
                                  "clientSecretSecretRef": {
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  },
                                  "environment": {
                                    "enum": [
                                      "AzurePublicCloud",
                                      "AzureChinaCloud",
                                      "AzureGermanCloud",
                                      "AzureUSGovernmentCloud"
                                    ],
                                    "type": "string"
                                  },
                                  "hostedZoneName": {
                                    "type": "string"
                                  },
                                  "resourceGroupName": {
                                    "type": "string"
                                  },
                                  "subscriptionID": {
                                    "type": "string"
                                  },
                                  "tenantID": {
                                    "type": "string"
                                  }
                                },
                                "required": [
                                  "clientID",
                                  "clientSecretSecretRef",
                                  "resourceGroupName",
                                  "subscriptionID",
                                  "tenantID"
                                ],
                                "type": "object"
                              },
                              "clouddns": {
                                "description": "ACMEIssuerDNS01ProviderCloudDNS is a structure containing the DNS configuration for Google Cloud DNS",
                                "properties": {
                                  "project": {
                                    "type": "string"
                                  },
                                  "serviceAccountSecretRef": {
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  }
                                },
                                "required": [
                                  "project"
                                ],
                                "type": "object"
                              },
                              "cloudflare": {
                                "description": "ACMEIssuerDNS01ProviderCloudflare is a structure containing the DNS configuration for Cloudflare",
                                "properties": {
                                  "apiKeySecretRef": {
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  },
                                  "apiTokenSecretRef": {
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  },
                                  "email": {
                                    "type": "string"
                                  }
                                },
                                "required": [
                                  "email"
                                ],
                                "type": "object"
                              },
                              "cnameStrategy": {
                                "description": "CNAMEStrategy configures how the DNS01 provider should handle CNAME records when found in DNS zones.",
                                "enum": [
                                  "None",
                                  "Follow"
                                ],
                                "type": "string"
                              },
                              "digitalocean": {
                                "description": "ACMEIssuerDNS01ProviderDigitalOcean is a structure containing the DNS configuration for DigitalOcean Domains",
                                "properties": {
                                  "tokenSecretRef": {
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  }
                                },
                                "required": [
                                  "tokenSecretRef"
                                ],
                                "type": "object"
                              },
                              "rfc2136": {
                                "description": "ACMEIssuerDNS01ProviderRFC2136 is a structure containing the configuration for RFC2136 DNS",
                                "properties": {
                                  "nameserver": {
                                    "description": "The IP address of the DNS supporting RFC2136. Required. Note: FQDN is not a valid value, only IP.",
                                    "type": "string"
                                  },
                                  "tsigAlgorithm": {
                                    "description": "The TSIG Algorithm configured in the DNS supporting RFC2136. Used only when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined. Supported values are (case-insensitive): ``HMACMD5`` (default), ``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``.",
                                    "type": "string"
                                  },
                                  "tsigKeyName": {
                                    "description": "The TSIG Key name configured in the DNS. If ``tsigSecretSecretRef`` is defined, this field is required.",
                                    "type": "string"
                                  },
                                  "tsigSecretSecretRef": {
                                    "description": "The name of the secret containing the TSIG value. If ``tsigKeyName`` is defined, this field is required.",
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  }
                                },
                                "required": [
                                  "nameserver"
                                ],
                                "type": "object"
                              },
                              "route53": {
                                "description": "ACMEIssuerDNS01ProviderRoute53 is a structure containing the Route 53 configuration for AWS",
                                "properties": {
                                  "accessKeyID": {
                                    "description": "The AccessKeyID is used for authentication. If not set we fall-back to using env vars, shared credentials file or AWS Instance metadata see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials",
                                    "type": "string"
                                  },
                                  "hostedZoneID": {
                                    "description": "If set, the provider will manage only this zone in Route53 and will not do an lookup using the route53:ListHostedZonesByName api call.",
                                    "type": "string"
                                  },
                                  "region": {
                                    "description": "Always set the region when using AccessKeyID and SecretAccessKey",
                                    "type": "string"
                                  },
                                  "role": {
                                    "description": "Role is a Role ARN which the Route53 provider will assume using either the explicit credentials AccessKeyID/SecretAccessKey or the inferred credentials from environment variables, shared credentials file or AWS Instance metadata",
                                    "type": "string"
                                  },
                                  "secretAccessKeySecretRef": {
                                    "description": "The SecretAccessKey is used for authentication. If not set we fall-back to using env vars, shared credentials file or AWS Instance metadata https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials",
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    },
                                    "required": [
                                      "name"
                                    ],
                                    "type": "object"
                                  }
                                },
                                "required": [
                                  "region"
                                ],
                                "type": "object"
                              },
                              "webhook": {
                                "description": "ACMEIssuerDNS01ProviderWebhook specifies configuration for a webhook DNS01 provider, including where to POST ChallengePayload resources.",
                                "properties": {
                                  "config": {
                                    "description": "Additional configuration that should be passed to the webhook apiserver when challenges are processed. This can contain arbitrary JSON data. Secret values should not be specified in this stanza. If secret values are needed (e.g. credentials for a DNS service), you should use a SecretKeySelector to reference a Secret resource. For details on the schema of this field, consult the webhook provider implementation's documentation.",
                                    "x-kubernetes-preserve-unknown-fields": true
                                  },
                                  "groupName": {
                                    "description": "The API group name that should be used when POSTing ChallengePayload resources to the webhook apiserver. This should be the same as the GroupName specified in the webhook provider implementation.",
                                    "type": "string"
                                  },
                                  "solverName": {
                                    "description": "The name of the solver to use, as defined in the webhook provider implementation. This will typically be the name of the provider, e.g. 'cloudflare'.",
                                    "type": "string"
                                  }
                                },
                                "required": [
                                  "groupName",
                                  "solverName"
                                ],
                                "type": "object"
                              }
                            },
                            "type": "object"
                          },
                          "http01": {
                            "description": "ACMEChallengeSolverHTTP01 contains configuration detailing how to solve HTTP01 challenges within a Kubernetes cluster. Typically this is accomplished through creating 'routes' of some description that configure ingress controllers to direct traffic to 'solver pods', which are responsible for responding to the ACME server's HTTP requests.",
                            "properties": {
                              "ingress": {
                                "description": "The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed.",
                                "properties": {
                                  "class": {
                                    "description": "The ingress class to use when creating Ingress resources to solve ACME challenges that use this challenge solver. Only one of 'class' or 'name' may be specified.",
                                    "type": "string"
                                  },
                                  "name": {
                                    "description": "The name of the ingress resource that should have ACME challenge solving routes inserted into it in order to solve HTTP01 challenges. This is typically used in conjunction with ingress controllers like ingress-gce, which maintains a 1:1 mapping between external IPs and ingress resources.",
                                    "type": "string"
                                  },
                                  "podTemplate": {
                                    "description": "Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges",
                                    "properties": {
                                      "metadata": {
                                        "description": "ObjectMeta overrides for the pod used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values.",
                                        "properties": {
                                          "annotations": {
                                            "additionalProperties": {
                                              "type": "string"
                                            },
                                            "description": "Annotations that should be added to the create ACME HTTP01 solver pods.",
                                            "type": "object"
                                          },
                                          "labels": {
                                            "additionalProperties": {
                                              "type": "string"
                                            },
                                            "description": "Labels that should be added to the created ACME HTTP01 solver pods.",
                                            "type": "object"
                                          }
                                        },
                                        "type": "object"
                                      },
                                      "spec": {
                                        "description": "PodSpec defines overrides for the HTTP01 challenge solver pod. Only the 'nodeSelector', 'affinity' and 'tolerations' fields are supported currently. All other fields will be ignored.",
                                        "properties": {
                                          "affinity": {
                                            "description": "If specified, the pod's scheduling constraints",
                                            "properties": {
                                              "nodeAffinity": {
                                                "description": "Describes node affinity scheduling rules for the pod.",
                                                "properties": {
                                                  "preferredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.",
                                                    "items": {
                                                      "description": "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op).",
                                                      "properties": {
                                                        "preference": {
                                                          "description": "A node selector term, associated with the corresponding weight.",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "A list of node selector requirements by node's labels.",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "items": {
                                                                      "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                  }
                                                                },
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "type": "object"
                                                              },
                                                              "type": "array"
                                                            },
                                                            "matchFields": {
                                                              "description": "A list of node selector requirements by node's fields.",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "items": {
                                                                      "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                  }
                                                                },
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "type": "object"
                                                              },
                                                              "type": "array"
                                                            }
                                                          },
                                                          "type": "object"
                                                        },
                                                        "weight": {
                                                          "description": "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.",
                                                          "format": "int32",
                                                          "type": "integer"
                                                        }
                                                      },
                                                      "required": [
                                                        "preference",
                                                        "weight"
                                                      ],
                                                      "type": "object"
                                                    },
                                                    "type": "array"
                                                  },
                                                  "requiredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.",
                                                    "properties": {
                                                      "nodeSelectorTerms": {
                                                        "description": "Required. A list of node selector terms. The terms are ORed.",
                                                        "items": {
                                                          "description": "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm.",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "A list of node selector requirements by node's labels.",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "items": {
                                                                      "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                  }
                                                                },
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "type": "object"
                                                              },
                                                              "type": "array"
                                                            },
                                                            "matchFields": {
                                                              "description": "A list of node selector requirements by node's fields.",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "items": {
                                                                      "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                  }
                                                                },
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "type": "object"
                                                              },
                                                              "type": "array"
                                                            }
                                                          },
                                                          "type": "object"
                                                        },
                                                        "type": "array"
                                                      }
                                                    },
                                                    "required": [
                                                      "nodeSelectorTerms"
                                                    ],
                                                    "type": "object"
                                                  }
                                                },
                                                "type": "object"
                                              },
                                              "podAffinity": {
                                                "description": "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).",
                                                "properties": {
                                                  "preferredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                                    "items": {
                                                      "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                      "properties": {
                                                        "podAffinityTerm": {
                                                          "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                          "properties": {
                                                            "labelSelector": {
                                                              "description": "A label query over a set of resources, in this case pods.",
                                                              "properties": {
                                                                "matchExpressions": {
                                                                  "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                  "items": {
                                                                    "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                    "properties": {
                                                                      "key": {
                                                                        "description": "key is the label key that the selector applies to.",
                                                                        "type": "string"
                                                                      },
                                                                      "operator": {
                                                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                        "type": "string"
                                                                      },
                                                                      "values": {
                                                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                        "items": {
                                                                          "type": "string"
                                                                        },
                                                                        "type": "array"
                                                                      }
                                                                    },
                                                                    "required": [
                                                                      "key",
                                                                      "operator"
                                                                    ],
                                                                    "type": "object"
                                                                  },
                                                                  "type": "array"
                                                                },
                                                                "matchLabels": {
                                                                  "additionalProperties": {
                                                                    "type": "string"
                                                                  },
                                                                  "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                  "type": "object"
                                                                }
                                                              },
                                                              "type": "object"
                                                            },
                                                            "namespaces": {
                                                              "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                              "items": {
                                                                "type": "string"
                                                              },
                                                              "type": "array"
                                                            },
                                                            "topologyKey": {
                                                              "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                              "type": "string"
                                                            }
                                                          },
                                                          "required": [
                                                            "topologyKey"
                                                          ],
                                                          "type": "object"
                                                        },
                                                        "weight": {
                                                          "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                          "format": "int32",
                                                          "type": "integer"
                                                        }
                                                      },
                                                      "required": [
                                                        "podAffinityTerm",
                                                        "weight"
                                                      ],
                                                      "type": "object"
                                                    },
                                                    "type": "array"
                                                  },
                                                  "requiredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                                    "items": {
                                                      "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key \u003ctopologyKey\u003e matches that of any node on which a pod of the set of pods is running",
                                                      "properties": {
                                                        "labelSelector": {
                                                          "description": "A label query over a set of resources, in this case pods.",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                              "items": {
                                                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "key is the label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                    "items": {
                                                                      "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                  }
                                                                },
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "type": "object"
                                                              },
                                                              "type": "array"
                                                            },
                                                            "matchLabels": {
                                                              "additionalProperties": {
                                                                "type": "string"
                                                              },
                                                              "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                              "type": "object"
                                                            }
                                                          },
                                                          "type": "object"
                                                        },
                                                        "namespaces": {
                                                          "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                          "items": {
                                                            "type": "string"
                                                          },
                                                          "type": "array"
                                                        },
                                                        "topologyKey": {
                                                          "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                          "type": "string"
                                                        }
                                                      },
                                                      "required": [
                                                        "topologyKey"
                                                      ],
                                                      "type": "object"
                                                    },
                                                    "type": "array"
                                                  }
                                                },
                                                "type": "object"
                                              },
                                              "podAntiAffinity": {
                                                "description": "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).",
                                                "properties": {
                                                  "preferredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                                    "items": {
                                                      "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                      "properties": {
                                                        "podAffinityTerm": {
                                                          "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                          "properties": {
                                                            "labelSelector": {
                                                              "description": "A label query over a set of resources, in this case pods.",
                                                              "properties": {
                                                                "matchExpressions": {
                                                                  "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                  "items": {
                                                                    "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                    "properties": {
                                                                      "key": {
                                                                        "description": "key is the label key that the selector applies to.",
                                                                        "type": "string"
                                                                      },
                                                                      "operator": {
                                                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                        "type": "string"
                                                                      },
                                                                      "values": {
                                                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                        "items": {
                                                                          "type": "string"
                                                                        },
                                                                        "type": "array"
                                                                      }
                                                                    },
                                                                    "required": [
                                                                      "key",
                                                                      "operator"
                                                                    ],
                                                                    "type": "object"
                                                                  },
                                                                  "type": "array"
                                                                },
                                                                "matchLabels": {
                                                                  "additionalProperties": {
                                                                    "type": "string"
                                                                  },
                                                                  "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                  "type": "object"
                                                                }
                                                              },
                                                              "type": "object"
                                                            },
                                                            "namespaces": {
                                                              "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                              "items": {
                                                                "type": "string"
                                                              },
                                                              "type": "array"
                                                            },
                                                            "topologyKey": {
                                                              "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                              "type": "string"
                                                            }
                                                          },
                                                          "required": [
                                                            "topologyKey"
                                                          ],
                                                          "type": "object"
                                                        },
                                                        "weight": {
                                                          "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                          "format": "int32",
                                                          "type": "integer"
                                                        }
                                                      },
                                                      "required": [
                                                        "podAffinityTerm",
                                                        "weight"
                                                      ],
                                                      "type": "object"
                                                    },
                                                    "type": "array"
                                                  },
                                                  "requiredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                                    "items": {
                                                      "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key \u003ctopologyKey\u003e matches that of any node on which a pod of the set of pods is running",
                                                      "properties": {
                                                        "labelSelector": {
                                                          "description": "A label query over a set of resources, in this case pods.",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                              "items": {
                                                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "key is the label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                    "items": {
                                                                      "type": "string"
                                                                    },
                                                                    "type": "array"
                                                                  }
                                                                },
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "type": "object"
                                                              },
                                                              "type": "array"
                                                            },
                                                            "matchLabels": {
                                                              "additionalProperties": {
                                                                "type": "string"
                                                              },
                                                              "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                              "type": "object"
                                                            }
                                                          },
                                                          "type": "object"
                                                        },
                                                        "namespaces": {
                                                          "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                          "items": {
                                                            "type": "string"
                                                          },
                                                          "type": "array"
                                                        },
                                                        "topologyKey": {
                                                          "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                          "type": "string"
                                                        }
                                                      },
                                                      "required": [
                                                        "topologyKey"
                                                      ],
                                                      "type": "object"
                                                    },
                                                    "type": "array"
                                                  }
                                                },
                                                "type": "object"
                                              }
                                            },
                                            "type": "object"
                                          },
                                          "nodeSelector": {
                                            "additionalProperties": {
                                              "type": "string"
                                            },
                                            "description": "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/",
                                            "type": "object"
                                          },
                                          "tolerations": {
                                            "description": "If specified, the pod's tolerations.",
                                            "items": {
                                              "description": "The pod this Toleration is attached to tolerates any taint that matches the triple \u003ckey,value,effect\u003e using the matching operator \u003coperator\u003e.",
                                              "properties": {
                                                "effect": {
                                                  "description": "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.",
                                                  "type": "string"
                                                },
                                                "key": {
                                                  "description": "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.",
                                                  "type": "string"
                                                },
                                                "operator": {
                                                  "description": "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.",
                                                  "type": "string"
                                                },
                                                "tolerationSeconds": {
                                                  "description": "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.",
                                                  "format": "int64",
                                                  "type": "integer"
                                                },
                                                "value": {
                                                  "description": "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.",
                                                  "type": "string"
                                                }
                                              },
                                              "type": "object"
                                            },
                                            "type": "array"
                                          }
                                        },
                                        "type": "object"
                                      }
                                    },
                                    "type": "object"
                                  },
                                  "serviceType": {
                                    "description": "Optional service type for Kubernetes solver service",
                                    "type": "string"
                                  }
                                },
                                "type": "object"
                              }
                            },
                            "type": "object"
                          },
                          "selector": {
                            "description": "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver.",
                            "properties": {
                              "dnsNames": {
                                "description": "List of DNSNames that this solver will be used to solve. If specified and a match is found, a dnsNames selector will take precedence over a dnsZones selector. If multiple solvers match with the same dnsNames value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                                "items": {
                                  "type": "string"
                                },
                                "type": "array"
                              },
                              "dnsZones": {
                                "description": "List of DNSZones that this solver will be used to solve. The most specific DNS zone match specified here will take precedence over other DNS zone matches, so a solver specifying sys.example.com will be selected over one specifying example.com for the domain www.sys.example.com. If multiple solvers match with the same dnsZones value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                                "items": {
                                  "type": "string"
                                },
                                "type": "array"
                              },
                              "matchLabels": {
                                "additionalProperties": {
                                  "type": "string"
                                },
                                "description": "A label selector that is used to refine the set of certificate's that this challenge solver will apply to.",
                                "type": "object"
                              }
                            },
                            "type": "object"
                          }
                        },
                        "type": "object"
                      },
                      "type": "array"
                    }
                  },
                  "required": [
                    "privateKeySecretRef",
                    "server"
                  ],
                  "type": "object"
                },
                "ca": {
                  "properties": {
                    "secretName": {
                      "description": "SecretName is the name of the secret used to sign Certificates issued by this Issuer.",
                      "type": "string"
                    }
                  },
                  "required": [
                    "secretName"
                  ],
                  "type": "object"
                },
                "selfSigned": {
                  "type": "object"
                },
                "vault": {
                  "properties": {
                    "auth": {
                      "description": "Vault authentication",
                      "properties": {
                        "appRole": {
                          "description": "This Secret contains a AppRole and Secret",
                          "properties": {
                            "path": {
                              "description": "Where the authentication path is mounted in Vault.",
                              "type": "string"
                            },
                            "roleId": {
                              "type": "string"
                            },
                            "secretRef": {
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              },
                              "required": [
                                "name"
                              ],
                              "type": "object"
                            }
                          },
                          "required": [
                            "path",
                            "roleId",
                            "secretRef"
                          ],
                          "type": "object"
                        },
                        "kubernetes": {
                          "description": "This contains a Role and Secret with a ServiceAccount token to authenticate with vault.",
                          "properties": {
                            "mountPath": {
                              "description": "The Vault mountPath here is the mount path to use when authenticating with Vault. For example, setting a value to `/v1/auth/foo`, will use the path `/v1/auth/foo/login` to authenticate with Vault. If unspecified, the default value \"/v1/auth/kubernetes\" will be used.",
                              "type": "string"
                            },
                            "role": {
                              "description": "A required field containing the Vault Role to assume. A Role binds a Kubernetes ServiceAccount with a set of Vault policies.",
                              "type": "string"
                            },
                            "secretRef": {
                              "description": "The required Secret field containing a Kubernetes ServiceAccount JWT used for authenticating with Vault. Use of 'ambient credentials' is not supported.",
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              },
                              "required": [
                                "name"
                              ],
                              "type": "object"
                            }
                          },
                          "required": [
                            "role",
                            "secretRef"
                          ],
                          "type": "object"
                        },
                        "tokenSecretRef": {
                          "description": "This Secret contains the Vault token key",
                          "properties": {
                            "key": {
                              "description": "The key of the secret to select from. Must be a valid secret key.",
                              "type": "string"
                            },
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          },
                          "required": [
                            "name"
                          ],
                          "type": "object"
                        }
                      },
                      "type": "object"
                    },
                    "caBundle": {
                      "description": "Base64 encoded CA bundle to validate Vault server certificate. Only used if the Server URL is using HTTPS protocol. This parameter is ignored for plain HTTP protocol connection. If not set the system root certificates are used to validate the TLS connection.",
                      "format": "byte",
                      "type": "string"
                    },
                    "path": {
                      "description": "Vault URL path to the certificate role",
                      "type": "string"
                    },
                    "server": {
                      "description": "Server is the vault connection address",
                      "type": "string"
                    }
                  },
                  "required": [
                    "auth",
                    "path",
                    "server"
                  ],
                  "type": "object"
                },
                "venafi": {
                  "description": "VenafiIssuer describes issuer configuration details for Venafi Cloud.",
                  "properties": {
                    "cloud": {
                      "description": "Cloud specifies the Venafi cloud configuration settings. Only one of TPP or Cloud may be specified.",
                      "properties": {
                        "apiTokenSecretRef": {
                          "description": "APITokenSecretRef is a secret key selector for the Venafi Cloud API token.",
                          "properties": {
                            "key": {
                              "description": "The key of the secret to select from. Must be a valid secret key.",
                              "type": "string"
                            },
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          },
                          "required": [
                            "name"
                          ],
                          "type": "object"
                        },
                        "url": {
                          "description": "URL is the base URL for Venafi Cloud",
                          "type": "string"
                        }
                      },
                      "required": [
                        "apiTokenSecretRef",
                        "url"
                      ],
                      "type": "object"
                    },
                    "tpp": {
                      "description": "TPP specifies Trust Protection Platform configuration settings. Only one of TPP or Cloud may be specified.",
                      "properties": {
                        "caBundle": {
                          "description": "CABundle is a PEM encoded TLS certifiate to use to verify connections to the TPP instance. If specified, system roots will not be used and the issuing CA for the TPP instance must be verifiable using the provided root. If not specified, the connection will be verified using the cert-manager system root certificates.",
                          "format": "byte",
                          "type": "string"
                        },
                        "credentialsRef": {
                          "description": "CredentialsRef is a reference to a Secret containing the username and password for the TPP server. The secret must contain two keys, 'username' and 'password'.",
                          "properties": {
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          },
                          "required": [
                            "name"
                          ],
                          "type": "object"
                        },
                        "url": {
                          "description": "URL is the base URL for the Venafi TPP instance",
                          "type": "string"
                        }
                      },
                      "required": [
                        "credentialsRef",
                        "url"
                      ],
                      "type": "object"
                    },
                    "zone": {
                      "description": "Zone is the Venafi Policy Zone to use for this issuer. All requests made to the Venafi platform will be restricted by the named zone policy. This field is required.",
                      "type": "string"
                    }
                  },
                  "required": [
                    "zone"
                  ],
                  "type": "object"
                }
              },
              "type": "object"
            },
            "status": {
              "description": "IssuerStatus contains status information about an Issuer",
              "properties": {
                "acme": {
                  "properties": {
                    "lastRegisteredEmail": {
                      "description": "LastRegisteredEmail is the email associated with the latest registered ACME account, in order to track changes made to registered account associated with the  Issuer",
                      "type": "string"
                    },
                    "uri": {
                      "description": "URI is the unique account identifier, which can also be used to retrieve account details from the CA",
                      "type": "string"
                    }
                  },
                  "type": "object"
                },
                "conditions": {
                  "items": {
                    "description": "IssuerCondition contains condition information for an Issuer.",
                    "properties": {
                      "lastTransitionTime": {
                        "description": "LastTransitionTime is the timestamp corresponding to the last status change of this condition.",
                        "format": "date-time",
                        "type": "string"
                      },
                      "message": {
                        "description": "Message is a human readable description of the details of the last transition, complementing reason.",
                        "type": "string"
                      },
                      "reason": {
                        "description": "Reason is a brief machine readable explanation for the condition's last transition.",
                        "type": "string"
                      },
                      "status": {
                        "description": "Status of the condition, one of ('True', 'False', 'Unknown').",
                        "enum": [
                          "True",
                          "False",
                          "Unknown"
                        ],
                        "type": "string"
                      },
                      "type": {
                        "description": "Type of the condition, currently ('Ready').",
                        "type": "string"
                      }
                    },
                    "required": [
                      "status",
                      "type"
                    ],
                    "type": "object"
                  },
                  "type": "array"
                }
              },
              "type": "object"
            }
          },
          "type": "object"
        }
        JSON
    }
    version = "v1alpha2"

    versions {
      name    = "v1alpha2"
      served  = true
      storage = true
    }
  }
}