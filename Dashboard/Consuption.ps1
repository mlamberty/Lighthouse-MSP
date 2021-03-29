##Grabs ConsumptionData for each subscription in a tenant.  Sets the billing period for the last full billing period. 

  

$ConsumptionData = @() 

$Subscriptions = Get-AzSubscription 

foreach ($sub in $Subscriptions) { 

    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext 

    $currentperiod = Get-AzBillingPeriod -maxcount 2 

    $ConsumptionData += Get-AzConsumptionUsageDetail -BillingPeriodName $currentperiod[1].name 

} 

  

##Creates a new array and loads the data we want from what we stored in $ConsumptionData in the previous step.  We need to do this so we can dig into the tags nested object, otherwise we could export as is.   

$ConsumptionDataOutput = @() 

foreach($c in $ConsumptionData) 

{ 

    foreach($i in $c) 

    { 

        $temp = [ordered]@{  

                   AccountName = $i.AccountName 

                   AdditionalInfo = $i.AdditionalInfo 

                   AdditionalProperties = $i.AdditionalProperties 

                   BillableQuantity = $i.BillableQuantity 

                   BillingPeriodId = $i.BillingPeriodId 

                   BillingPeriodName = $i.BillingPeriodName 

                   ConsumedService = $i.ConsumedService 

                   CostCenter = $i.CostCenter 

                   Currency = $i.Currency 

                   DepartmentName = $i.DepartmentName 

                   Id = $i.Id 

                   InstanceId = $i.InstanceId 

                   InvoiceName = $i.InvoiceName 

                   IsEstimated = $i.IsEstimated 

                   MeterDetails = $i.MeterDetails 

                   MeterId = $i.MeterId 

                   Name = $i.Name 

                   PretaxCost = $i.PretaxCost 

                   Product = $i.Product 

                   SubscriptionGuid = $i.SubscriptionGuid 

                   SubscriptionName = $i.SubscriptionName 

                   TagName = $i.tags.keys -join ',' 

                   TagValue = $i.tags.values -join ',' 

                   Type = $i.Type 

                   UsageEnd = $i.UsageEnd 

                   UsageQuantity = $i.UsageQuantity 

                   UsageStart = $i.UsageStart 

                                                            } 

  

        $ConsumptionDataOutput += New-Object -TypeName PSObject -Property $temp 

     

    } 

} 

  

##Exports the data stored in $ConsumptionDataOutput to csv in the working directory.   

  

$ConsumptionDataOutput | Export-Csv ConsumptionData.csv -NoTypeInformation 



    

