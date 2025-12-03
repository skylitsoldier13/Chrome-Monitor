$F_Form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Label]$FNI_LBL_MemorySettings = $null
[System.Windows.Forms.Label]$FNI_LBL_CurrentSetting = $null
[System.Windows.Forms.Panel]$Panel1 = $null
[System.Windows.Forms.Label]$F_LBL_CurrentUsage = $null
[System.Windows.Forms.Label]$FNI_LBL_CurrentUsage = $null
[System.Windows.Forms.Label]$FNI_LBL_ChangeMax = $null
[System.Windows.Forms.Label]$F_LBL_CurrentMaxMemory = $null
[System.Windows.Forms.ComboBox]$F_CB_SetMaxMemory = $null
[System.Windows.Forms.Timer]$F_TMR_LoopTime = $null
[System.ComponentModel.IContainer]$components = $null
function InitializeComponent
{
$components = (New-Object -TypeName System.ComponentModel.Container)
$FNI_LBL_MemorySettings = (New-Object -TypeName System.Windows.Forms.Label)
$FNI_LBL_CurrentSetting = (New-Object -TypeName System.Windows.Forms.Label)
$Panel1 = (New-Object -TypeName System.Windows.Forms.Panel)
$F_LBL_CurrentUsage = (New-Object -TypeName System.Windows.Forms.Label)
$FNI_LBL_CurrentUsage = (New-Object -TypeName System.Windows.Forms.Label)
$FNI_LBL_ChangeMax = (New-Object -TypeName System.Windows.Forms.Label)
$F_LBL_CurrentMaxMemory = (New-Object -TypeName System.Windows.Forms.Label)
$F_CB_SetMaxMemory = (New-Object -TypeName System.Windows.Forms.ComboBox)
$F_TMR_LoopTime = (New-Object -TypeName System.Windows.Forms.Timer -ArgumentList @($components))
$Panel1.SuspendLayout()
$F_Form.SuspendLayout()
#
#FNI_LBL_MemorySettings
#
$FNI_LBL_MemorySettings.BackColor = [System.Drawing.SystemColors]::ControlLightLight
$FNI_LBL_MemorySettings.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]8.25,([System.Drawing.FontStyle][System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline),[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$FNI_LBL_MemorySettings.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]0))
$FNI_LBL_MemorySettings.Name = [System.String]'FNI_LBL_MemorySettings'
$FNI_LBL_MemorySettings.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]136,[System.Int32]17))
$FNI_LBL_MemorySettings.TabIndex = [System.Int32]0
$FNI_LBL_MemorySettings.Text = [System.String]'Memory Settings (MB)'
$FNI_LBL_MemorySettings.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#FNI_LBL_CurrentSetting
#
$FNI_LBL_CurrentSetting.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]13,[System.Int32]17))
$FNI_LBL_CurrentSetting.Name = [System.String]'FNI_LBL_CurrentSetting'
$FNI_LBL_CurrentSetting.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]116,[System.Int32]17))
$FNI_LBL_CurrentSetting.TabIndex = [System.Int32]1
$FNI_LBL_CurrentSetting.Text = [System.String]'Current Max Setting'
$FNI_LBL_CurrentSetting.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#Panel1
#
$Panel1.BackColor = [System.Drawing.SystemColors]::ControlLightLight
$Panel1.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
$Panel1.Controls.Add($F_LBL_CurrentUsage)
$Panel1.Controls.Add($FNI_LBL_CurrentUsage)
$Panel1.Controls.Add($FNI_LBL_ChangeMax)
$Panel1.Controls.Add($F_LBL_CurrentMaxMemory)
$Panel1.Controls.Add($FNI_LBL_CurrentSetting)
$Panel1.Controls.Add($FNI_LBL_MemorySettings)
$Panel1.Controls.Add($F_CB_SetMaxMemory)
$Panel1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]12))
$Panel1.Name = [System.String]'Panel1'
$Panel1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]143,[System.Int32]163))
$Panel1.TabIndex = [System.Int32]2
#
#F_LBL_CurrentUsage
#
$F_LBL_CurrentUsage.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]8.25,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$F_LBL_CurrentUsage.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]19,[System.Int32]80))
$F_LBL_CurrentUsage.Name = [System.String]'F_LBL_CurrentUsage'
$F_LBL_CurrentUsage.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]14))
$F_LBL_CurrentUsage.TabIndex = [System.Int32]5
$F_LBL_CurrentUsage.Text = [System.String]'#####'
$F_LBL_CurrentUsage.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#FNI_LBL_CurrentUsage
#
$FNI_LBL_CurrentUsage.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]19,[System.Int32]65))
$FNI_LBL_CurrentUsage.Name = [System.String]'FNI_LBL_CurrentUsage'
$FNI_LBL_CurrentUsage.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]15))
$FNI_LBL_CurrentUsage.TabIndex = [System.Int32]3
$FNI_LBL_CurrentUsage.Text = [System.String]'Current Usage'
$FNI_LBL_CurrentUsage.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#FNI_LBL_ChangeMax
#
$FNI_LBL_ChangeMax.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]13,[System.Int32]115))
$FNI_LBL_ChangeMax.Name = [System.String]'FNI_LBL_ChangeMax'
$FNI_LBL_ChangeMax.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]112,[System.Int32]17))
$FNI_LBL_ChangeMax.TabIndex = [System.Int32]4
$FNI_LBL_ChangeMax.Text = [System.String]'Change Max Setting'
$FNI_LBL_ChangeMax.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#F_LBL_CurrentMaxMemory
#
$F_LBL_CurrentMaxMemory.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]8.25,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$F_LBL_CurrentMaxMemory.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]19,[System.Int32]34))
$F_LBL_CurrentMaxMemory.Name = [System.String]'F_LBL_CurrentMaxMemory'
$F_LBL_CurrentMaxMemory.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]17))
$F_LBL_CurrentMaxMemory.TabIndex = [System.Int32]3
$F_LBL_CurrentMaxMemory.Text = [System.String]'#####'
$F_LBL_CurrentMaxMemory.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#F_CB_SetMaxMemory
#
$F_CB_SetMaxMemory.FormattingEnabled = $true
$F_CB_SetMaxMemory.Items.AddRange([System.Object[]]@([System.String]'500',[System.String]'550',[System.String]'600',[System.String]'650',[System.String]'700',[System.String]'750',[System.String]'800',[System.String]'850',[System.String]'900',[System.String]'950',[System.String]'1000',[System.String]'1050',[System.String]'1100',[System.String]'1150',[System.String]'1200'))
$F_CB_SetMaxMemory.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]135))
$F_CB_SetMaxMemory.MaxDropDownItems = [System.Int32]16
$F_CB_SetMaxMemory.Name = [System.String]'F_CB_SetMaxMemory'
$F_CB_SetMaxMemory.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]133,[System.Int32]21))
$F_CB_SetMaxMemory.TabIndex = [System.Int32]3
$F_CB_SetMaxMemory.Text = [System.String]'Set Memory Max'
#
#F_TMR_LoopTime
#
$F_TMR_LoopTime.Enabled = $true
$F_TMR_LoopTime.Interval = [System.Int32]5000
#
#F_Form
#
$F_Form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]562,[System.Int32]187))
$F_Form.Controls.Add($Panel1)
$F_Form.Text = [System.String]'###'
$Panel1.ResumeLayout($false)
$F_Form.ResumeLayout($false)
Add-Member -InputObject $F_Form -Name FNI_LBL_MemorySettings -Value $FNI_LBL_MemorySettings -MemberType NoteProperty
Add-Member -InputObject $F_Form -Name FNI_LBL_CurrentSetting -Value $FNI_LBL_CurrentSetting -MemberType NoteProperty
Add-Member -InputObject $F_Form -Name Panel1 -Value $Panel1 -MemberType NoteProperty
Add-Member -InputObject $F_Form -Name F_LBL_CurrentUsage -Value $F_LBL_CurrentUsage -MemberType NoteProperty
Add-Member -InputObject $F_Form -Name FNI_LBL_CurrentUsage -Value $FNI_LBL_CurrentUsage -MemberType NoteProperty
Add-Member -InputObject $F_Form -Name FNI_LBL_ChangeMax -Value $FNI_LBL_ChangeMax -MemberType NoteProperty
Add-Member -InputObject $F_Form -Name F_LBL_CurrentMaxMemory -Value $F_LBL_CurrentMaxMemory -MemberType NoteProperty
Add-Member -InputObject $F_Form -Name F_CB_SetMaxMemory -Value $F_CB_SetMaxMemory -MemberType NoteProperty
Add-Member -InputObject $F_Form -Name F_TMR_LoopTime -Value $F_TMR_LoopTime -MemberType NoteProperty
Add-Member -InputObject $F_Form -Name components -Value $components -MemberType NoteProperty
}
. InitializeComponent
