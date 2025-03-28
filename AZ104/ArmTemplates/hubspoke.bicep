resource vnethub1_resource 'Microsoft.Network/virtualNetworks@2024-04-01' = {
  name: 'vnet-infra-hub-eus-1'
  location: 'East US'
  properties: {
    addressPrefixes: [ '10.0.0.0/16' ]
    subnets: [
      {
        name:
        properties: {

        }
      }
    ]
  }
  
}
