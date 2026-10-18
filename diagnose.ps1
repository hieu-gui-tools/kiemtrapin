Write-Host "=== THONG TIN PIN ==="
Get-CimInstance Win32_Battery | Select-Object Name, DeviceID, EstimatedChargeRemaining, BatteryStatus | Format-List

Write-Host "=== CHE DO NGUON (POWER STATES) ==="
powercfg /a

Write-Host "=== KERNEL-POWER EVENT 41 ==="
$events = Get-WinEvent -FilterHashtable @{LogName="System"; ProviderName="Microsoft-Windows-Kernel-Power"; Id=41} -MaxEvents 10
$results = @()
foreach ($e in $events) {
    $x = [xml]$e.ToXml()
    $nodes = $x.Event.EventData.Data
    $bc = ""
    $pb = ""
    foreach ($n in $nodes) {
        if ($n.Name -eq "BugcheckCode") { $bc = $n."#text" }
        if ($n.Name -eq "PowerButtonTimestamp") { $pb = $n."#text" }
    }
    $results += [PSCustomObject]@{
        Time = $e.TimeCreated
        BugcheckCode = $bc
        ForcedPowerButton = ($pb -ne "0" -and $pb -ne "")
    }
}
$results | Format-Table -AutoSize

Write-Host "=== MINIDUMP ==="
Get-ChildItem -Path "C:\Windows\Minidump" -ErrorAction SilentlyContinue | Select-Object Name, Length, LastWriteTime | Format-Table
