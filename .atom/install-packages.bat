@echo off
for /f "tokens=* delims=" %%x in (packages.txt) do @if not exist packages\%%x apm install %%x
