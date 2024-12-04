$DangerousCount = 0
$SafeCount = 0
$SafetyReports = Get-Content "H:\My_Workspace\Powershell-Scripts\Advent of Code 2024\Day02-Input.txt"
forEach($report in $SafetyReports){
    $thisCheck = New-Object System.Collections.ArrayList
    foreach($element in $report.Split(' ')){$thisCheck.add($element)}
    $thisState = $null
    $Dampener = 0
    for($i=0;$i -le $($thisCheck.Count-1);$i++){
        if($Dampener -gt 1){
            $DangerousCount++
            Write-Host "Dampener used more than once, $thisCheck is Dangerous"
            Break
        }
        if($i -eq $thisCheck.Count-1){
            $SafeCount++
            Write-Host "$thisCheck is Safe"
            Break
        }
        $CheckResult = $thisCheck[$i] - $thisCheck[$i+1]
        Write-Host "Change is $CheckResult"
        switch($CheckResult){
        {$_ -eq 0}{
            $Dampener++
            Write-Host "No change, $thisCheck is using Dampener"
            $thisCheck.RemoveAt($i+1)
            $i--
            Break
        }
        {$_ -lt -3}{
            $Dampener++
            Write-Host "Change is greater than 3, $thisCheck is using Dampener"
            $thisCheck.RemoveAt($i+1)
            $i--
            Break
        }
        {$_ -gt 3}{
            $Dampener++
            Write-Host "Change is greater than 3, $thisCheck is using Dampener"
            $thisCheck.RemoveAt($i+1)
            $i--
            Break
        }
        {$_ -le -1 -and $_ -ge -3}{
            if($null -eq $thisState){
                $thisState = "Increasing"
                Break
            }
            if($thisState -eq "Decreasing"){
                $Dampener++
                Write-Host "Was decreasing now increasing, $thisCheck is using Dampener"
                $thisCheck.RemoveAt($i+1)
                $i--
                Break
            }
            else{
                Break
            }
        }
        {$_ -ge 1 -and $_ -le 3}{
            if($null -eq $thisState){
                $thisState = "Decreasing"
                Break
            }
            if($thisState -eq "Increasing"){
                $Dampener++
                Write-Host "Was Increasing now decreasing, $thisCheck is using Dampener"
                $thisCheck.RemoveAt($i+1)
                $i--
                Break
            }
            else{
                Break
            }
        }
        }
     }
    
}
if($DangerousCount + $SafeCount -eq $SafetyReports.Count){
    Write-output "Out of $($SafetyReports.Count) there are $DangerousCount dangerous reports and $SafeCount safe reports"
}
else{
    Write-Error "$DangerousCount dangerous reports and $SafeCount do not equal $($SafetyReports.Count)"
}
