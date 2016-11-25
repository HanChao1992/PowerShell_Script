# The Initialize class connects to the server
# and shows all the groups
[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")| Out-Null

Class Initialize {
    # connect to server
    static [System.MarshalByRefObject] connect ([string]$inServerName) {
        [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")| Out-Null
        $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer($inServerName, $False, 8530)
        return $wsus
    }

    # show all the computer groups
    static showGroup ([System.MarshalByRefObject]$wsus) {
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
    }
}