$ErrorActionPreference = 'Stop'
$version = 'rrp-1.0.0'
$name = "Rezzo-Red-Priest-Discord-WARDOGS-$version"
$output = Join-Path $PSScriptRoot 'dist'
$package = Join-Path $output $name
$archive = Join-Path $output "$name.zip"
if ((Test-Path -LiteralPath $package) -or (Test-Path -LiteralPath $archive)) {
    throw 'Release output already exists. Move it aside before building again.'
}
$files = @(
    'DISCORD + WARDOGS.bat', 'README.md', 'README.upstream.md', 'LICENSE.txt', 'LICENSE.REZZO.txt',
    'bin\winws.exe', 'bin\WinDivert.dll', 'bin\WinDivert64.sys', 'bin\cygwin1.dll',
    'bin\stun.bin', 'bin\tls_clienthello_www_google_com.bin', 'bin\tls_clienthello_max_ru.bin',
    'bin\ACTIVE_DISCORD_UDP.bin', 'bin\ACTIVE_GAME_UDP.bin', 'bin\quic_initial_www_google_com.bin'
)
foreach ($file in $files) {
    if (!(Test-Path -LiteralPath (Join-Path $PSScriptRoot $file) -PathType Leaf)) { throw "Missing release file: $file" }
}
foreach ($file in $files) {
    $target = Join-Path $package $file
    New-Item -ItemType Directory -Path (Split-Path $target) -Force | Out-Null
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot $file) -Destination $target
}
$manifest = foreach ($file in $files) {
    $hash = (Get-FileHash -LiteralPath (Join-Path $package $file) -Algorithm SHA256).Hash.ToLowerInvariant()
    "$hash  $($file.Replace('\','/'))"
}
$manifest | Set-Content -LiteralPath (Join-Path $package 'SHA256SUMS.txt') -Encoding ASCII
Compress-Archive -LiteralPath $package -DestinationPath $archive -CompressionLevel Optimal
$zipHash = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant()
"$zipHash  $name.zip" | Set-Content -LiteralPath (Join-Path $output "$name.zip.sha256") -Encoding ASCII
Write-Output "Created: $archive"
Write-Output "SHA256: $zipHash"
