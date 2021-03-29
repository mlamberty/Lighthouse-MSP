W##Grabs Subscriptions and Resources in each Sub. 

  

$Resources = @() 

$Subscriptions = Get-AzSubscription 

foreach ($sub in $Subscriptions) { 

    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext 

    $Resources += Get-AzResource | Select-Object -Property ResourceID 

} 

  

##Trims the extra string characters from the ResourceID and grabs All recommendations for each Subscription 

  

  

  

$AdvisorRecommendations = @() 

$TrimmedResources = $Resources | Select-String -pattern '.*/.*/.*' | foreach {$_.Matches.Groups[0].Value.TrimEnd("}").TrimStart("@{ResourceId=")} 

foreach ($sub in $Subscriptions) { 

    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext 

        $AdvisorRecommendations += Get-AzAdvisorRecommendation 

  

} 

  

  

##Creates a new Object array and loads the ID field, Category, Problem, Solution, Recommendation Name, and when the recommendation was last updated into the new array, using ID as the key field.  

  

$AdvisorRecommendationsOutput = @() 

foreach($rec in $AdvisorRecommendations) 

{ 

    foreach($i in $rec) 

    { 

        $temp = [ordered]@{ id = $i.ResourceID 

                   Category = $i.Category 

                   Problem = $i.ShortDescription.Problem 

                   Solution = $i.ShortDescription.Solution 

                   RecommendationName = $i.name 

                   LastUpdated = $i.LastUpdated} 

        $AdvisorRecommendationsOutput += New-Object -TypeName PSObject -Property $temp 

     

    } 

} 

  

##Exports the data held in the new array to Csv 

  

$AdvisorRecommendationsOutput | Export-Csv -NoTypeInformation -path AdvisorRecommendations.csv  
