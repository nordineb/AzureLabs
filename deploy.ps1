#Requires -Version 3.0
#Requires -Module AzureRM.Resources
#Requires -Module Azure.Storage

Param(
    [string]  [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $ResourceGroupLocation = "west europe",    
    [string] $TemplateFile = 'azuredeploy.json',
    [string] $TemplateParametersFile = 'azuredeploy.parameters.json'
)

$OptionalParameters = New-Object -TypeName Hashtable
#Set-Variable ArtifactsLocationName '_artifactsLocation' -Option ReadOnly -Force
#Set-Variable ArtifactsLocationSasTokenName '_artifactsLocationSasToken' -Option ReadOnly -Force
#$OptionalParameters.Add($ArtifactsLocationName, $null)
#$OptionalParameters.Add($ArtifactsLocationSasTokenName, $null)

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force -ErrorAction Stop 
New-AzureRmResourceGroupDeployment -Name ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')) `
                                   -ResourceGroupName $ResourceGroupName `
                                   -TemplateFile $TemplateFile `
                                   -TemplateParameterFile $TemplateParametersFile `
                                   @OptionalParameters `
                                   -Force -Verbose