$Disk = @()
$blobs =@()
$Subscriptions =@( Get-AzSubscription | Set-AzContext | Out-Null)
foreach ($sub in $Subscriptions) {
    Get-AzSubscription -SubscriptionName $sub.Name 
    $VMD = Get-AzDisk 
    $Storage = Get-AzStorageAccount
        foreach ($account in $Storage){
         $key = (Get-AzStorageAccountKey -ResourceGroupName $account.ResourceGroupName -Name $account.StorageAccountName)[0].Value
         $context = New-AzStorageContext -StorageAccountName $account.StorageAccountName -StorageAccountKey $key
         $containers = Get-AzStorageContainer -Context $context
foreach($container in $containers) {

            $blobs = Get-AzStorageBlob -Container $container.Name -Context $context `
            -Blob *.vhd | Where-Object { $_.BlobType -eq 'PageBlob' }
            }
        }
}

$VMD | ForEach-Object {
    [PSCustomObject]@{
        "Name" = $_.Name
        "Host" = $_.ManagedBy
        "Size" = $_.DiskSizeGB
        }
        }
$blobs | ForEach-Object {
[PSCustomObject] @{
           "Name" $_.Name
           "Status" = $_.ICloudBlob.Properties.LeaseStatus
            } 
        }}          


        



        
$Disk += ($VMD | Where-Object {$_.ManagedBy -eq $Null})
$Disk += ($blobs | Where-Object {$_.ICloudBlob.Properties.LeaseStatus -eq 'Unlocked'})



    

