$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://mion.yosei.fi/archive/BES/bes_1.7.8.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  softwareName  = 'battle-encoder-shirase*'
  checksum      = '7DC8353FD13619933E0DD967BA06A215DCEE2ED6579C40073241ED62C399EF10'
  checksumType  = 'sha256'
}

# Create folder in Program Files for the application and unzip to this
$programfiles = [Environment]::GetFolderPath("ProgramFiles")
$unzippath = Join-Path $programfiles $env:ChocolateyPackageTitle
Install-ChocolateyZipPackage $packageName $url $unzippath

$executable = "BES_1.7.8\BES.exe"

# Add Desktop shortcut
$desktoppath = [Environment]::GetFolderPath("Desktop")
$shortcutfilename = "$env:ChocolateyPackageTitle.lnk"
$shortcutpath = Join-Path  $desktoppath $shortcutfilename
$executablepath = Join-Path $unzippath $executable
Install-ChocolateyShortcut -shortcutFilePath $shortcutpath -targetPath $executablepath

# Add StartMenu shortcut
$startmenupath = [Environment]::GetFolderPath('StartMenu')
$shortcutfilename = "$env:ChocolateyPackageTitle.lnk"
$shortcutpath = Join-Path  "$startmenupath\Programs" $shortcutfilename
$executablepath = Join-Path $unzippath $executable
Install-ChocolateyShortcut -shortcutFilePath $shortcutpath -targetPath $executablepath