function Get-AsciiArt()
{

    [cmdletbinding()]
param
(
[Parameter(Mandatory)]
$ImageFile

)

python.exe asciicreator.py $ImageFile



}