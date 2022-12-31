

Write-Host "  "

Write-Host "Please select from the below options"
Write-Host " A) Do you want to collect a new Baseline ?"
Write-Host " B) Do you want to check files with saved baseline?"

Write-Host "  "

$response = Read-Host -prompt "Please enter 'A' or 'B'. "

Write-Host "  "

Write-Host "You have selected" $response

Write-Host " "
Write-Host " Please wait ... "
Start-Sleep -Seconds 2



# Creating a function to calculate the hash file

Function calc-file-hash($filepath) { 

# Function will go to the file path, calculate the hash value and returns it

    $Hash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $Hash



}

#Creating a function to clear the text file if exists


function file-if-exists(){
    $fileexists = Test-Path -Path D:\Desktop\FIM\baseline.txt
    
    if ($fileexists){
                                                                              #Remove file if exists
        Remove-Item -Path D:\Desktop\FIM\baseline.txt
        
}

}

if ($response -eq "A".ToUpper()){                                             #Calculate the hash and store it in baseline.txt

        file-if-exists                                                        #Delete file if exists
        
        $files = Get-ChildItem -Path D:\Desktop\FIM\Files                     # Collect all the files from the path

        foreach ($item in $files)                                             # For each item in files, we calculate the hash and store in Baseline.txt
        {
        
           $file_hashes = calc-file-hash $item.FullName
           "$($file_hashes.Path)|$($file_hashes.Hash)"| Out-File -FilePath D:\Desktop\FIM\baseline.txt -Append
        
        }

        Write-Host " New baseline collected" -ForegroundColor Yellow
        
    
    
    
}

elseif ($response -eq "B".ToUpper()) { 
    $hash_dictionary = @{}                                          #Create an empty dictionary
                            #Add two columns here

#Load hash from baseline.txt and store in a dictionary
    $filepath_and_hashes = Get-Content -Path D:\Desktop\FIM\baseline.txt
    
    foreach ($items in $filepath_and_hashes){
    
#Split the items into two at the | section and it will create an Array, where it stores 0th element to one and 1st element to other

        $hash_dictionary.Add($items.Split("|")[0],($items.Split("|")[1]))  

    }

# While loop to continuously monitor files with the saved baseline
    while ($true){
    
        Start-Sleep -Seconds 1

        $files = Get-ChildItem -Path D:\Desktop\FIM\Files                     # Collect all the files from the path

        foreach ($item in $files) {                                             # For each item in files, we calculate the hash and store in Baseline.txt
        
           $file_hashes = calc-file-hash $item.FullName

            #A file has been created !! Notify            
           if ($hash_dictionary[$file_hashes.Path] -eq $null) {

                Write-Host "$($file_hashes.Path) has been created !!" -ForegroundColor Green
           
            }

            else{
            #Hashes of file are equal

                if ($hash_dictionary[$file_hashes.Path] -eq $file_hashes.Hash){

                    #Write-Host " $($file_hashes.Path)has not changed "
            
                }
                else {
            
                    Write-Host "$($file_hashes.Path) has been changed !! " -ForegroundColor Red 
            
                }
            }
           
           foreach ($key in $hash_dictionary.keys){
           
            $file_exists= Test-Path -Path $key
                if (-Not $file_exists){
                    Write-Host "$($key) has been deleted" -ForegroundColor DarkRed -BackgroundColor white

                }
           
           }

        }
    }

}

else {
        Write-Host "Invalid Entry, Please try again"
}
