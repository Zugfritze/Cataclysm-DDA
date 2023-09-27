$OriginalDirectory = Get-Location
$CDDASaveBackupgitpath = $env:ENABLE_CDDA_SAVE_BACKUP
if (-not ($null -eq $CDDASaveBackupgitpath)) {
    Invoke-Expression -Command "git clone --depth=1 https://github.com/Zugfritze/CDDA-Save-Backup $CDDASaveBackupgitpath"
    Set-Location -Path $CDDASaveBackupgitpath
    $env:RUSTFLAGS = '-C target-feature=+crt-static'
    Invoke-Expression -Command "cargo build --profile release"
    Copy-Item -Path "$CDDASaveBackupgitpath\target\cxxbridge\cdda_save_backup\src\lib.rs.h" -Destination "$OriginalDirectory\src\cdda_save_backup.h"
    Copy-Item -Path "$CDDASaveBackupgitpath\target\cxxbridge\cdda_save_backup\src\lib.rs.cc" -Destination "$OriginalDirectory\src\cdda_save_backup.cpp"
    Copy-Item -Path "$CDDASaveBackupgitpath\target\release\cdda_read_save_backup.exe" -Destination "$OriginalDirectory\cdda_read_save_backup.exe"
    Set-Location -Path $OriginalDirectory
}
else {
    Write-Host "------错误------"
    Write-Host "环境变量 ENABLE_CDDA_SAVE_BACKUP 为空"
}
