$workloadProfile = New-AzContainerAppWorkloadProfileObject -Name "Consumption" -Type "Consumption"
$env = New-AzContainerAppManagedEnv -Name 'envDev' -ResourceGroupName az-104-study -Location 'East US' -WorkloadProfile $workloadProfile
$template=New-AzContainerAppTemplateObject -Image 'mcr.microsoft.com/azuredocs/aci-helloworld:latest' -Name 'containerhelloworld1' -ResourceCpu 0.75 -ResourceMemory 1.5Gi
$config=New-AzContainerAppConfigurationObject -IngressExternal $True -IngressTargetPort 80             
New-AzContainerApp -Name 'ncapp-helloworld1' -Location 'East US' -ResourceGroupName 'az-104-study' -TemplateContainer $template -Configuration $config -EnvironmentId $env.id