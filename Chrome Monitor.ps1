#Chrome Monitor V2
Clear-Host

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

if ($PSScriptRoot){
    $Script:BasePath = $PSScriptRoot
}else{
    $Script:BasePath = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
}

$dashboardUrl = "http://192.168.209.51/FTVP/ViewPoint.aspx?raml=01%20SHOPVIEW&area=/"

$Script:FormPath = "$Script:BasePath\Forms"
$F_Form = . (Join-Path $Script:FormPath "Chrome Monitor.Form.ps1")



$F_Form.Text = "Chrome Monitor - $env:COMPUTERNAME"
$Script:MemoryThreshold = 450



$F_TMR_LoopTime.Add_Tick({

    $chromeProcesses = Get-Process chrome -ErrorAction SilentlyContinue
    if (!$chromeProcesses){
        $F_LBL_CurrentUsage.Text = "N/A"
    } else {
        #$TodaysDate = (get-date).ToString("yyyyMMdd HH-mm-ss")
        $totalMem = ($chromeProcesses | Measure-Object WorkingSet64 -Sum).Sum / 1MB
        $CleanTotalMem = ($totalMem -split '\.' )[0]
        $F_LBL_CurrentUsage.Text = "$CleanTotalMem MB"
    }
    
<#
    if (!$chromeProcesses) {
        #SessionCleanup
        OpenChrome
        $FileName = "Chrome Not Running - $TodaysDate.txt"
        New-Item -Path "$ErrorLogPath\$FileName" -ItemType "File"
    } else {
        $totalMem = ($chromeProcesses | Measure-Object WorkingSet64 -Sum).Sum / 1MB
        if ($totalMem -gt $Script:MemoryThreshold) {
            Stop-Process -Name chrome -Force
            $FileName = "Chrome Out of Memory - $TodaysDate.txt"
            New-Item -Path "$ErrorLogPath\$FileName" -ItemType "File"
            Add-Content -Path $ErrorLogPath\$FileName -Value "Chrome is using too much memory ($([math]::Round($totalMem)) MB) \ $maxMemoryMB. Restarting..."
            SessionCleanup 
            OpenChrome
        }
    } #>
})



$F_Form.ShowDialog() | Out-Null

$F_TMR_LoopTime.Dispose()