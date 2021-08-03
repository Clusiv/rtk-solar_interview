$ADUsers = Import-csv C:\scripts\newusers.csv
$ADComputers = Import-csv C:\scripts\newcomputers.csv

foreach ($User in $ADUsers)
{

    $Name    = $User.Name
    $SamAccountName    = $User.SamAccountName
    $UserPrincipalName   = $User.UserPrincipalName
    $DisplayName    = $User.DisplayName
    $GivenName = $User.GivenName
    $Surname           = $User.Surname
    $OfficePhone           = $User.OfficePhone
    $EmailAddress           = $User.EmailAddress
    $Title           = $User.Title
    $City           = $User.City
    $Country           = $User.Country
    $Company           = $User.Company
    $AccountPassword           = $User.AccountPassword
    $OU = $User.OU # or just OU=UserAccounts,DC=DOMAIN,DC=COM

    if (Get-ADUser -F {SamAccountName -eq $Username})
    {
            Write-Warning "A user account $Username has already exist in Active Directory."
    }
    else
    {
        New-ADUser `
        -Name "$Firstname $Lastname" `
        -SamAccountName $SamAccountName `
        -UserPrincipalName "$SamAccountName@yourdomain.com" `
        -DisplayName "$Lastname, $Firstname" `
        -GivenName $Firstname `
        -Surname $Lastname `
        -OfficePhone $OfficePhone `
        -EmailAddress $EmailAddress ` # or "$SamAccountName@yourdomain.com"
        -Title $Title `
        -City $City `
        -Country $Country `
        -Company $Company `
        -AccountPassword $AccountPassword `
        -ChangePasswordAtLogon $True `
        -Enabled $True `
        -Path $OU `
        -AccountPassword (convertto-securestring $Password -AsPlainText -Force)
       }
}

foreach ($Computer in $ADComputers) {

    $Name    = $Computer.Name
    $DNSHostName    = $Computer.DNSHostName

    if (Get-ADUser -F {Name -eq $Name})
    {
            Write-Warning "A user account $Username has already exist in Active Directory."
    }
    else
    {
        New-ADUser `
        -Name $Name `
        -DNSHostName $DNSHostName
        -Enabled $True `
        -Path $OU `
    }
}