az group list --query "[].{name:name}"

az group list --query "[].name"

az network route-table create --name publictable \
> --resource-group "learn-19263351-fc25-4625-ac9d-247ced9003be" \
> --disable-bgp-route-propagation false
{
  "disableBgpRoutePropagation": false,
  "etag": "W/\"27561439-c2d3-49ad-b962-9d5e326f4cbc\"",
  "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/learn-19263351-fc25-4625-ac9d-247ced9003be/providers/Microsoft.Network/routeTables/publictable",
  "location": "westus",
  "name": "publictable",
  "provisioningState": "Succeeded",
  "resourceGroup": "learn-19263351-fc25-4625-ac9d-247ced9003be",
  "resourceGuid": "5f791082-62fc-4588-af4e-3c30016657a3",
  "routes": [],
  "type": "Microsoft.Network/routeTables"
}

az network route-table route create --route-table-name publictable --resource-group $rgname --name productionsubnet --address-prefix 10.0.1.0/
24 --next-hop-type VirtualAppliance --next-hop-ip-address 10.0.2.4
{
  "addressPrefix": "10.0.1.0/24",
  "etag": "W/\"b7efaa7d-248a-48af-bfa1-104f7ed6a205\"",
  "hasBgpOverride": false,
  "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/learn-19263351-fc25-4625-ac9d-247ced9003be/providers/Microsoft.Network/routeTables/publictable/routes/productionsubnet",
  "name": "productionsubnet",
  "nextHopIpAddress": "10.0.2.4",
  "nextHopType": "VirtualAppliance",
  "provisioningState": "Succeeded",
  "resourceGroup": "learn-19263351-fc25-4625-ac9d-247ced9003be",
  "type": "Microsoft.Network/routeTables/routes"
}

az network route-table route list --resource-group  $rgname --route-table-name publictable
[
  {
    "addressPrefix": "10.0.1.0/24",
    "etag": "W/\"b7efaa7d-248a-48af-bfa1-104f7ed6a205\"",
    "hasBgpOverride": false,
    "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/learn-19263351-fc25-4625-ac9d-247ced9003be/providers/Microsoft.Network/routeTables/publictable/routes/productionsubnet",
    "name": "productionsubnet",
    "nextHopIpAddress": "10.0.2.4",
    "nextHopType": "VirtualAppliance",
    "provisioningState": "Succeeded",
    "resourceGroup": "learn-19263351-fc25-4625-ac9d-247ced9003be",
    "type": "Microsoft.Network/routeTables/routes"
  }
]

dwayneh01 [ ~ ]$ az network vnet create \
> --name vnet \
> --resource-group $rgname \
> --address-prefixes 10.0.0.0/16 \
> --subnet-name publicsubnet \
> --subnet-prefixes 10.0.0.0/24
{
  "newVNet": {
    "addressSpace": {
      "addressPrefixes": [
        "10.0.0.0/16"
      ]
    },
    "enableDdosProtection": false,
    "etag": "W/\"6d316f4e-0546-475c-a59d-1bf321a5d566\"",
    "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/learn-19263351-fc25-4625-ac9d-247ced9003be/providers/Microsoft.Network/virtualNetworks/vnet",
    "location": "westus",
    "name": "vnet",
    "provisioningState": "Succeeded",
    "resourceGroup": "learn-19263351-fc25-4625-ac9d-247ced9003be",
    "resourceGuid": "60a33c00-6677-4513-a3d9-d337320da11b",
    "subnets": [
      {
        "addressPrefix": "10.0.0.0/24",
        "delegations": [],
        "etag": "W/\"6d316f4e-0546-475c-a59d-1bf321a5d566\"",
        "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/learn-19263351-fc25-4625-ac9d-247ced9003be/providers/Microsoft.Network/virtualNetworks/vnet/subnets/publicsubnet",
        "name": "publicsubnet",
        "networkSecurityGroup": {
          "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/SandboxNSGs/providers/Microsoft.Network/networkSecurityGroups/NSG-westus",
          "resourceGroup": "SandboxNSGs"
        },
        "privateEndpointNetworkPolicies": "Disabled",
        "privateLinkServiceNetworkPolicies": "Enabled",
        "provisioningState": "Succeeded",
        "resourceGroup": "learn-19263351-fc25-4625-ac9d-247ced9003be",
        "type": "Microsoft.Network/virtualNetworks/subnets"
      }
    ],
    "type": "Microsoft.Network/virtualNetworks",
    "virtualNetworkPeerings": []
  }
}

