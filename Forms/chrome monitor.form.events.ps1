$F_CB_SetMaxMemory.Add_SelectedIndexChanged({
    $Script:MaxMemory = $F_CB_SetMaxMemory.SelectedItem
    $F_LBL_CurrentMaxMemory.text = $Script:MaxMemory

    $MemorySave = @{
        Attribute = "Saved Memory Threshold"
        Memory = $Script:MaxMemory
    }

    $MemorySave | ConvertTo-Json | Out-File $Script:SavePath -Encoding utf8
})