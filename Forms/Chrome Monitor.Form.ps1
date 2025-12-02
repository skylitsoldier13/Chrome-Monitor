Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Script:ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
#$Script:FormsRoot  = "$Script:ScriptPath\Forms"

$Designer = Join-Path $Script:ScriptPath "Chrome Monitor.Form.Designer.ps1"
#$Events

. $Designer

return $F_Form