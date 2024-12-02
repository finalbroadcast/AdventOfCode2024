$LeftList = New-Object -TypeName "System.Collections.ArrayList"
$RightList = New-Object -TypeName "System.Collections.ArrayList"
$SimilarityScore = 0
$LocationLists = Get-Content "H:\My_Workspace\Powershell-Scripts\Advent of Code 2024\Day01-Input1.txt"
forEach ($Location in $LocationLists){
    $LocationSet = $Location.Split(' ')
    $LeftList.Add([int]($LocationSet[0]))
    $RightList.Add([int]($LocationSet[-1]))
}
forEach($item in $LeftList){
    $OccuranceCount = 0
    $lastOne = $RightList.LastIndexOf($item)
    if($LastOne  -eq -1 ){
        $ThisSimilarity = 0
    }
    else{
        do{
            if($item -eq $RightList[$LastOne]){
                $OccuranceCount++
            }
            $LastOne--
        }
        while ($lastOne -gt -1)
        $ThisSimilarity = $item * $OccuranceCount
    }
    $SimilarityScore += $ThisSimilarity
}
Write-Output "Final similarity score is $SimilarityScore"
