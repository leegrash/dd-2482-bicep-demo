param appServicePlanName string
param location string
param sku object
param zoneRedundant bool = false
param capacity int = 1
param perSiteScaling bool = false
param kind string = 'linux'
param reserved bool = false

//Zone Redundant requires 3 instances
var actualCapacity = (zoneRedundant ? max(capacity, 3) : capacity)

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
    capacity: actualCapacity
  }
  kind: kind
  properties: {
    reserved: reserved
    perSiteScaling: perSiteScaling
    zoneRedundant: zoneRedundant
  }
}
