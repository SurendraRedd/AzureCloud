$accountList = az account list
$accountObjectList = $accountList | ConvertFrom-Json
$accountObjectList | ForEach-Object -Process {
               $subscriptionId = $_.id
               $subscriptionName = $_.name
               az account set --subscription $_.id
               $resourceList = az resource list --output json --query "[].{name:name, resourceGroup:resourceGroup, type:type, sku:sku.name, kind:kind, location:location }"
               $resourceObjectList = $resourceList | ConvertFrom-Json
               $resourceObjectList | ForEach-Object -Process {
                         $_ | Add-Member -NotePropertyName SubscriptionId -NotePropertyValue $subscriptionId
                         $_ | Add-Member -NotePropertyName SubscriptionName -NotePropertyValue $subscriptionName

               }
               $resourceObjectList | Export-Csv -Path .\azureResourceList.csv -Append
}
