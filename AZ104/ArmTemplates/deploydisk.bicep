@description('Nmae of managed disk')
param managedDiskName string = 'az104-disk5'

@description('Disk size in GiB')
@minValue(4)
@maxValue(655366)
param diskSizeInGiB int = 32

@description('Disk IOPS value')
@minValue(100)
@maxValue(160000)
param diskIopsReadWrite int = 100

@description('Disk throughput value in MBps')
@minValue(1)
@maxValue(2000)
param diskMbpsReadWrite int = 10

@description('Location for all resources.')
param location string = resourceGroup().location

resource managedDisk 'Microsoft.Compute/disks@2024-03-02' = {

    name: managedDiskName
    location: location
    sku: {
        name: 'Standard_LRS'
    }
    properties: {
        creationData: {
            createOption: 'Empty'
        }
        diskSizeGB: diskSizeInGiB
    }

}
