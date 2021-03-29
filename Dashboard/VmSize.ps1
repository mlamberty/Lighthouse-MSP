  

##Gets Azure Subscriptions 

  

$Subscriptions = Get-AzSubscription 

  

##Gathers VMs and their current sizes and other attributes | ResourceGroup, id, VMID, VMName, Location    

  

$VMAvailableSizeOutput = @() 

$VirtualMachines = @() 

foreach ($sub in $Subscriptions) { 

    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext     

    $VirtualMachines = Get-AzVM 

    foreach ($vm in $VirtualMachines){ 

    $temp2 = [ordered] @{ 

                   id = $vm.ID 

                   VMid = $vm.vmid 

                   VMName = $vm.name 

                   Location = $vm.location 

                   Size = $vm.hardwareprofile.vmsize 

                   ResourceGroup = $vm.ResourceGroupName 

                   AvailableSize = Get-AzVmSize -ResourceGroupName $vm.ResourceGroupName -VMName $vm.Name | Select-Object name} 

                   $VMAvailableSizeOutput += New-Object -TypeName PSObject -Property $temp2 

    }} 

  

##Creates a new array for export loading everything from previous array iterating through each vm available size in the nested object within that array. 

  

$VMAvailableSizeExport = @() 

foreach ($i in $VMAvailableSizeOutput){ 

    foreach ($name in $i.availablesize){ 

    $temp3 = [ordered] @{ 

                   id = $i.ID 

                   VMid = $i.vmid 

                   VMName = $i.vmname 

                   ResourceGroup = $i.ResourceGroup 

                   Location = $i.location 

                   CurrentSize = $i.size 

                   Availsize = $name.name 

                                            } 

                   $VMAvailableSizeExport += New-Object -TypeName PSObject -Property $temp3 

                                                                                                } 

 } 

  

##Exports the csv to working directory. 

  

$VMAvailableSizeExport | Export-Csv AvailableVMSizes.csv -NoTypeInformation  