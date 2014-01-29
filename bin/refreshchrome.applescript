on run arg
	tell application "Google Chrome"
		set windowList to every window
		set found to false
		repeat with aWindow in windowList
			set tabList to every tab of aWindow
			set theTabIndex to 0
			repeat with atab in tabList
				set theTabIndex to theTabIndex + 1
				if (URL of atab contains arg) then
					tell atab to reload
					set aWindow's active tab index to theTabIndex
					activate
					set found to true
					exit repeat
				end if
			end repeat
			if found then
			exit repeat
		end if
		end repeat
	end tell
end run
