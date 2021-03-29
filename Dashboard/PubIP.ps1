$OrphanedIPs = @() 

$Subscriptions = Get-AzSubscription 

foreach ($sub in $Subscriptions) { 

    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext 

    $OrphanedIPs += Get-AzPublicIPAddress | Where-Object { $_.IpAddress -like 'Not Assigned' } 

} 

  

$OrphanedIPs | Export-Csv OrphanedIPAddresses.csv -NoTypeInformation 
    

