# Shutdown.ps1 V1.2
# Hier bitte den Namen des vcenter ersetzen
Connect-VIServer roevc004

$RESPOOL = get-resourcepool TMP
Write-Host $RESPOOL

# Jede VM innerhalb des Ressourcepools "smooth" herunterfahren
$ESXSRV = Get-VMHost
Foreach ($VM in ($RESPOOL | Get-VM | Where { $_.PowerState -eq "poweredOn" })){
    $VM | Suspend-VMGuest -Confirm:$false
}
 
# Shutdown Zeit Vorlauf in Sekunden
Write-Host "Sleeping ..."
Start-Sleep -s 5

    
# Hartes ausschalten, falls Shutdown nicht klappt 
Foreach ($VM in ($RESPOOL | Get-VM | Where { $_.PowerState -eq "poweredOn" })){
        $VM | Stop-VM -Confirm:$false
}
 
Write-Host "Shutdown Complete"
