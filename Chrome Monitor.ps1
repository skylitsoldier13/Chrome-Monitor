#Chrome Monitor V2
        #-------------------------------------#
        # *~*~*~*~*~ Initial setup *~*~*~*~*~ #
        #-------------------------------------#

Clear-Host

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$wshell = New-Object -ComObject wscript.shell

$Script:RefreshTime = 300
$Minutes = [System.Math]::Floor($Script:RefreshTime /60)
$Seconds = $Script:RefreshTime % 60
$TimeDisplay = "{0:N0}:{1:N0}" -f ($Minutes).ToString().PadLeft(2, '0'), ($Seconds).ToString().PadLeft(2, '0')


if ($PSScriptRoot){
    $Script:BasePath = $PSScriptRoot
}else{
    $Script:BasePath = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
}

        #-------------------------------------#
        # *~*~*~*~*~ Configuration *~*~*~*~*~ #
        #-------------------------------------#

$Script:LogPath = Join-Path $Script:BasePath "Logs"
$Script:DataPath = Join-Path $Script:BasePath "Data"
$Script:FormPath = Join-Path $Script:BasePath "Forms"


$chromePaths = @(
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    "C:\Program Files\Google\Chrome\Application\chrome.exe"
)

$ChromeProfile = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"

$dashboardUrl = "http://192.168.209.51/FTVP/ViewPoint.aspx?raml=01%20SHOPVIEW&area=/"





        #--------------------------------------------------#
        # *~*~*~*~*~ Save System Initialization *~*~*~*~*~ #
        #--------------------------------------------------#

$Script:SavePath = "$Script:DataPath\Saved.json"

if (Test-Path $Script:SavePath){
    $loaded = Get-Content -Raw $Script:SavePath | ConvertFrom-Json

    if($loaded){
        $Script:SavedMemoryThreshold = @{
            Attribute = $loaded.Attribute
            Memory = $loaded.Memory
        }
    } else{}
    $Script:MaxMemory = $Script:SavedMemoryThreshold.Memory

} else {
    $Script:MaxMemory = 750

    $MemorySave = @{
        Attribute = "Saved Memory Threshold"
        Memory = $Script:MaxMemory
    }

    $MemorySave | ConvertTo-Json | Out-File $Script:SavePath -Encoding utf8
    
}

        #----------------------------------------#
        # *~*~*~*~*~ GUI Form Loading *~*~*~*~*~ #
        #----------------------------------------#

$F_Form = . (Join-Path $Script:FormPath "Chrome Monitor.Form.ps1")



        #--------------------------------------------------#
        # *~*~*~*~*~ Pre-loop startup *~*~*~*~*~ #
        #--------------------------------------------------#

$F_FSW_UpdateWatcher.Path = $Script:DataPath

$F_Form.Text = "Chrome Monitor - $env:COMPUTERNAME"

$F_LBL_CurrentMaxMemory.Text = "$Script:MaxMemory MB"

$chromePath = $chromePaths | Where-Object {Test-Path $_} |Select-Object -First 1



        #----------------------------------------#
        # *~*~*~*~*~ Needed functions *~*~*~*~*~ #
        #----------------------------------------#

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

    Start-Process $chromePath "--start-fullscreen $dashboardUrl --noerrdialogs --disable-session-crashed-bubble --disable-infobars --no-first-run --remote-debugging-port=9222 --user-data-dir=C:\ChromeTempData"
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

        #---------------------------------#
        # *~*~*~*~*~ Main loop *~*~*~*~*~ #
        #---------------------------------#

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

#$StopWatch = [System.Diagnostics.Stopwatch]::StartNew()

$F_TMR_Refresh.Add_Tick({
    $Minutes = [System.Math]::Floor($Script:RefreshTime /60)
    $Seconds = $Script:RefreshTime % 60
    $TimeDisplay = "{0:N0}:{1:N0}" -f ($Minutes).ToString().PadLeft(2, '0'), ($Seconds).ToString().PadLeft(2, '0')
    $Script:RefreshTime--
    $F_LBL_TimeUntil.Text = $TimeDisplay
    if($Script:RefreshTime -eq 0){
        $wshell.SendKeys('{F5}')
        $Script:RefreshTime = 300
    }
})


$F_FSW_UpdateWatcher.SynchronizingObject = $F_Form
$F_FSW_UpdateWatcher.Add_Changed({
    Start-Sleep -Milliseconds 100
    if (Test-Path $Script:SavePath) {
        $forcedloaded = Get-Content -Raw $Script:SavePath | ConvertFrom-Json
        if ($forcedloaded) {
            $Script:SavedMemoryThreshold = @{
                Attribute = $forcedloaded.Attribute
                Memory    = $forcedloaded.Memory
            }
            $Script:MaxMemory = $Script:SavedMemoryThreshold.Memory
            $F_LBL_CurrentMaxMemory.Text = $Script:MaxMemory
        }
    }
})
$F_FSW_UpdateWatcher.EnableRaisingEvents = $true


        #------------------------------------#
        # *~*~*~*~*~ Form display *~*~*~*~*~ #
        #------------------------------------#
$F_Form.ShowDialog() | Out-Null



        #-------------------------------------#
        # *~*~*~*~*~ Timer cleanup *~*~*~*~*~ #
        #-------------------------------------#

$F_TMR_LoopTime.Dispose()
$F_TMR_Refresh.Dispose()
$EventSourceID = "UpdateWatcher"
Unregister-Event -SourceIdentifier $EventSourceId -ErrorAction SilentlyContinue
Get-Job | Where-Object {$_.Name -eq $EventSourceId} | Remove-Job -Force -ErrorAction SilentlyContinue
$F_FSW_UpdateWatcher.Dispose()