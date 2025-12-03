#Chrome Monitor V2
Clear-Host

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

if ($PSScriptRoot){
    $Script:BasePath = $PSScriptRoot
}else{
    $Script:BasePath = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
}

$Script:LogPath = Join-Path $Script:BasePath "Logs"
$Script:DataPath = Join-Path $Script:BasePath "Data"
$Script:FormPath = Join-Path $Script:BasePath "Forms"

$chromePaths = @(
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    "C:\Program Files\Google\Chrome\Application\chrome.exe"
)

$ChromeProfile = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"

$chromePath = $chromePaths | Where-Object {Test-Path $_} |Select-Object -First 1

$Script:MaxMemory

        #--------------------------------------------------#
        # *~*~*~*~*~ Save System Initialization *~*~*~*~*~ #
        #--------------------------------------------------#

$Script:SavePath = "$Script:DataPath\Saved.json"


if (Test-Path $Script:SavePath){
    write-host "got save"
    $loaded = Get-Content -Raw $Script:SavePath | ConvertFrom-Json

    if($loaded){
        write-Host "Data found $($loaded.Memory)"

        $Script:SavedMemoryThreshold = @{
            Attribute = $loaded.Attribute
            Memory = $loaded.Memory
        }
    } else{
        write-host "couldnt find data in the file"
    }

    $Script:MaxMemory = $Script:SavedMemoryThreshold.Memory

} else {
    $Script:MaxMemory = 750
}

$dashboardUrl = "http://192.168.209.51/FTVP/ViewPoint.aspx?raml=01%20SHOPVIEW&area=/"


$F_Form = . (Join-Path $Script:FormPath "Chrome Monitor.Form.ps1")



$F_Form.Text = "Chrome Monitor - $env:COMPUTERNAME"
$F_LBL_CurrentMaxMemory.Text = "$Script:MaxMemory MB"



$F_TMR_LoopTime.Add_Tick({
    $Now = (get-date).ToString("yyyyMMdd HH-mm-ss")
    $chromeProcesses = Get-Process chrome -ErrorAction SilentlyContinue

    if (!$chromeProcesses){
        $F_LBL_CurrentUsage.Text = "N/A"
        SessionCleanup
        OpenChrome
        $FileName = "Chrome Not Running - $Now.txt"
        New-Item -Path "$Script:LogPath\$FileName" -ItemType "File"
    } else {
        $totalMem = ($chromeProcesses | Measure-Object WorkingSet64 -Sum).Sum / 1MB
        $CleanTotalMem = ($totalMem -split '\.' )[0]
        $F_LBL_CurrentUsage.Text = "$CleanTotalMem MB"

        if ($totalMem -gt $Script:MaxMemory) {
            Stop-Process -Name chrome -Force
            $FileName = "Chrome Out of Memory - $Now.txt"
            New-Item -Path "$Script:LogPath\$FileName" -ItemType "File"
            Add-Content -Path "$Script:LogPath\$FileName" -Value "Chrome is using too much memory ($([math]::Round($totalMem)) MB) \ $maxMemoryMB. Restarting..."
            SessionCleanup 
            OpenChrome
        }
    }
})

function SessionCleanup {
    $PastSessions = @(
        "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Local State"
        "$ChromeProfile\Sessions\*",
        "$ChromeProfile\Session Storage\*",
        "$ChromeProfile\Last Session",
        "$ChromeProfile\Last Tabs",
        "$ChromeProfile\Current Session",
        "$ChromeProfile\Current Tabs",
        "$ChromeProfile\Preferences",
        "$ChromeProfile\Local State"
        )
    foreach ($path in $PastSessions) {
        Remove-Item $path -ErrorAction SilentlyContinue -Force
    }
}

function OpenChrome {

    Start-Process $chromePath "--start-fullscreen $dashboardUrl --noerrdialogs --disable-session-crashed-bubble --disable-infobars --no-first-run"
    Start-Sleep -Seconds 2

    Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class FocusWindow {
        [DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
        [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
 }
"@
    $chrome = Get-Process chrome -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($chrome) {
            [FocusWindow]::ShowWindowAsync($chrome.MainWindowHandle, 3) # 3 = SW_MAXIMIZE
            [FocusWindow]::SetForegroundWindow($chrome.MainWindowHandle)
        }
}



$F_Form.ShowDialog() | Out-Null

$F_TMR_LoopTime.Dispose()