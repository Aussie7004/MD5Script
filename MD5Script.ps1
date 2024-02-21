function GetHash {
#Neutralises variable for check without error
    $FilePath = ""
    $FilePath = Read-Host "Please enter a filepath: "

    if (!$FilePath) {

        Write-Output "`n`nPath cannot be empty.`n`n"
        GetHash
    }

    #Validates filepath
    $Validity = Test-Path -Path $FilePath -PathType Leaf
    $Md5Value = ""
    
    #Verifies path
    if ($Validity -eq $true) {
        $Md5Value = Get-FileHash $FilePath -Algorithm MD5
        Write-Output "`n`n" + $Md5Value + "`n`n"
    }

    elseif ($Validity -eq $false) {
        
        while ($Validity -eq $false) {
            $FilePath = Read-Host "Please enter a valid filepath: "
            $Validity = Test-Path -Path $FilePath -PathType Leaf
            if ($Validity -eq $true) {
                $Md5Value = Get-FileHash $FilePath -Algorithm MD5
                Write-Output "`n`n" + $Md5Value + "`n`n"
            }
    
        }
        
    }



}

function main() {
    $Today = (Get-Date).DateTime

    $Today

    #infinite loop for efficiency 
    while ($true) {
        GetHash
        #creates function and edits default pause message and waits for host to decide what they want to do instead of "enter to continue"
        function pause { $null = Read-Host 'Press Enter to continue or Ctrl+C to quit' } 
        Pause
    }
}


main
