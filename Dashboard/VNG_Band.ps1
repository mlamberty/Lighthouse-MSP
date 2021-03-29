##Grabs all Subs, then all resource groups from each sub, then adds all VNGs to an array called $VirtualNetworkGateways 

  

$VirtualNetworkGateways = @() 

$ResourceGroups = @() 

$Subscriptions = Get-AzSubscription 

foreach ($sub in $Subscriptions) { 

    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext 

    $ResourceGroups = Get-AzResourceGroup | Select-Object 'ResourceGroupName' 

    $ResourceGroups | foreach-object {$VirtualNetworkGateways += Get-AzVirtualNetworkGateway -ResourceGroupName $_.ResourceGroupName} 

} 

  

##Grabs (Average Bandwidth) and collects that data in $GWMetrics 

  

$GWMetrics = @() 

foreach ($gw in $VirtualNetworkGateways){ 

    $GWMetrics += Get-AzMetric -ResourceId $gw.id -MetricName P2SBandwidth -TimeGrain 01:00:00 -StartTime 2020-08-08T00:00:00Z -EndTime 2020-09-07T23:59:00Z} 

  

##Creating a new array to organize the data for export to CSV. New array is $GWMetricsOutput 

  

$GWMetricsOutput = @() 

foreach ($i in $GWMetrics){ 

foreach($a in $i.data) 

    { 

        $temp = [ordered]@{ id = $i.ID 

                   Time = $a.TimeStamp 

                   Average = $a.Average} 

        $GWMetricsOutput += New-Object -TypeName PSObject -Property $temp 

     

    }} 

  

##Exporting data in $GWMetricsOutput to CSV 

  

$GWMetricsOutput | Export-Csv AverageVPN_P2S_Bandwidth.csv -NoTypeInformation  