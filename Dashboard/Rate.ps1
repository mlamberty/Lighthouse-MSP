##The section below grabs all resource groups in all subscriptions and at the same time stores all virtual machines including location and size in $VirtualMachines 

  

$VirtualMachines = @() 

$ResourceGroups = @() 

$Subscriptions = Get-AzSubscription 

foreach ($sub in $Subscriptions) { 

    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext 

    $ResourceGroups = Get-AzResourceGroup | Select-Object 'ResourceGroupName' 

    foreach ($group in $ResourceGroups) { 

        $VirtualMachines += Get-AzVM -ResourceGroupName $group.ResourceGroupName} 

  

} 

  

$VirtualMachines | Export-Csv virtualmachinesize.csv 

  

##The section below grabs the current rate card from partner center.  IMPORTANT : You must install the partner center PS module and use it to login to partner center.  Install-Module -Name PartnerCenter -AllowClobber -Scope AllUsers | Connect-PartnerCenter 

  

$RateCard = Get-PartnerAzureRateCard 

  

$RateCardExport = @() 

foreach($i in $RateCard.meters) 

{ 

    foreach($a in $i) 

    { 

        $temp = [ordered]@{  

                   Locale = $a.Locale 

                   Currency = $a.Currency  

                   Category = $a.Category 

                   EffectiveDate = $a.EffectiveDate 

                   Id = $a.Id 

                   IncludedQuantity = $a.IncludedQuantity 

                   Name = $a.Name 

                   Region = $a.Region 

                   Subcategory = $a.Subcategory 

                   Unit = $a.Unit 

                   RateKeys = $a.rates.keys -join ',' 

                   RateValues = $a.rates.values -join ',' 

  

                                                                } 

  

        $RateCardExport += New-Object -TypeName PSObject -Property $temp 

     

    }} 

  

  

  

  

$RateCardExport | Export-Csv ratecard.csv -NoTypeInformation 