dwayneh01 [ ~ ]$ az network vnet subnet create \
> --name privatesubnet \
> --vnet-name vnet \
> --resource-group $rgname \
> --address-prefix 10.0.1.0/24
{
  "addressPrefix": "10.0.1.0/24",
  "delegations": [],
  "etag": "W/\"d863bc46-d34a-49d1-acee-f9f103b35236\"",
  "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/learn-19263351-fc25-4625-ac9d-247ced9003be/providers/Microsoft.Network/virtualNetworks/vnet/subnets/privatesubnet",
  "name": "privatesubnet",
  "networkSecurityGroup": {
    "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/SandboxNSGs/providers/Microsoft.Network/networkSecurityGroups/NSG-westus",
    "resourceGroup": "SandboxNSGs"
  },
  "privateEndpointNetworkPolicies": "Disabled",
  "privateLinkServiceNetworkPolicies": "Enabled",
  "provisioningState": "Succeeded",
  "resourceGroup": "learn-19263351-fc25-4625-ac9d-247ced9003be",
  "type": "Microsoft.Network/virtualNetworks/subnets"
}
dwayneh01 [ ~ ]$ az network vnet subnet create --name dmzsubnet --vnet-name vnet --resource-group $rgname --address-prefix 10.0.2.0/24
{
  "addressPrefix": "10.0.2.0/24",
  "delegations": [],
  "etag": "W/\"45061d56-9192-4354-bf00-b1d134a4b31c\"",
  "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/learn-19263351-fc25-4625-ac9d-247ced9003be/providers/Microsoft.Network/virtualNetworks/vnet/subnets/dmzsubnet",
  "name": "dmzsubnet",
  "networkSecurityGroup": {
    "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/SandboxNSGs/providers/Microsoft.Network/networkSecurityGroups/NSG-westus",
    "resourceGroup": "SandboxNSGs"
  },
  "privateEndpointNetworkPolicies": "Disabled",
  "privateLinkServiceNetworkPolicies": "Enabled",
  "provisioningState": "Succeeded",
  "resourceGroup": "learn-19263351-fc25-4625-ac9d-247ced9003be",
  "type": "Microsoft.Network/virtualNetworks/subnets"
}

ayneh01 [ ~ ]$ az network vnet subnet update \
> --name publicsubnet \
> --vnet-name vnet \
> --resource-group $rgname \
> --route-table publictable
{
  "addressPrefix": "10.0.0.0/24",
  "delegations": [],
  "etag": "W/\"4acf8068-e3e9-46f5-8910-1a52ea006b3c\"",
  "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/learn-19263351-fc25-4625-ac9d-247ced9003be/providers/Microsoft.Network/virtualNetworks/vnet/subnets/publicsubnet",
  "name": "publicsubnet",
  "networkSecurityGroup": {
    "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/SandboxNSGs/providers/Microsoft.Network/networkSecurityGroups/NSG-westus",
    "resourceGroup": "SandboxNSGs"
  },
  "privateEndpointNetworkPolicies": "Disabled",
  "privateLinkServiceNetworkPolicies": "Enabled",
  "provisioningState": "Succeeded",
  "resourceGroup": "learn-19263351-fc25-4625-ac9d-247ced9003be",
  "routeTable": {
    "id": "/subscriptions/15d8a956-80fb-4ce9-9ddc-722e26d3ba5a/resourceGroups/learn-19263351-fc25-4625-ac9d-247ced9003be/providers/Microsoft.Network/routeTables/publictable",
    "resourceGroup": "learn-19263351-fc25-4625-ac9d-247ced9003be"
  },
  "type": "Microsoft.Network/virtualNetworks/subnets"
}
dwayneh01 [ ~ ]$ 



1 [ ~ ]$ az vm create \
> --resource-group $rgname \
> --name nva \
> --vnet-name vnet \
> --subnet dmzsubnet \
> --image Ubuntu2204 \
> --admin-username azureuser \
> --admin-password $password
{
  "fqdns": "",
  "id": "/subscriptions/457e6ffc-5ba8-4a0a-b13c-7d23ae3053c7/resourceGroups/learn-9bc70698-8cd1-4f10-a8a4-97d5edbdee38/providers/Microsoft.Compute/virtualMachines/nva",
  "location": "westus",
  "macAddress": "00-0D-3A-5C-BD-0E",
  "powerState": "VM running",
  "privateIpAddress": "10.0.2.4",
  "publicIpAddress": "13.93.160.226",
  "resourceGroup": "learn-9bc70698-8cd1-4f10-a8a4-97d5edbdee38",
  "zones": ""
}
dwayneh01 [ 

    NICID=$(az vm nic list --resource-group $rgname --vm-name nva --query "[].{id:id}" --output tsv)
NVAIP="$(az vm list-ip-addresses \
    --resource-group "learn-9bc70698-8cd1-4f10-a8a4-97d5edbdee38" \
    --name nva \
    --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    --output tsv)"

ssh -t -o StrictHostKeyChecking=no azureuser@$NVAIP 'sudo sysctl -w net.ipv4.ip_forward=1; exit;'














