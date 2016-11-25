# The InfoDisplay class displays list of groups,
# a single update, and a list of updates with various
# attributes.

[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")| Out-Null

Class InfoDisplay {
    # display all the groups with labels
    static [System.Object] showGroup ([System.MarshalByRefObject]$wsus) {
        write-host ""
        write-host -nonewline "Here is the list of all the "
        write-host -foregroundcolor yellow "groups."
        $allGroups = $wsus.GetComputerTargetGroups()
        $label = 1;
        foreach($g in $allGroups) {
            write-host -nonewline -ForegroundColor cyan "("
            write-host -nonewline -ForegroundColor cyan $label
            write-host -nonewline -ForegroundColor cyan ")"
            write-host -nonewline " "
            write-host -foregroundcolor yellow $g.name
            $label = $label + 1;
        }
        return $allGroups
    }
    
    # show a single update with its approval status, decline status, superseded status,
    # and publication state.
    static showUpdate ([System.Object]$u) {
       write-host -foregroundColor cyan $u.Title
       write-host -NoNewline -foregroundColor yellow "IsApproved: "
       if ($u.IsApproved -eq $true) {
            write-host -foregroundColor green $u.IsApproved
       }
       else {
            write-host -foregroundColor red $u.IsApproved
       }
       write-host -NoNewline -foregroundColor yellow "IsDeclined: "
       if ($u.IsDeclined -eq $true) {
            write-host -foregroundColor green $u.IsDeclined
       }
       else {
            write-host -foregroundColor red $u.IsDeclined
       }
       write-host -NoNewline -foregroundColor yellow "IsSuperseded: "
       if ($u.IsSuperseded -eq $true) {
            write-host -foregroundColor green $u.IsSuperseded
       }
       else {
            write-host -foregroundColor red $u.IsSuperseded
       }
       write-host -NoNewline -foregroundColor yellow "PublicationState: "
       if ($u.PublicationState -eq 'Published') {
            write-host -foregroundColor green $u.PublicationState
       }
       else {
            write-host -foregroundColor red $u.PublicationState
       }
    }

    # Here is the list of available updates.
    static showList ([System.Object]$updates) {
        write-host ""
        write-host "Here is the list of available updates.`n"
        foreach ($u in $updates) {
            [InfoDisplay]::showUpdate($u)
        }
    }

    # show a new list of the updates
    static [System.Object] showNewList ([String]$inUpdateName, [String]$inEnable, [System.Object]$wsus) {
        if ($inEnable -eq "e") {
            $updates = $wsus.SearchUpdates($inUpdateName) | where-object {$_.title -like '*'+$inUpdateName+'*'}
            return $updates
        }
        elseif ($inEnable -eq "q") {
            exit
        }
        else {
            $updates = $wsus.SearchUpdates($inUpdateName) | where-object {$_.title -like '*'+$inUpdateName+'*'} | Where-Object {$_.isDeclined -eq $false}
            return $updates
        }
    }
}