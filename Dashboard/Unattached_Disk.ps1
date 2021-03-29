$Disk = @()
$blobs =@()
$Subscriptions = Get-AzSubscription
$VMD = Search-AzGraph -Subscription $Subscriptions -Query "Resources | where type =~ 'Microsoft.Compute/disks' and properties.diskState=~ 'Unattached' `
 | project id, name, diskInGB = properties.diskSizeGB, diskState = properties.diskState, timeCreated = properties.timeCreated" 
 $Accounts = Search-AzGraph -Subscription $Subscriptions -Query  "Resources | where type =~ 'Microsoft.Storage/storageAccounts'"
 $Subscriptions | Set-AzContext
 foreach ($account in $Accounts){
    $storageKey = (Get-AzStorageAccountKey -ResourceGroupName $account.resourceGroup -Name $account.name)[0].Value
    $Context = New-AzStorageContext -StorageAccountName $account.name -StorageAccountKey $storageKey
    $Containers = Get-AzStorageContainer -Context $Context
 }

    foreach($container in $Containers)  {
        $blobs = Get-AzStorageBlob -Container $container.Name -Context $Context -Blob *.vhd | Where-Object { $_.BlobType -eq 'PageBlob' }
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
           "Name" = $_.Name
           "Status" = $_.ICloudBlob.Properties.LeaseStatus
            } 
        }         


        



        
$Disk += ($VMD | Where-Object {$_.ManagedBy -eq $Null})
$Disk += ($blobs | Where-Object {$_.Status -eq 'Unlocked'})



    

