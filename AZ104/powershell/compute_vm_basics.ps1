<#
   Install-Module -Name Az -Repository PSGallery -Force
   Update-Module -Name Az -Force
#>

Connect-AzAccount

New-AzResourceGroup -Name 'Az-104' -Location eastus

Get-AzVmSize -Location eastus | Where-Object { $_.Name -like '*B2*' } | Select-Object -Last 1

Get-AzVMImagePublisher -Location eastus | ForEach-Object { Get-AzVMImageOffer -Location eastus -PublisherName $_.PublisherName }

$skus=Get-AzVMImageSku -Location eastus -PublisherName $publisher.publisherName -Offer $offer.Offer

$skus | ForEach-Object { echo $_.Skus }

$publisher=Get-AzVMImagePublisher -Location eastus | Where-Object {$_.PublisherName -Like '*Server'} | Select-Object -index 4

$offer=Get-AzVmImageOffer -Location eastus -PublisherName $publisher.publisherName | Select-Object -Index 4

$vmsku=$skus | Where-Object { $_.Skus -Like '2025*core*smalldisk*' } | Select-Object -Last 1 

$urn=$publisher.publisherName+":"+$vmsku.Offer+":"+$vmsku.Skus+":latest"

New-AZVm -ResourceGroupName @rg -Image $urn  

$myvm.OSProfile | Select-Object -Property Computer, AdminUserName 

$myvm | Get-AzVirtualNetwork

$job = Remove-AzResourceGroup -Name @rg -Force -AsJob

Wait-Job -Id $job.id