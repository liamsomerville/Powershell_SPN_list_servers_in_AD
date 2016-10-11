Function Getdetails{
$spns = @{}
$filter = "(servicePrincipalName=$serviceType/*)"
$domain = New-Object System.DirectoryServices.DirectoryEntry
$searcher = New-Object System.DirectoryServices.DirectorySearcher
$searcher.SearchRoot = $domain
$searcher.PageSize = 1000
$searcher.Filter = $filter
$results = $searcher.FindAll()
 
foreach ($result in $results){
  $account = $result.GetDirectoryEntry()
  foreach ($spn in $account.servicePrincipalName.Value){
   if($spn.contains("$serviceType/")){
    $spns[$("$spn`t$($account.samAccountName)")]=1;
   }
  }
}
$spns.keys
}
 
 
#GC = Global Catalog, tapinego Associated with routing applications such as Microsoft firewalls (ISA, TMG, etc)
#CESREMOTE = citrix VDI
$array = @("HTTP", "DNS", "SMTPSVC", "MSSQLSvc", "GC", "ldap", "vnc", "nfs", "CESREMOTE", "POP", "IMAP", "SMTP")
#$array = @("iisadmin")
foreach ($element in $array) {
      
    $serviceType=$element
    write-host ""
    write-host ""
    write-host "======================"
    write-host "        $serviceType"
    write-host "======================"
    write-host ""
   
    Getdetails
}
 
 
