> LINODE.CLOUD.FIREWALL    (/Users/unixthat/.ansible/collections/ansible_collections/linode/cloud/plugins/modules/firewall.py)

        Manage Linode Firewalls.

OPTIONS (= is mandatory):

- devices
        The devices that are attached to this Firewall.
        default: null
        elements: dict
        type: list

        SUBOPTIONS:

        = id
            The unique ID of the device to attach to this Firewall.
            type: int

        - type
            The type of device to be attached to this Firewall.
            default: linode
            type: str

- label
        The unique label to give this Firewall.
        default: null
        type: str

- rules
        The inbound and outbound access rules to apply to this
        Firewall.
        default: null
        type: dict

        SUBOPTIONS:

        - inbound
            A list of rules for inbound traffic.
            default: null
            elements: dict
            type: list

            SUBOPTIONS:

            = action
                Controls whether traffic is accepted or dropped by
                this rule.
                choices: [ACCEPT, DROP]
                type: str

            - addresses
                Allowed IPv4 or IPv6 addresses.
                default: null
                type: dict

                SUBOPTIONS:

                - ipv4
                    A list of IPv4 addresses or networks.
                    Must be in IP/mask format.
                    default: null
                    elements: str
                    type: list

                - ipv6
                    A list of IPv6 addresses or networks.
                    Must be in IP/mask format.
                    default: null
                    elements: str
                    type: list

            - description
                A description for this rule.
                default: null
                type: str

            = label
                The label of this rule.
                type: str

            - ports
                A string representing the port or ports on which
                traffic will be allowed.
                See https://techdocs.akamai.com/linode-
                api/reference/post-firewalls
                default: null
                type: str

            - protocol
                The type of network traffic to allow.
                default: null
                type: str

        - inbound_policy
            The default behavior for inbound traffic.
            default: null
            type: str

        - outbound
            A list of rules for outbound traffic.
            default: null
            elements: dict
            type: list

            SUBOPTIONS:

            = action
                Controls whether traffic is accepted or dropped by
                this rule.
                choices: [ACCEPT, DROP]
                type: str

            - addresses
                Allowed IPv4 or IPv6 addresses.
                default: null
                type: dict

                SUBOPTIONS:

                - ipv4
                    A list of IPv4 addresses or networks.
                    Must be in IP/mask format.
                    default: null
                    elements: str
                    type: list

                - ipv6
                    A list of IPv6 addresses or networks.
                    Must be in IP/mask format.
                    default: null
                    elements: str
                    type: list

            - description
                A description for this rule.
                default: null
                type: str

            = label
                The label of this rule.
                type: str

            - ports
                A string representing the port or ports on which
                traffic will be allowed.
                See https://techdocs.akamai.com/linode-
                api/reference/post-firewalls
                default: null
                type: str

            - protocol
                The type of network traffic to allow.
                default: null
                type: str

        - outbound_policy
            The default behavior for outbound traffic.
            default: null
            type: str

= state
        The desired state of the target.
        choices: [present, absent, update]
        type: str

- status
        The status of this Firewall.
        default: null
        type: str

- tags
        A list of tags to apply to this Firewall.
        default: null
        type: list


REQUIREMENTS:  python >= 3

AUTHOR: Luke Murphy (@decentral1se), Charles Kenney (@charliekenney23), Phillip Campbell (@phillc), Lena Garber (@lbgarber), Jacob Riddle (@jriddle), Zhiwei Liang (@zliang), Ye Chen (@yechen), Youjung Kim (@ykim), Vinay Shanthegowda (@vshanthe), Erik Zilber (@ezilber)

EXAMPLES:

- name: Create a Linode Firewall
  linode.cloud.firewall:
    label: my-firewall
    devices:
    - id: 123
      type: linode
    rules:
      inbound_policy: DROP
      inbound:
      - label: allow-http-in
        addresses:
          ipv4:
          - 0.0.0.0/0
          ipv6:
          - ff00::/8
        description: Allow inbound HTTP and HTTPS connections.
        ports: 80,443
        protocol: TCP
        action: ACCEPT
      outbound_policy: DROP
      outbound:
      - label: allow-http-out
        addresses:
          ipv4:
          - 0.0.0.0/0
          ipv6:
          - ff00::/8
        description: Allow outbound HTTP and HTTPS connections.
        ports: 80,443
        protocol: TCP
        action: ACCEPT
    state: present
- name: Delete a Linode Firewall
  linode.cloud.firewall:
    label: my-firewall
    state: absent


RETURN VALUES:
- devices
        A list of Firewall devices JSON serialized form.
        returned: always
        sample: [[{created: '2018-01-01T00:01:01', entity: {id: 123, label: my-linode, type: linode,
                url: /v4/linode/instances/123}, id: 123, updated: '2018-01-02T00:01:01'}]]
        type: list

- firewall
        The Firewall description in JSON serialized form.
        returned: always
        sample: [{created: '2018-01-01T00:01:01', id: 123, label: firewall123, rules: {inbound: [
                {action: ACCEPT, addresses: {ipv4: [192.0.2.0/24], ipv6: ['2001:DB8::/32']},
                  description: An example firewall rule description., label: firewallrule123,
                  ports: '22-24, 80, 443', protocol: TCP}], inbound_policy: DROP, outbound: [
                {action: ACCEPT, addresses: {ipv4: [192.0.2.0/24], ipv6: ['2001:DB8::/32']},
                  description: An example firewall rule description., label: firewallrule123,
                  ports: '22-24, 80, 443', protocol: TCP}], outbound_policy: DROP}, status: enabled,
            tags: [example tag, another example], updated: '2018-01-02T00:01:01'}]
        type: dict
