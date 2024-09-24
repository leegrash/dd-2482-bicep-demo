param locations array
param appServicePlanName string
param appServiceSku string
param appServiceName string
param testAppServiceName string

resource appServicePlans 'Microsoft.Web/serverfarms@2021-02-01' = [for location in locations: {
  name: '${appServicePlanName}-${location}'
  location: location
  sku: {
    name: appServiceSku
    tier: 'Standard'
  }
  properties: {
    reserved: true
  }
}]

module DemoWebAppModule './modules/AppService.bicep' = [for location in locations: {
  name: '${deployment().name}-AppService-${location}'
  params: {
    appServicePlanName: '${appServicePlanName}-${location}'
    appServiceName: '${appServiceName}-${location}'
    location: location
  }
  dependsOn: [
    appServicePlans
  ]
}]

module DemoTestWebAppModule './modules/AppService.bicep' = [for location in locations: {
  name: '${deployment().name}-AppServiceTest-${location}'
  params: {
    appServicePlanName: '${appServicePlanName}-${location}'
    appServiceName: '${testAppServiceName}-${location}'
    location: location
  }
  dependsOn: [
    appServicePlans
  ]
}]
