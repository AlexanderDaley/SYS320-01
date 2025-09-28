. (Join-Path $PSScriptRoot scrapingChamplainClasses.ps1)

clear

$table = gatherClasses
#$table
#$table | select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | where { $_.Instructor -ilike "Furkan Paligu" }
#$table | Where-Object  {($_.Location -ilike "JOYC 310") -and ($_.days -ilike "Monday")} | `
#         Sort-Object -Property "Time Start" | `
#         select "Time Start", "Time End", "Class Code"

$ITSInstructors = $table | Where-Object { ($_."Class Code" -ilike "SYS*") -or 
                                              ($_."Class Code" -ilike "NET*") -or 
                                              ($_."Class Code" -ilike "SEC*") -or 
                                              ($_."Class Code" -ilike "FOR*") -or 
                                              ($_."Class Code" -ilike "CSI*") -or 
                                              ($_."Class Code" -ilike "DAT*") 
                                              } | select "Instructor" `
                                              | Sort-Object "Instructor" -Unique
#$ITSInstructors

$table | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } `
                | Group-Object "Instructor"  | Select-Object Count, Name | Sort-Object Count -Descending