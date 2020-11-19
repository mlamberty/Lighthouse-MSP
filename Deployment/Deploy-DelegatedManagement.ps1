# Log in first with Connect-AzAccount if you're not using Cloud Shell
Connect-AzAccount
# Deploy Azure Resource Manager template using template and parameter file locally
New-AzSubscriptionDeployment -Name Synnex-Lighthouse `
                 -Location eastus `
                 -TemplateFile C:\Users\matthewl\Downloads\Azure\WVD\rgdelegatedResourceManagement.json `
                 -TemplateParameterFile C:\Users\matthewl\Downloads\Azure\WVD\rgdelegatedResourceManagement.parameters.json `
                 -Verbose

