# The userPromtp class display colorful message to
# the termial

[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")| Out-Null

Class UserPrompt{

    # Welcome to Updates Approval or Not! (Button Pushing Simulator 2016)
    # You can shut down the script at any time by pressing (q) when asked to input a key.
    # Please be as precise as possible when you input the name of the update for the best experience.
    # Press the key or type the String you want to input and then press ENTER.
    # Please enter the name of the server you want to connect to:
    static welcome () {
        write-host ""
        write-host -nonewline -foregroundcolor cyan "Welcome to Updates Approval or Not! "
        write-host -foregroundcolor magenta "(Button Pushing Simulator 2016)"
        get-date
        write-host ""
        write-host -nonewline "You can "
        write-host -nonewline -foregroundcolor yellow "shut down the script " 
        write-host -nonewline "at any time by pressing "
        write-host -nonewline -foregroundcolor red "(q) "
        write-host "when asked to input a key.`n"
        write-host -nonewline "Please be "
        write-host -nonewline -foregroundcolor green "as precise as possible " 
        write-host -nonewline "when you input the "
        write-host -nonewline -foregroundcolor green "name of the update " 
        write-host "for the best experience.`n"
        write-host -nonewline "Press the "
        write-host -nonewline -foregroundcolor yellow "key "
        write-host -nonewline "or type the "
        write-host -nonewline -foregroundcolor cyan "String " 
        write-host -nonewline "you want to input and then press "
        write-host -nonewline -foregroundcolor green "ENTER"
        write-host "."
    }
    
    # Please enter the name of the server you want to connect to:
    static serverName () {
        write-host ""
        write-host -nonewline "Please enter the "
        write-host -nonewline -foregroundcolor yellow "name of the server "
        write-host "you want to connect to:`n"
    }

    # $inServerName does NOT EXIST.
    # Please re-enter a server name.
    static serverError ([string]$inServerName) {
        write-host -nonewline -foregroundcolor yellow $inServerName
        write-host -nonewline " does "
        write-host -foregroundcolor red "NOT EXIST.`n"
        write-host -nonewline "Please re-enter "
        write-host -foregroundcolor yellow "a server name.`n"
    }

    # Please choose the group that you want to work with by entering the index.
    static chooseGroup () {
        write-host -NoNewline "Please choose the "
        write-host -NoNewline -ForegroundColor Yellow "group "
        write-host -nonewline "that you want to work with by "
        write-host -nonewline -ForegroundColor cyan "entering the index"
        write-host ".`n"
    }

    # The number you entered is Not valid!
    static groupError () {
        write-host -nonewline "The "
        write-host -nonewline -ForegroundColor green "number "
        write-host -NoNewline "you entered is "
        write-host -NoNewline -ForegroundColor red "NOT valid"
        write-host "!`n"
    }

    # The group you have chosen is $g.name.
    static groupConfirm ([System.MarshalByRefObject]$group) {
        write-host -nonewline "The "
        write-host -nonewline -foregroundcolor yellow "group "
        write-host -nonewline "you have chosen is "
        write-host -nonewline -foregroundcolor yellow $group.name
        write-host ".`n"
    }

    # Pleae enter the name of the update you would like to operate on:
    static updateName () {
        write-host -nonewline "Pleae enter the "
        write-host -nonewline -foregroundcolor green "name of the update "
        write-host "you would like to operate on: "
    }

    # Press (e) to enable showing Declined updates.
    # Declined updates will stay hidden if you do not input (e)
    # Hit ENTER to continue..
    static showDeclined () {
        write-host ""
        write-host -nonewline "Press "
        write-host -nonewline -foregroundcolor Yellow "(e) "
        write-host -nonewline "to enable showing "
        write-host -NoNewline -ForegroundColor Red "Declined "
        write-host "updates.`n"
        write-host -nonewline -foregroundcolor red "Declined "
        write-host -nonewline "updates will stay hidden if you do not input "
        write-host -nonewline -foregroundcolor yellow "(e)"
        write-host -nonewline ".`n"
        write-host -nonewline "`nHit "
        write-host -NoNewline -foregroundcolor green "ENTER "
        write-host -nonewline "to continue."
        write-host ".`n"
    }
    
    # $inUpdateName is not found.
    # Please re-enter a name of update.
    static updateError ([string]$inUpdateName) {
        write-host ""
        write-host -NoNewline $inUpdateName
        write-host -nonewline " is "
        write-host -foregroundcolor yellow "Not Found.`n"
        write-host -nonewline "Pleaes re-enter a "
        write-host -ForegroundColor Green "name of update.`n"
    }
   
    # Press (y) or hit ENTER to continue or press (l) to show the list of updates.
    static updateFound () {
        write-host -nonewline "Press "
        write-host -nonewline -foregroundcolor green "(y) "
        write-host -nonewline "or hit "
        write-host -nonewline -ForegroundColor green "ENTER "
        write-host -nonewline "to continue or press "
        write-host -nonewline -foregroundcolor yellow "(l) "
        write-host "to show the list of updates.`n"
    }

    # Batch Operation:
    # Batch operation allows user to perform operation on all the updates simultaneously.
    # Press (y) or hit ENTER to enable Batch Operation and press (n) to decline.
    static batchNotice () {
        write-host ""
        write-host -foregroundcolor green "Batch Operation:"
        write-host -nonewline "Batch operation allows user to perform operation on all the updates "
        write-host -foregroundcolor yellow "simultaneously.`n"
        write-host -nonewline "Press "
        write-host -nonewline -foregroundcolor green "(y) "
        write-host -nonewline "or hit "
        write-host -nonewline -ForegroundColor green "ENTER "
        write-host -nonewline "to enable "
        write-host -nonewline -foregroundcolor green "Batch Operation "
        write-host -nonewline "and press "
        write-host -nonewline -foregroundcolor red "(n) "
        write-host "to decline.`n"
    }

    # Is this the update you want to work with?
    # Press (y) or hit ENTER to confirm and press (n) to see the next update on the list.
    static singleConfirm () {
        write-host ""
        write-host "Is this the update you want to work with?"
        write-host -nonewline "Press "
        write-host -nonewline -foregroundcolor green "(y) "
        write-host -nonewline "or hit "
        write-host -nonewline -ForegroundColor green "ENTER "
        write-host -nonewline "to confirm and press "
        write-host -nonewline -foregroundcolor yellow "(n) "
        write-host "to see the next update on the list.`n"
    }
    
    # You can carry out the following operations...
    # Press the corresponding key in the bracket to carry out operations.
    # (i) Install the update(s).
    # (u) Uninstall the update(s).
    # (n) Unapprove the update(s).
    # (d) Decline the update(s).
    static instruction() {
        write-host ""
        write-host "You can carry out the following operations...`n"
        write-host "Press the corresponding key in the bracket to carry out operations.`n"
        write-host -foregroundcolor green "(i) Install the update(s).`n"
        write-host -foregroundcolor yellow "(u) Uninstall the update(s).`n"
        write-host -foregroundcolor magenta "(n) Unapprove the update(s).`n"
        write-host -foregroundcolor red "(d) Decline the update(s).`n"
    }

    # You did not enter a valid command!
    # Please re-enter command.
    static reenter () {
        write-host -foregroundcolor yellow "You did not enter a valid conmmand!"
        write-host -ForegroundColor Green "Please re-enter command.`n"
    }

    # Do you want to operate on the next update on the list?
    # Press (y) or hit ENTER to confirm, press (n) to go back.
    static nextUpdate () {
        write-host -nonewline "Do you want to operate on the next update on the list? Press "
        write-host -nonewline -foregroundcolor green "(y) "
        write-host -nonewline "or hit "
        write-host -nonewline -ForegroundColor green "ENTER "
        write-host -nonewline "to confirm, press "
        write-host -nonewline -foregroundcolor red "(n) "
        write-host "to go back.`n"
    }

    #What would you like to do with these $updates.count updates?
    static batchgreet ([System.Object]$updates) {
        write-host -nonewline "What would you like to do with these "
        write-host -nonewline -foregroundcolor green $updates.count
        write-host " upates?"
    }

    # You have reached the end of the list!
    # Press (b) to go back to the start of the list.
    # Press (q) to shutdown the script.
    # Press other keys to go back to the group selecting stage.
    static endofList () {
        write-host "You have reached the end of the list! `n"
        write-host -nonewline "Press "
        write-host -nonewline -foregroundcolor yellow "(r) "
        write-host "to go back to the start of the list. `n"
        write-host -nonewline "Press "
        write-host -nonewline -foregroundcolor red "(q) "
        write-host "to shutdown the script. `n"
        write-host -nonewline "Press "
        write-host -nonewline -ForegroundColor yellow "other keys "
        write-host "to go back to the group selecting stage. `n"
    }

    # Press (c) to see the instructions again.
    # Press (l) to show the list of updates (quick).
    # Press (r) to show a refreshed list of updates (slow). 
    # Press (q) to exit.
    static buttonPrompt () {
        write-host -nonewline "Press "
        write-host -nonewline -foregroundcolor yellow "(c) "
        write-host -nonewline "to see the instructions again.`nPress "
        write-host -nonewline -foregroundcolor yellow "(l) "
        write-host -nonewline "to show the list of updates "
        write-host -nonewline -foregroundcolor green "(quick)"
        write-host -nonewline ".`nPress "
        write-host -nonewline -foregroundcolor yellow "(r) "
        write-host -nonewline "to show a refreshed list of updates "
        write-host -nonewline -foregroundcolor red "(slow)"
        write-host -nonewline ".`nPress "
        write-host -nonewline -foregroundcolor Yellow "(q) "
        write-host "to exit.`n"
    }

    # Are you finished with the operation? Press (q) to quit. Press other keys to continue.
    static done () {
        write-host -nonewline "Are you finished with the operation? Press "
        write-host -nonewline -foregroundcolor red "(q) "
        write-host "to quit. Press other keys to continue.`n"
    }

}