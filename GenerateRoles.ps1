# requires ConvertTo-Yaml function available via https://github.com/Phil-Factor/PSYaml
# Iterates through user databases and scripts role membership to a yaml format creating a folder for each db

# Deal with the normal issue of using SMO
Add-Type -path `
"C:\Windows\assembly\GAC_MSIL\Microsoft.SqlServer.Smo\14.0.0.0__89845dcd8080cc91\Microsoft.SqlServer.Smo.dll"

Import-Module psyaml
$targetPath = 'c:\temp\'

$SQLSvr = "."
$MySQLObject = new-object Microsoft.SqlServer.Management.Smo.Server $SQLSvr;

foreach ($db in $MySQLObject.Databases | where-object {$_.isSystemObject -eq $False})
{
    $roles = $MySQLObject.Databases["$($db.name)"].Roles
    
    $dbPermObj = @{}
    foreach ($role in $roles)
    {
        if ($role.EnumMembers().count -gt 0)
        {
            $memberObj = @() 
            foreach ($member in $Role.EnumMembers())
            {
               $memberObj += $member
            }
            $roleObj = @{ 
                "$($Role.Name)" = @{
                "members" = $memberObj 
                }
            }
            $dbPermObj += $roleObj
        }
    }
    
    $fullObj = @{
        "$($db.name)" = $dbPermObj
        }

    New-Item -ItemType directory -Path "$($targetPath)$($db.name)" 
    $fullObj | ConvertTo-Yaml | Out-File -FilePath "$($targetPath)$($db.name)\permissions.yaml"
}

