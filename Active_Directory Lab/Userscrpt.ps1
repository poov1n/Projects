# ----- Edit these Variables for your own Use Case ----- #
$Password   = "User"
$User_list = Get-Content C:\Users\Administrator\Desktop\names.txt
# ------------------------------------------------------ #

$password = ConvertTo-SecureString $Password -AsPlainText -Force
New-ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $True

foreach ($i in $User_list) {
    $first = $i.Split(" ")[0].ToLower()
    $last = $i.Split(" ")[1].ToLower()
    $username = "$($first)$($last)".ToLower()
    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Yellow
    
    New-AdUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $username `
               -Name $username `
               -EmployeeID $username `
               -PasswordNeverExpires $true `
               -Path "ou=_USERS,$(([ADSI]`"").distinguishedName)" `
               -Enabled $true
}
