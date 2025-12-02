#Chrome Monitor V2
Clear-Host

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

if ($PSScriptRoot){
    $Script:BasePath = $PSScriptRoot
}else{
    $Script:BasePath = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
}

$Script:FormPath = "$Script:BasePath\Forms"
$F_Form = . (Join-Path $Script:FormPath "Chrome Monitor.Form.ps1")

$F_Form.Text = "Chrome Monitor - $env:COMPUTERNAME"


$F_Form.ShowDialog() | Out-Null