# Log in first with Connect-AzAccount if you're not using Cloud Shell
Connect-AzAccount -Tenant c01f33e1-d38a-47c8-a733-af070bcc674d -Subscription "Paul J - Subscription"

# Deploy Azure Resource Manager template using template and parameter file locally
New-AzResourceGroupDeployment -Name workspace `
                 -ResourceGroupName Lighthouse-test `
                 -TemplateUri https://raw.githubusercontent.com/mlamberty/Lighthouse-MSP/main/Workspace/workspaceconfig.json `
                 -WhatIf
                 -Verbose -DeploymentDebugLogLevel All 

