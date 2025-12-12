Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Script:ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

$Designer = Join-Path $Script:ScriptPath "Chrome Monitor.Form.Designer.ps1"
$Events = Join-Path $Script:ScriptPath "chrome monitor.form.events.ps1"

. $Designer

. $Events

return $F_Form