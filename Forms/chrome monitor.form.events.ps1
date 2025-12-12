$F_CB_SetMaxMemory.Add_SelectedIndexChanged({
    $Script:MaxMemory = $F_CB_SetMaxMemory.SelectedItem
    $F_LBL_CurrentMaxMemory.text = $Script:MaxMemory

    $MemorySave = @{
        Attribute = "Saved Memory Threshold"
        Memory = $Script:MaxMemory
    }

    $MemorySave | ConvertTo-Json | Out-File $Script:SavePath -Encoding utf8
})

$F_BTN_TimeControl.Add_Click({
    if($F_TMR_Refresh.Enabled){
        $F_TMR_Refresh.Stop()
        $F_BTN_TimeControl.BackColor = [System.Drawing.Color]::PaleGreen
        $F_BTN_TimeControl.Text = "Start Timer"
    } else {
        $F_TMR_Refresh.Start()
        $F_BTN_TimeControl.BackColor = [System.Drawing.Color]::LightCoral
        $F_BTN_TimeControl.Text = "Stop Timer"
    }
})