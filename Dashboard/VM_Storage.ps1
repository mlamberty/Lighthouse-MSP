##Grabs Subscriptions and VMs in each Sub. 

  

$Resources = @() 

$Subscriptions = Get-AzSubscription 

foreach ($sub in $Subscriptions) { 

    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext 

    $Resources += Get-AzResource -ResourceType Microsoft.Storage/storageAccounts | Select-Object -Property ResourceID 

} 

  

##Trims the extra string characters from the ResourceID and grabs UsedCapacity (measured in bytes) for each resource ID/StorageAccount 

  

$Metric = @() 

$TrimmedResources = $Resources | Select-String -pattern '.*/.*/.*' | foreach {$_.Matches.Groups[0].Value.TrimEnd("}").TrimStart("@{ResourceId=")} 

foreach ($i in $TrimmedResources){ 

$Metric += Get-AzMetric -ResourceID $i -MetricName "UsedCapacity" -TimeGrain 01:00:00 -StartTime 2020-08-14T00:00:00Z -EndTime 2020-08-21T23:59:00Z -WarningAction SilentlyContinue

  

} 

  

  

##Creates a new Object array and loads the ID field, TimeStamp, and Percentage CPU average into the new array, using ID as the key field.  

  

$MetricOutput = @() 

foreach($a in $Metric) 

{ 

    foreach($Time in $a.data) 

    { 

        $temp = [ordered]@{ id = $A.ID 

                   Time = $Time.TimeStamp 

                   Average = $Time.Average} 

        $MetricOutput += New-Object -TypeName PSObject -Property $temp 

     

    } 

} 

  

##Exports the data held in the new array to Csv 

  

$MetricOutput | Export-Csv storage.csv -NoTypeInformation 


