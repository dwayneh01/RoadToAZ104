New-AzAppServicePlan -ResourceGroupName "az-104-study" -Name "servicePlanViaPS" -Location "West US" -Tier "Free"

New-AzAppServicePlan -Name "serviccePlanViaPS" -Location "West US" -ResourceGroupName "az-104-study" -Tier "Free" -Linuxi

New-AzWebApp -ResourceGroupName "az-104-study" -Location "West US" -AppServicePlan "serviccePlanViaPS" -GitRepositoryPath "https://github.com/dwayneh01/flask.git"

# app settings for config

$val=Get-AzResource -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceGroupName "az-104-study" -Name "linuxflaskapp-fdsfijhdsfdhsfjdsf232huh/web" -ApiVersion 2015-08-01

echo $val.properties 


$webappname="mywebapp$(Get-Random)"

cd $gitdirectory

# Create a web app and set up Git deployment.
New-AzWebApp -Name $webappname

# Configure GitHub deployment from your GitHub repo and deploy once.
$PropertiesObject = @{
    scmType = "LocalGit";
}
Set-AzResource -Properties $PropertiesObject -ResourceGroupName $webappname `
-ResourceType Microsoft.Web/sites/config -ResourceName $webappname/web `
-ApiVersion 2015-08-01 -Force

# Get publishing profile for the web app
$xml = [xml](Get-AzWebAppPublishingProfile -Name $webappname `
-ResourceGroupName $webappname `
-OutputFile null)

# Extract connection information from publishing profile
$username = $xml.SelectNodes("//publishProfile[@publishMethod=`"MSDeploy`"]/@userName").value
$password = $xml.SelectNodes("//publishProfile[@publishMethod=`"MSDeploy`"]/@userPWD").value

# Set git remote
git remote add azure https://${username}:$password@$webappname.scm.azurewebsites.net:443/$webappname.git

# Push your code to the new Azure remote
git push azure master



repoUrl="https://github.com/dwayneh01/flask.git"
isLinux="true"
branch="main"