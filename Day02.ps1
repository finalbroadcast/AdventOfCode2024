$SafetyInput = Get-Content "AdventOfCode2024/Day02input.txt"
$DangerousCount = 0
$SafeCount = 0
function Check-Safety{
    param(
        [int] $val1,
        [int] $val2,
        [String] $Direction = ""
    )
    $CheckedValue = $val1 - $val2
    $DangerStatus = 0
    $FlowDanger = 1 
    $JumpDanger = 1
    if($checkedValue -eq 0){
        $DangerStatus = 1
        $CheckResults = [PSCustomObject]@{
            DangerStatus = $DangerStatus
            Direction = $Direction
        }
        Return $CheckResults
    }
    if($direction -eq ""){
        $FlowDanger = 0
        if($checkedValue -lt 0){
            $Direction = "Increasing"
        }
        elseif($checkedValue -gt 0){
            $Direction = "Decreasing"
        }  
    }
    if($Direction -eq "Increasing" -and ($CheckedValue -gt 0)){
        $flowDanger = 1
    }
    elseif ($Direction -eq "Decreasing" -and ($CheckedValue -lt 0)){
        $FlowDanger = 1
    }
    else{
        $FlowDanger = 0
    }
    if((($CheckedValue -le 3) -and ($CheckedValue -gt 0)) -or (($CheckedValue -ge -3) -and ($CheckedValue -lt 0)))
    {
        $JumpDanger = 0    
    }
    elseIf($checkedValue -ge 4 -or $checkedValue -le -4){
        $JumpDanger = 1
        }
    if($JumpDanger -eq 1 -or $FlowDanger -eq 1){
        $DangerStatus = 1
        $CheckResults = [PSCustomObject]@{
            DangerStatus = $DangerStatus
            Direction = $Direction
        }
        Return $CheckResults
    }
    else{
        $DangerStatus = 0
        $CheckResults = [PSCustomObject]@{
            DangerStatus = $DangerStatus
            Direction = $Direction
        }
        Return $CheckResults
    }
    }

forEach($check in $SafetyInput){
    $thisCheck = New-Object System.Collections.ArrayList
    $thisDanger = 0
    $thisDirection = ""
    foreach($element in $check.Split(' ')){$thisCheck.add($element)}
    for($i =0;$i -le $($thisCheck.count -1);$i++){
        if($thisDanger -eq 1){
            Write-Host "$thisCheck not safe"
            $DangerousCount++
            Break
        }
        if($i -eq $($thisCheck.Count-1)){
            Write-Host "$thisCheck is safe"
            $SafeCount++
            Break
        }
        if(($i -eq 0) -and ($thisDirection -eq "") ){
            $Result = Check-Safety -val1 $thisCheck[$i] -val2 $thisCheck[$i+1]
        }
        else{
            $Result = Check-Safety -val1 $thisCheck[$i] -val2 $thisCheck[$i+1] -Direction $thisDirection
        }
        $thisDanger = $Result.DangerStatus
        $thisDirection = $Result.Direction
    }
}
if($DangerousCount + $SafeCount -ne $SafetyInput.Count){
    Write-Error "$DangerousCount + $SafeCount  do not equal $($SafetyInput.Count) check code"
}
else{
    Write-Output "There are $DangerousCount dangerous checks and $Safecount safe checks."
}
