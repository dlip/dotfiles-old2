@echo off
set folders=atom vim
set files=gitconfig

for %%a in (%folders%) do (
   IF EXIST ..\.%%a (
     echo skipping %%a
   ) ELSE (
    echo create link to %%a
    mklink /D ..\.%%a dotfiles\%%a
   )
)

for %%a in (%files%) do (
   IF EXIST ..\.%%a (
     echo skipping %%a
   ) ELSE (
    echo create link to %%a
    mklink ..\.%%a dotfiles\%%a
   )
)
