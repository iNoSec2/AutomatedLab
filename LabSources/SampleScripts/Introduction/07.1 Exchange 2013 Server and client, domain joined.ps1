#The is almost the same like '05 SQL Server and client, domain joined.ps1' but installs an Exchange 2013 server instead
#of a SQL Server.
#
# IMPORTANT NOTE: The Exchange 2013 bits are downloaded automatically and stored into LabSources\SoftwarePackages
# The link to the Exchange bits is stored in the AutomatedLab.psd1 file.

New-LabDefinition -Name LabEx2013 -DefaultVirtualizationEngine HyperV

#defining default parameter values, as these ones are the same for all the machines
$PSDefaultParameterValues = @{
    'Add-LabMachineDefinition:DomainName' = 'contoso.com'
    'Add-LabMachineDefinition:OperatingSystem' = 'Windows Server 2012 R2 Datacenter (Server with a GUI)'
}

Add-LabMachineDefinition -Name Ex2013DC1 -Roles RootDC -Memory 1GB

$role = Get-LabPostInstallationActivity -CustomRole Exchange2013 -Properties @{ OrganizationName = 'Test1' }
Add-LabMachineDefinition -Name Ex2013EX1 -Memory 4GB -PostInstallationActivity $role

Add-LabMachineDefinition -Name Ex2013Client1 -OperatingSystem 'Windows 10 Pro' -Memory 1GB

Install-Lab

Show-LabDeploymentSummary
