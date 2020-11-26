# Log in first with Connect-AzAccount if you're not using Cloud Shell
Connect-AzAccount
# Deploy Azure Resource Manager template using template and parameter file locally
New-AzSubscriptionDeployment -Name Synnex-Lighthouse `
                 -Location eastus `
                 -TemplateUri https://raw.githubusercontent.com/mlamberty/Lighthouse-MSP/main/Deployment/azuredeploy.json `
                 -TemplateParameterUri https://raw.githubusercontent.com/mlamberty/Lighthouse-MSP/main/Deployment/azuredeploy.parameters.json `
                 -Verbose

