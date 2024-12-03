$DangerousCount = 0
$SafeCount = 0
$SafetyReports = Get-Content "H:\My_Workspace\Powershell-Scripts\Advent of Code 2024\Day02-Input.txt"
forEach($report in $SafetyReports){
   $thisCheck = $report.Split(' ')
   $thisState = $null
   for($i=0;$i -le $($thisCheck.Length-1);$i++){
        if($i -eq $thisCheck.Length-1){
            $SafeCount++
            Write-Host "$thisCheck is Safe"
            Break
        }
        $CheckResult = $thisCheck[$i] - $thisCheck[$i+1]
        Write-Host "Change is $CheckResult"
        if(($CheckResult -lt -3) -or ($CheckResult -gt 3)){
            $DangerousCount ++
            Write-Host "Change is greater than 3, $thisCheck is Dangerous"
            Break
        }
        if($CheckResult -eq 0){
            $DangerousCount ++
            Write-Host "No change, $thisCheck is Dangerous"
            Break
        }
        if(($null -eq $thisState) -and ($CheckResult -ge 1)){
            $thisState = "Increasing"
        }
        if(($null -eq $thisState) -and ($CheckResult -le -1)){
            $thisState = "Decreasing"
        }
        if(($i -ne 0) -and ("Decreasing" -eq $thisState) -and ($CheckResult -ge 1)){
            $DangerousCount ++
            Write-Host "Was decreasing now increasing, $thisCheck is Dangerous"
            Break
        }
        if(($i -ne 0) -and ("Increasing" -eq $thisState) -and ($CheckResult -le -1)){
            $DangerousCount ++
            Write-Host "Was increasing now decreasing, $thisCheck is Dangerous"
            Break
        }
    }
    
}
if($DangerousCount + $SafeCount -eq $SafetyReports.Count){
    Write-output "Out of $($SafetyReports.Count) there are $DangerousCount dangerous reports and $SafeCount safe reports"
}
else{
    Write-Error "$DangerousCount dangerous reports and $SafeCount do not equal $SafetyReports.Count"
}
