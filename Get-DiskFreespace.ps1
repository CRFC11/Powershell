################################################################################
#
# Script to display disk drive space details.  
# It mimics the disk management screen in server manager.
#
################################################################################
# Instructions:
# 1) Set user assigned variables as appropriate.
# 1.1)The target computer(s) list can be either supplied via the (comma separated)
# input list or read from a file.
# 1.2)  The LowSpaceMask is percentage free space threshold. 
# 2) Run script.
#
# Notes:
###############################################################################
#
# User assigned variables.
#
# Server
[array]$InputList = ('ASCOT-DEV-DB46') # A comma separated list of computers eg ('Computer1', 'Computer2').
# Lowspacemask
[int]$LowSpaceMask = 100 # Enter a low disk space percentage (1-100).

#
# Import modules.
# 
Import-Module Computer;
 
# 
# Main body.
#
Clear-Host;
Get-DiskSpace -Servercollection $InputList -LowSpaceMask $LowSpaceMask | Sort-Object -Property SystemName, Name | Format-Table -AutoSize;
