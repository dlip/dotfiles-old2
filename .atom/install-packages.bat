for /f "tokens=* delims=" %%x in (packages.txt) do apm install %%x
