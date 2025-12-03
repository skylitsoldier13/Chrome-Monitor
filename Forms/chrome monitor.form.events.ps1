$F_CB_SetThreshold.Add_SelectedIndexChanged({
    $Script:MemoryThreshold = $F_CB_SetThreshold.SelectedItem
    $F_LBL_CurrentMemory.text = $Script:MemoryThreshold
    $F_CB_SetThreshold.Text = [System.String]'Set Threshold'
})