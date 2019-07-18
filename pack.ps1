#Set-Location "nuget-pack"

$CurrentPath = "$((Get-Location).Path)"

$AfactsPath = "$CurrentPath\artifacts"

if ( -Not (Test-Path -Path $AfactsPath ) ) {
    New-Item -ItemType directory -Path $AfactsPath
}
else {
    Remove-Item "$AfactsPath\*.nupkg"
}

class ProjectItem { 

    [string]$path
    [string]$name
    
    ProjectItem([string]$path, [string]$name) {
        $this.path = $path 
        $this.name = $name 
    }    
}

function BuildPackage($dir, $name) {     
    Set-Location $dir
    dotnet build -c Debug $name
    Remove-Item bin/Debug/*.nupkg
    dotnet pack -c Debug $name
    Copy-Item "bin/Debug/*.nupkg" $AfactsPath
}

[ProjectItem[]]$CodePaths = `
    [ProjectItem]::new("InfluxDB.Net", "InfluxDB.Net.Core.csproj") 

for ($i = 0; $i -lt $CodePaths.Count; $i++) {
    $codePath = $CodePaths[$i]
    BuildPackage -dir $codePath.path -name $codePath.name
    Set-Location $CurrentPath
}