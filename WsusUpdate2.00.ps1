<# 
   Script for performing various approval operations on updates
   based on, name of server, name of updates and, name of group 
   given by users.
   I am the ultimate button pusher! 
#>

# Change the following path according to where you put the module files.
using module "C:\Users\HAZHAO\Desktop\Wsus\WsusClass\Operation.psm1"
using module "C:\Users\HAZHAO\Desktop\Wsus\WsusClass\Infodisplay.psm1"
using module "C:\Users\HAZHAO\Desktop\Wsus\WsusClass\Initialization.psm1"
using module "C:\Users\HAZHAO\Desktop\Wsus\WsusClass\Userprompt.psm1"


function wsusUpdater{
    Process {
        clear

        # Welcome to Updates Approval or Not! (Button Pushing Simulator 2016)
        # You can shut down the script at any time by pressing (q) when asked to input a key.
        # Please be as precise as possible when you input the name of the update for the best experience.
        # Press the key or type the String you want to input and then press ENTER.
        # Please enter the name of the server you want to connect to:
        [UserPrompt]::welcome()

        #========================================================================
        #============================ Server Name ===============================
        #========================================================================
        
        $serverConfirmed = $false
        while(-Not $serverConfirmed) { # User must enter a valid server name.
            
            # Please enter the name of the server you want to connect to:
            [UserPrompt]::serverName()

            $inServerName = read-host 
            
            $wsus = [Initialize]::connect($inServerName)
            
            if (-Not $wsus) {
                # $inServerName does NOT EXIST.
                # Please re-enter a server name.
                [UserPrompt]::serverError($inServerName)
            }
            else {
                $serverConfirmed = $true
            }
        }
        
        #========================================================================
        #============================= Group Name ===============================
        #========================================================================
        
        $allDone = $false
        while(-Not $allDone) { # Supports consecutive operation until user inform the job is done.
            $allGroups = [InfoDisplay]::showGroup($wsus)
            
            $groupDone = $false
            while(-Not $groupDone) { # User must choose a valid group.
                
                # Please choose the group that you want to work with by entering the index.
                [UserPrompt]::chooseGroup()

                $inGroupName = read-host
                if (($inGroupName -gt $allGroups.count) -or
                    ($inGroupName -lt 1)
                    ) {
                    
                    # The number you entered is Not valid!
                    [UserPrompt]::groupError()
                }
                else {
                    $inGroupName = $inGroupName - 1
                    $group = $allGroups[$inGroupName]
                    
                    # The group you have chosen is GroupName.
                    [UserPrompt]::groupConfirm($group)
          
                    $groupDone = $true
                }
            }

            #========================================================================
            #============================= Update Name ==============================
            #========================================================================
            
            # "Please enter the name of the update you would like to operate on:"
            [UserPrompt]::updateName()
            $inUpdateName = read-host
            
            # Press (e) to enable showing Declined updates.
            # Declined updates will stay hidden if you do not input (e)
            # Hit ENTER to continue..
            [UserPrompt]::showDeclined()
            $inEnable = read-host
            $numofup = 0
            $updates = [InfoDisplay]::showNewList($inUpdateName, $inEnable, $wsus)
            $numofup = $updates.count
            if (-Not $updates) { #The search did not find any updates.
                
                # $inUpdateName is not found.
                # Please re-enter a name of update.
                [UserPrompt]::updateError($inUpdateName)
            }
            
            else { #The search found some updates.
                write-host -foregroundcolor Green -NoNewline $updates.count 
                echo " update(s) found!`n"
                
                $show = $true
                while($show) { # keeps showing the update if needed.
                    
                    # Press (y) or hit ENTER to continue or press (l) to show the list of updates.
                    [UserPrompt]::updateFound()

                    $list = read-host
                    switch ($list) { 
                        "l" {
                            # Here is the list of available updates.
                            [InfoDisplay]::showList($updates)
                        }
                        "y" {
                            $show = $false
                        }
                        "" {
                            $show = $false
                        }
                        "q" {
                            exit
                        }
                    }
                }

                
                # Batch Operation:
                # Batch operation allows user to perform operation on all the updates simultaneously.
                # Press (y) or hit ENTER to enable Batch Operation and press (n) to decline.
                [UserPrompt]::batchNotice()
                
                $inBatch = read-host 
                
                #========================================================================
                #========================== Single Operatoin ============================
                #========================================================================
                
                if($inBatch -eq "n"){
                    write-host "Would you like to to operate on`n"
                    
                    $notSelected = $true 
                    while($numofup -ne 0 -and $notSelected) { # make sure the user select one of the udpate from the list.
                        
                        $updates = [InfoDisplay]::showNewList($inUpdateName, $inEnable, $wsus)

                        foreach ($u in $updates) { #interate through the list of updates that corresponds to the update name user inputted.
                            $numofup--
                            
                            [InfoDisplay]::showUpdate($u)

                            # Is this the update you want to work with?
                            # Press (y) or hit ENTER to confirm and press (n) to see the next update on the list.
                            [UserPrompt]::singleConfirm()

                            $inUpdateConfirm = read-host  
                            if ($inUpdateConfirm -eq "y" -or $inUpdateConfirm -eq "" ) {
                                
                                # You can carry out the following operations...
                                # Press the corresponding key in the bracket to carry out operations.
                                # (i) Install the update(s).
                                # (u) Uninstall the update(s).
                                # (n) Unapprove the update(s).
                                # (d) Decline the update(s).
                                [UserPrompt]::instruction()
                                $singleDone = $false
                                while(-not $singleDone){
                                    # Press (c) to see the instructions again.
                                    # Press (l) to show the list of updates (quick).
                                    # Press (r) to show a refreshed list of updates (slow). 
                                    # Press (q) to exit.
                                    [UserPrompt]::buttonPrompt()
                                    $inOp = read-host
                                    
                                    switch ($inOp) {
                                        "i" { # install
                                            [Operation]::install($group, $u)
                                            $singleDone = $true
                                        }
                                        "u" { # uninstall
                                            [Operation]::uninstall($group, $u)
                                            $singleDone = $true
                                        }
                                        "n" { # disapprove
                                            [Operation]::unapprove($group, $u)
                                            $singleDone = $true
                                        
                                        }
                                        "d" { # decline
                                            [Operation]::decline($group, $u)
                                            $singleDone = $true
                                        }
                                        "c" { # show instruction
                                            [UserPrompt]::instruction()

                                        }
                                        "l" { # show list
                                            [InfoDisplay]::showList($updates)

                                        }
                                        "r" { # show updated list
                                            $updates = [InfoDisplay]::showNewList($inUpdateName, $inEnable, $wsus)
                                            [InfoDisplay]::showList($updates)
                                        }
                                        "q" { # quit
                                            exit
                                        }
                                        default {
                                            # You did not enter a valid command!
                                            # Please re-enter command.
                                            [UserPrompt]::reenter()
                                        }
                                    }
                                }

                                # Do you want to operate on the next update on the list?
                                # Press (y) or hit ENTER to confirm, press (n) to go back.
                                [UserPrompt]::nextUpdate()

                                $inMore = read-host
                                switch ($inMore) { 
                                    "n" {
                                        $notSelected = $false # go back to name entering phase if user choose not to work with this list of updates anymore.

                                        # Are you finished with the operation? Press (q) to quit. Press other keys to continue.
                                        [UserPrompt]::done()

                                        $inFinish = read-host
                                    
                                        if ($inFinish -eq "q") {
                                        $allDone = $true
                                        
                                        }
                                        break
                                    }
                                    "y" {# go to the next update
                                    }
                                    "" {# go to the next update
                                    }
                                    "q" { #
                                        exit
                                    }
                                }
                            }
                            elseif ($inUpdateConfirm -eq "q") {
                                exit
                            }
                            else {
                                echo ""
                                if ($numofUp -ne 0) {
                                    write-host -foregroundcolor green "The next update on the list is:`n"
                                }
                                else {
                                    # You have reached the end of the list!
                                    # Press (b) to go back to the start of the list.
                                    # Press (q) to shutdown the script.
                                    # Press other keys to go back to the group selecting stage.
                                    [UserPrompt]::endofList()

                                    $inList = read-host
                                    
                                    if ($inList -eq "b") {
                                        $numofUP = $updates.count
                                    }
                                    elseif ($inList -eq "q") {
                                        exit
                                    }
                                    else {
                                    }
                                }
                            }
                        }
                    }
                }

                #========================================================================
                #========================== Batch Operatoin =============================
                #========================================================================
                elseif ($inBatch -eq "y" -or $inBatch -eq "") { # Batch Operations.
                    $batchDone = $false
                    while(-not $batchDone){

                        [UserPrompt]::instruction()
                        
                        #What would you like to do with these $updates.count updates?
                        [UserPrompt]::batchgreet($updates)
                        
                        [UserPrompt]::buttonPrompt()
                         
                        $inOp = read-host
                        
                        switch ($inOp) {
                            "i" { # install
                                foreach($p in $updates) {
                                    [Operation]::install($group, $p)
                                    $batchDone = $true
                                }
                            }
                            "u" { # uninstall
                                foreach($p in $updates) {
                                    [Operation]::uninstall($group, $p)
                                    $batchDone = $true
                                }
                            }
                            "n" { # disapprove
                                foreach($p in $updates) {
                                    [Operation]::unapprove($group, $p)
                                    $batchDone = $true
                                }
                            }
                            "d" { # decline
                                foreach($p in $updates) {
                                    [Operation]::decline($group, $p)
                                    $batchDone = $true
                                }
                            }
                            "c" { # show instruction
                                [InfoDisplay]::instruction()
                            }
                            "l" { # show list
                                [InfoDisplay]::showList($updates)
                            }
                            "r" { # show updated list
                                $updates = [InfoDisplay]::showNewList($inUpdateName, $inEnable, $wsus)
                                [InfoDisplay]::showList($updates)
                            }
                            "q" { # quit
                                exit
                            }
                            default { # not a valid command
                                [UserPrompt]::reenter()
                            }
                        }
                    }
                }
                elseif ($inBatch -eq "q") { # quit
                    exit
                }
            }
        }
    }
}

wsusUpdater
