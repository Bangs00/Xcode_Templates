unset_variables() {
	unset FILE_PROJECT_COLOR
	unset SUCCESS_TEXT_COLOR
	unset FAILURE_TEXT_COLOR
	unset WARNING_TEXT_COLOR
	unset DEFAULT_TEXT_COLOR
	unset APPDELEGATE_FILE_UUID
	unset ASSETS_FILE_UUID
	unset ASSETS_FILE_REF_STRING
	unset LAUNCHSCREEN_FILE_UUID
	unset LAUNCHSCREEN_FILE_REF_STRING
}

unset_variables

FILE_PROJECT_COLOR='\033[0m\033[3;4;36m'
SUCCESS_TEXT_COLOR='\033[0m\033[1;32m'
FAILURE_TEXT_COLOR='\033[0m\033[1;31m'
WARNING_TEXT_COLOR='\033[0m\033[1;33m'
DEFAULT_TEXT_COLOR='\033[0;37m'

# Removing AppDelegate.swift
echo "${DEFAULT_TEXT_COLOR}Removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${DEFAULT_TEXT_COLOR} file"
APPDELEGATE_FILE_UUID=`sed -n '/AppDelegate.swift/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj | head -n 1`

if [ -z "$APPDELEGATE_FILE_UUID" ]; then
	echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${FAILURE_TEXT_COLOR} file reference UUID not found from project file"
		unset_variables
	exit 1
fi

if [ `sed -n '/AppDelegate.swift/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -lt 2 ]; then
	echo "${WARNING_TEXT_COLOR}Already ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${WARNING_TEXT_COLOR} file removed"
else
	sed -i '' -e "/$APPDELEGATE_FILE_UUID/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${FAILURE_TEXT_COLOR} file reference from project file"
		unset_variables
		exit 1
	fi

	rm -rf ___PROJECTNAME___/AppDelegate.swift

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${FAILURE_TEXT_COLOR} file"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${SUCCESS_TEXT_COLOR} file"
fi

# Removing ContentView.swift
echo "${DEFAULT_TEXT_COLOR}Removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${DEFAULT_TEXT_COLOR} file"
if [ ! -f "___PROJECTNAME___/ContentView.swift" ]; then
	echo "${WARNING_TEXT_COLOR}Already ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${WARNING_TEXT_COLOR} file removed"
else
	sed -i '' -e '/ContentView.swift/d' ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${FAILURE_TEXT_COLOR} file reference from project file"
		unset_variables
		exit 1
	fi

	rm -rf ___PROJECTNAME___/ContentView.swift

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${FAILURE_TEXT_COLOR} file"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${SUCCESS_TEXT_COLOR} file"
fi

# Moving Assets.xcassets
echo "${DEFAULT_TEXT_COLOR}Moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${DEFAULT_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets${DEFAULT_TEXT_COLOR}"
if [ ! -d "./___PROJECTNAME___/Assets.xcassets" ]; then
	echo "${WARNING_TEXT_COLOR}Already ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${WARNING_TEXT_COLOR} file moved to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets"
else
	ASSETS_FILE_UUID=`sed -n '/Assets.xcassets/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj`

	if [ -z "$ASSETS_FILE_UUID" ]; then
		echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file reference UUID not found from project file"
		unset_variables
		exit 1
	fi

	ASSETS_FILE_REF_STRING=`sed -n "/$ASSETS_FILE_UUID \/\* Assets.xcassets \*\/,/p" ___PROJECTNAME___.xcodeproj/project.pbxproj`
	ASSETS_FILE_REF_STRING=${ASSETS_FILE_REF_STRING//\//\\/}
	ASSETS_FILE_REF_STRING=${ASSETS_FILE_REF_STRING//\*/\\*}

	if [ -z "$ASSETS_FILE_REF_STRING" ]; then
		echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file reference group line not found from project file"
		unset_variables
		exit 1
	fi

	sed -i '' -e "/$ASSETS_FILE_REF_STRING/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file reference group line from project file"
		unset_variables
		exit 1
	fi

	sed -i '' -e "s/Info.plist \*\/,/Info.plist \*\/,\n$ASSETS_FILE_REF_STRING/g" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error adding ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file reference group line from project file"
		unset_variables
		exit 1
	fi

	mv ___PROJECTNAME___/Assets.xcassets ___PROJECTNAME___/Resources/Assets.xcassets

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${SUCCESS_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets"
fi

# Moving LaunchScreen.storyboard
echo "${DEFAULT_TEXT_COLOR}Moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${DEFAULT_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard${DEFAULT_TEXT_COLOR}"

if [ ! -d "./___PROJECTNAME___/Base.lproj" ]; then
	echo "${WARNING_TEXT_COLOR}Already ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${WARNING_TEXT_COLOR} file moved to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard"
else
	LAUNCHSCREEN_FILE_UUID=`sed -n '/LaunchScreen.storyboard/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj`

	if [ -z "$LAUNCHSCREEN_FILE_UUID" ]; then
		echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file reference UUID not found from project file"
		unset_variables
		exit 1
	fi

	LAUNCHSCREEN_FILE_REF_STRING=`sed -n "/$LAUNCHSCREEN_FILE_UUID \/\* LaunchScreen.storyboard \*\/,/p" ___PROJECTNAME___.xcodeproj/project.pbxproj`
	LAUNCHSCREEN_FILE_REF_STRING=${LAUNCHSCREEN_FILE_REF_STRING//\//\\/}
	LAUNCHSCREEN_FILE_REF_STRING=${LAUNCHSCREEN_FILE_REF_STRING//\*/\\*}

	if [ -z "$LAUNCHSCREEN_FILE_REF_STRING" ]; then
		echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file reference group line not found from project file"
		unset_variables
		exit 1
	fi

	sed -i '' -e "/$LAUNCHSCREEN_FILE_REF_STRING/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file reference group line from project file"
		unset_variables
		exit 1
	fi

	sed -i '' -e "s/Info.plist \*\/,/Info.plist \*\/,\n$LAUNCHSCREEN_FILE_REF_STRING/g" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error adding ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file reference group line from project file"
		unset_variables
		exit 1
	fi

	mv ___PROJECTNAME___/Base.lproj ___PROJECTNAME___/Resources/Base.lproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${SUCCESS_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard"
fi

# Setting Info.plist file path in project build settings
echo "${DEFAULT_TEXT_COLOR}Setting ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${DEFAULT_TEXT_COLOR} path to build settings in project"
if [ `sed -n '/INFOPLIST_FILE \= "___PROJECTNAME___\/Resources\/Info\.plist";/p' ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -gt 1 ]; then
	echo "${WARNING_TEXT_COLOR}Already ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${WARNING_TEXT_COLOR} path set to build settings in project"
else
	sed -i '' -e '/\tINFOPLIST_FILE \=/d' ___PROJECTNAME___.xcodeproj/project.pbxproj
	sed -i '' -e 's/INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/INFOPLIST_FILE \= \"___PROJECTNAME___\/Resources\/Info.plist\";\n\t\t\t\tINFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/g' ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error setting ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${FAILURE_TEXT_COLOR} path to build settings in project"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success setting ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${SUCCESS_TEXT_COLOR} path to build setting in project${DEFAULT_TEXT_COLOR}"
fi

unset_variables

pod repo update
pod install
