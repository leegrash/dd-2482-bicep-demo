param appServiceName string
param location string
param appServicePlanName string

//--------------- Existing resources --------------//

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' existing = {
  name: appServicePlanName
}

//--------------- New resources --------------//

resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    clientAffinityEnabled: false
    siteConfig: {
      http20Enabled: true
      alwaysOn: false
      httpLoggingEnabled: true
      ftpsState: 'Disabled'
      logsDirectorySizeLimit: 35
      minTlsVersion: '1.2'
    }
  }
}
