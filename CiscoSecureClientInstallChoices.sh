#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	CiscoSecureClientInstallChoices.sh
#	https://github.com/Headbolt/CiscoSecureClientInstallChoices
#
#   This Script is designed for use in JAMF and was designed to create a choices file for Cisco AnyConnect Install
#	BEFORE the installer is cached, so it can be referenced in an install command after the caching.
#
#	The Following Variables should be defined
#	Variable 4 - Named "Choice File Name - eg. anyconnect_choices.xml"
#	Variable 5 - Named "Install Choices - eg. 1 0 1 0 0 0 0 0 0 0"
#	Variable 6 - Named "INFO - Choices are : vpn fireamp dart posture iseposture nvm umbrella ThousandEyes Duo ZTA. ALL must have a value, seperated by a SPACE
#
###############################################################################################################################################
#
# HISTORY
#
#   Version: 1.0 - 08/10/2025
#
#	08/10/2025 - V1.0 - Created by Headbolt, mod/update of https://github.com/Headbolt/CiscoAnyConnectProfile
#
###############################################################################################################################################
#
#   DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
ScriptVer=v1.0
ScriptName="Application | SecureClient | Choice File"
ExitCode=0
#
ChoiceFileName=$4 # Grab the Download Choice File Name from JAMF variable #4 eg. anyconnect_choices.xml
InstallChoices=$5 # Grab the Install Choices from JAMF variable #5 eg. 1 0 1 0 0 0 0 0 0 0
#
vpnEnabled=$( /bin/echo $InstallChoices | awk '{print $1}' ) # Split vpninstall choice out from the string in the InstallChoices Variable
fireampEnabled=$( /bin/echo $InstallChoices | awk '{print $2}' ) # Split fireampinstall choice out from the string in the InstallChoices Variable
dartEnabled=$( /bin/echo $InstallChoices | awk '{print $3}' ) # Split dartinstall choice out from the string in the InstallChoices Variable
postureEnabled=$( /bin/echo $InstallChoices | awk '{print $4}' ) # Split postureinstall choice out from the string in the InstallChoices Variable
isepostureEnabled=$( /bin/echo $InstallChoices | awk '{print $5}' ) # Split isepostureinstall choice out from the string in the InstallChoices Variable
nvmEnabled=$( /bin/echo $InstallChoices | awk '{print $6}' ) # Split nvminstall choice out from the string in the InstallChoices Variable
umbrellaEnabled=$( /bin/echo $InstallChoices | awk '{print $7}' ) # Split umbrellainstall choice out from the string in the InstallChoices Variable
ThousandEyesEnabled=$( /bin/echo $InstallChoices | awk '{print $8}' ) # Split thousandeyesinstall choice out from the string in the InstallChoices Variable
DuoEnabled=$( /bin/echo $InstallChoices | awk '{print $9}' ) # Split duoinstall choice out from the string in the InstallChoices Variable
ztaEnabled=$( /bin/echo $InstallChoices | awk '{print $10}' ) # Split ztainstall choice out from the string in the InstallChoices Variable
#
WaitingRoomFolder="/Library/Application Support/JAMF/Waiting Room"
#
###############################################################################################################################################
#
#   Checking and Setting Variables Complete
#
###############################################################################################################################################
# 
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Variable Check Function
#
VarCheck(){
#
/bin/echo 'Checking "'$Var2Check'" is set correctly'
#
if [[ "$VarValue" != "" ]]
	then
		if [[ "$VarValue" == "0" ]]
			then
				/bin/echo 'Value for "'$Var2Check'" is "'$VarValue'"'
				/bin/echo 'This Value Is Acceptable'
				/bin/echo 'Script will Contine'
		fi
		#
		if [[ "$VarValue" == "1" ]]
			then
				/bin/echo 'Value for "'$Var2Check'" is "'$VarValue'"'
				/bin/echo 'This Value Is Acceptable'
				/bin/echo 'Script will Contine'
		fi
	else
		/bin/echo 'Value for "'$Var2Check'" is "'$VarValue'"'
    	/bin/echo '"'$Var2Check'" MUST have a Value'
		/bin/echo 'Cannot Contine, ending script'
		ExitCode=1
		SectionEnd
		ScriptEnd
fi
#
}
#
###############################################################################################################################################
#
# ChoicePathCheck Function
#
ChoicePathCheck(){
#
if [ -d "$WaitingRoomFolder" ]
	then	
		/bin/echo 'Folder "'$WaitingRoomFolder'" exists'
		/bin/echo 'Continuing'
	else 
		/bin/echo 'Folder "'$WaitingRoomFolder'" does not exist'
        /bin/echo 'Checking full path'
		/bin/echo # Outputting a Blank Line for Reporting Purposes
		#
		if [ -d "/Library/Application Support/JAMF" ]
			then	
				/bin/echo 'Folder "/Library/Application Support/JAMF" exists'
				/bin/echo 'Continuing'
			else 
				/bin/echo 'Folder "/Library/Application Support/JAMF" does not exist'
				/bin/echo 'Creating it'
				mkdir "/Library/Application Support/JAMF"
		fi
		/bin/echo # Outputting a Blank Line for Reporting Purposes
		if [ -d "/Library/Application Support/JAMF/Waiting Room" ]
			then	
				/bin/echo 'Folder "/Library/Application Support/JAMF/Waiting Room" exists'
				/bin/echo 'Continuing'
			else 
				/bin/echo 'Folder "/Library/Application Support/JAMF/Waiting Room" does not exist'
				/bin/echo 'Creating it'
				mkdir "/Library/Application Support/JAMF/Waiting Room"
			fi
fi
#
}
#
###############################################################################################################################################
#
# ChoiceFile Function
#
ReWriteChoiceFile(){
#
/bin/echo 'Rewriting Choice File "'"$WaitingRoomFolder"/"$ChoiceFileName"'"'
#
/bin/echo '<?xml version="1.0" encoding="UTF-8"?>' > "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '<plist version="1.0">' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '<array>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$vpnEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_anyconnect_vpn</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$fireampEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_fireamp</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$dartEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_dart</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$postureEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_secure_firewall_posture</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$isepostureEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_iseposture</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$nvmEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_nvm</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$umbrellaEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_secure_umbrella</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$ThousandEyesEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_thousandeyes</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$DuoEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_duo</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	<dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>attributeSetting</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<integer>'$ztaEnabled'</integer>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceAttribute</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>selected</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<key>choiceIdentifier</key>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '		<string>choice_zta</string>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '	</dict>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '</array>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
/bin/echo '</plist>' >> "$WaitingRoomFolder"/"$ChoiceFileName"
#
}
#
###############################################################################################################################################
#
# Script Start Function
#
ScriptStart(){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
SectionEnd
/bin/echo Starting Script '"'$ScriptName'"'
/bin/echo Script Version '"'$ScriptVer'"'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Section End Function
#
SectionEnd(){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Script End Function
#
ScriptEnd(){
#
/bin/echo Ending Script '"'$ScriptName'"'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
exit $ExitCode
#
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
# 
# Begin Processing
#
###############################################################################################################################################
#
ScriptStart
#
Var2Check='vpnEnabled'
VarValue=$vpnEnabled
VarCheck
SectionEnd
#
Var2Check='fireampEnabled'
VarValue=$fireampEnabled
VarCheck
SectionEnd
#
Var2Check='dartEnabled'
VarValue=$dartEnabled
VarCheck
SectionEnd
#
Var2Check='postureEnabled'
VarValue=$postureEnabled
VarCheck
SectionEnd
#
Var2Check='isepostureEnabled'
VarValue=$isepostureEnabled
VarCheck
SectionEnd
#
Var2Check='nvmEnabled'
VarValue=$nvmEnabled
VarCheck
SectionEnd
#
Var2Check='umbrellaEnabled'
VarValue=$umbrellaEnabled
VarCheck
SectionEnd
#
Var2Check='ThousandEyesEnabled'
VarValue=$ThousandEyesEnabled
VarCheck
SectionEnd
#
Var2Check='DuoEnabled'
VarValue=$DuoEnabled
VarCheck
SectionEnd
#
Var2Check='ztaEnabled'
VarValue=$ztaEnabled
VarCheck
SectionEnd
#
ChoicePathCheck
SectionEnd
#
ReWriteChoiceFile
SectionEnd
ScriptEnd
