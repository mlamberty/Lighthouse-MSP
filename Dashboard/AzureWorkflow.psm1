Workflow Get-CostAssessment {
$Resources = @()
$vm = @()
$Disk = @()
$blobs =@()
$Subscriptions = Get-AzSubscription
parallel {
	InlineScript {
        C:\Users\matthewl\Downloads\Azure\Scripts\Consuption.ps1
        }
    InlineScript {
        C:\Users\matthewl\Downloads\Azure\Scripts\Advisor.ps1
        }
    InlineScript {
        C:\Users\matthewl\Downloads\Azure\Scripts\PubIP.ps1
        }   
    InlineScript {
        C:\Users\matthewl\Downloads\Azure\Scripts\Rate.ps1
        }
    InlineScript {
        C:\Users\matthewl\Downloads\Azure\Scripts\VM_Storage.ps1
        }
    InlineScript {
        C:\Users\matthewl\Downloads\Azure\Scripts\VmSize.ps1
        }
    InlineScript {
        C:\Users\matthewl\Downloads\Azure\Scripts\Working_Usage.ps1
        }
    InlineScript {
        C:\Users\matthewl\Downloads\Azure\ScriptsVNG_Con.ps1
        }
    InlineScript {
        C:\Users\matthewl\Downloads\Azure\ScriptsVNG_Band.ps1
        }
    }
}