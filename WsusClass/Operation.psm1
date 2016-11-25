# The Operation class handles
# install, uninstall, disapprove, and decline
# for WSUS updates

[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")| Out-Null

Class Operation {

    # install an update
    static install ([System.Object]$group, [System.Object]$u) {
        write-host ""
        write-host -nonewline -foregroundcolor green "Installing "
        write-host -nonewline -foregroundcolor cyan $u.Title
        write-host "..."
        $u.Approve("Install", $group)
    }

    # uninstall an update
    static uninstall ([System.Object]$group, [System.Object]$u) {
        write-host ""
        write-host -nonewline -foregroundcolor green "Uninstalling..."
        write-host -nonewline -foregroundcolor cyan $u.Title
        write-host "..."
        $u.Approve("Uninstall", $group)
    }
    
    # disapprove an update
    static unapprove ([System.Object]$group, [System.Object]$u) {
        write-host ""
        write-host -nonewline -foregroundcolor green "Unapproving..."
        write-host -nonewline -foregroundcolor cyan $u.Title
        write-host "..."
        $u.Approve("NotApproved", $group)
            
    }
    
    # decline an update
    static decline ([System.Object]$group, [System.Object]$u) {
        write-host ""
        write-host -nonewline -foregroundcolor green "Declining..."
        write-host -nonewline -foregroundcolor cyan $u.Title
        write-host "..."
        $u.Decline()
    }
}