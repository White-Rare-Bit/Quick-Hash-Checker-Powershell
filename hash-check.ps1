Add-Type -AssemblyName System.Windows.Forms

function Main{
    Get-Path
}

function Get-Path
{
    Clear-Host
    Write-Host "~~~ Quick File Hash! ~~~"
    $Path = Read-Host "Enter filepath to be hashed .\foobar.exe -OR- open the filebrowser by entering 'fb' -->"
    if($Path -eq 'fb'){
        $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
        $null = $FileBrowser.ShowDialog()
        $Path = $FileBrowser.FileName
        Algo-Menu
    }
    else{
        $validFile = Test-Path $Path -PathType Leaf
        if($validFile -eq $True){
            Algo-Menu
        }
        else{
            Write-Host "That file does not exist..."
            Pause
            Main
        }
    }
}

function Algo-Menu
{
  Clear-Host
  Write-Host "Using $Path"
  Write-Host "Select an algorithm type:"
  Write-Host "1: SHA-1"
  Write-Host "2: SHA-256"
  Write-Host "3: SHA-384"
  Write-Host "4: MD5"

 Do{
   $selection = Read-Host "Select an option -->"
   Switch($selection)
   {
    '1' { Hash("SHA1") }
    '2' { Hash("SHA256") }
    '3' { Hash("SHA384") }
    '4' { Hash("MD5") }
    Default {
        $UserChoice = Read-Host "Invalid selection... you can press 'q' to quit -OR- any other key to continue"
        if($UserChoice -eq 'q')
        {
            exit
        }
        else
        {
            Algo-Menu
        }
     }
   }
   pause
   }
 Until ($Selection)
}

function Hash($Algo)
{
    Write-Host "Calculating $Path with algorithm type $algo..."
    Get-FileHash $Path -Algorithm $Algo
    Write-Host ""
    pause
    exit
}

Main