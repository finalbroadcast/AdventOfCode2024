$LeftList = New-Object -TypeName "System.Collections.ArrayList"
$RightList = New-Object -TypeName "System.Collections.ArrayList"
$TotalDistance = 0
$LocationLists = Get-Content "H:\My_Workspace\Powershell-Scripts\Advent of Code 2024\Day01-Input1.txt"
forEach ($Location in $LocationLists){
    $LocationSet = $Location.Split(' ')
    $LeftList.Add([int]($LocationSet[0]))
    $RightList.Add([int]($LocationSet[-1]))
}
$SortedLeft = $LeftList | Sort-Object
$SortedRight = $RightList | Sort-Object
$stepCount = 0
forEach($item in $SortedLeft){
    
    if($item -gt $SortedRight[$StepCount]){
        $thisDistance = $item - $SortedRight[$StepCount]
    }
    else{
        $thisDistance = $SortedRight[$StepCount] - $item 
    }
    $TotalDistance += $thisDistance
    $StepCount++
}
Write-Output "The total distance from this list is $totalDistance"
