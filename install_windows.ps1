md $env:USERPROFILE\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$env:USERPROFILE\\vimfiles\\autoload\\plug.vim"))

$targetdir = pwd
cmd /c mklink $env:USERPROFILE\_vimrc $targetdir\_vimrc
cmd /c mklink $env:USERPROFILE\_vsvimrc $targetdir\_vsvimrc