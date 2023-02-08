unset_variables() {
	unset ___PROJECTNAME____FILE_PROJECT_COLOR
	unset ___PROJECTNAME____SUCCESS_TEXT_COLOR
	unset ___PROJECTNAME____FAILURE_TEXT_COLOR
	unset ___PROJECTNAME____WARNING_TEXT_COLOR
	unset ___PROJECTNAME____DEFAULT_TEXT_COLOR
	unset ___PROJECTNAME____APPDELEGATE_FILE_UUID
	unset ___PROJECTNAME____ASSETS_FILE_UUID
	unset ___PROJECTNAME____ASSETS_FILE_REF_STRING
	unset ___PROJECTNAME____LAUNCHSCREEN_FILE_UUID
	unset ___PROJECTNAME____LAUNCHSCREEN_FILE_REF_STRING
	unset ___PROJECTNAME____IS_SET_API_URL
	unset ___PROJECTNAME____API_BASE_URL
}

unset_variables

___PROJECTNAME____FILE_PROJECT_COLOR='\033[0m\033[3;4;36m'
___PROJECTNAME____SUCCESS_TEXT_COLOR='\033[0m\033[1;32m'
___PROJECTNAME____FAILURE_TEXT_COLOR='\033[0m\033[1;31m'
___PROJECTNAME____WARNING_TEXT_COLOR='\033[0m\033[1;33m'
___PROJECTNAME____DEFAULT_TEXT_COLOR='\033[0;37m'

# Set API base URL in project build settings user-defined cateogry
if [ `sed -n "/API_BASE_URL \= /p" ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -gt 1 ]; then
	echo "${___PROJECTNAME____WARNING_TEXT_COLOR}Already set API base URL in project build settings user-defined category.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
else
	read -k 1 "___PROJECTNAME____IS_SET_API_URL?Do you want to set API base URL in project build settings? (Y/[n]) "

	if [[ "$___PROJECTNAME____IS_SET_API_URL" =~ ^[Yy]$ ]]; then
		echo "\n${___PROJECTNAME____WARNING_TEXT_COLOR}[!] API base URL will set in project build setting user-defined category.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		echo -n "Enter API base URL\n> \033[0m\033[4;36m"
		read "___PROJECTNAME____API_BASE_URL?"

		___PROJECTNAME____API_BASE_URL=${___PROJECTNAME____API_BASE_URL//\//\\/}
		___PROJECTNAME____API_BASE_URL=${___PROJECTNAME____API_BASE_URL//\*/\\*}
		sed -i '' -e '/API_BASE_URL \= /d' ___PROJECTNAME___.xcodeproj/project.pbxproj
		sed -i '' -e "s/ASSETCATALOG_COMPILER_APPICON_NAME/API_BASE_URL \= \"$___PROJECTNAME____API_BASE_URL\";\n\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME/g" ___PROJECTNAME___.xcodeproj/project.pbxproj
		
		if [ $? -ne 0 ]; then
			echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error setting API base URL in project build settings user-defined category.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
			unset_variables
			exit 1
		fi
		
		echo "${___PROJECTNAME____SUCCESS_TEXT_COLOR}Success setting API base URL in project build settings user-defined category.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		echo "${___PROJECTNAME____WARNING_TEXT_COLOR}[!] If you want to set urls to each configuration or scheme, change API_BASE_URL value in project build settings user-defined category.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
	fi
fi

# Removing AppDelegate.swift
echo "\n${___PROJECTNAME____DEFAULT_TEXT_COLOR}Removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${___PROJECTNAME____DEFAULT_TEXT_COLOR} file."
___PROJECTNAME____APPDELEGATE_FILE_UUID=`sed -n '/AppDelegate.swift/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj | head -n 1`

if [ -z "$___PROJECTNAME____APPDELEGATE_FILE_UUID" ]; then
	echo "${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference UUID not found from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
	exit 1
fi

if [ `sed -n '/AppDelegate.swift/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -lt 2 ]; then
	echo "${___PROJECTNAME____WARNING_TEXT_COLOR}Already ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${___PROJECTNAME____WARNING_TEXT_COLOR} file removed.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
else
	sed -i '' -e "/$___PROJECTNAME____APPDELEGATE_FILE_UUID/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	rm -rf ___PROJECTNAME___/AppDelegate.swift

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${___PROJECTNAME____FAILURE_TEXT_COLOR} file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${___PROJECTNAME____SUCCESS_TEXT_COLOR}Success removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${___PROJECTNAME____SUCCESS_TEXT_COLOR} file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
fi

# Removing ContentView.swift
echo "\n${___PROJECTNAME____DEFAULT_TEXT_COLOR}Removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${___PROJECTNAME____DEFAULT_TEXT_COLOR} file."
if [ ! -f "___PROJECTNAME___/ContentView.swift" ]; then
	echo "${___PROJECTNAME____WARNING_TEXT_COLOR}Already ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${___PROJECTNAME____WARNING_TEXT_COLOR} file removed.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
else
	sed -i '' -e '/ContentView.swift/d' ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	rm -rf ___PROJECTNAME___/ContentView.swift

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${___PROJECTNAME____FAILURE_TEXT_COLOR} file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${___PROJECTNAME____SUCCESS_TEXT_COLOR}Success removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${___PROJECTNAME____SUCCESS_TEXT_COLOR} file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
fi

# Moving Assets.xcassets
echo "\n${___PROJECTNAME____DEFAULT_TEXT_COLOR}Moving ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${___PROJECTNAME____DEFAULT_TEXT_COLOR} file to ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets${___PROJECTNAME____DEFAULT_TEXT_COLOR}."
if [ ! -d "./___PROJECTNAME___/Assets.xcassets" ]; then
	echo "${___PROJECTNAME____WARNING_TEXT_COLOR}Already ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${___PROJECTNAME____WARNING_TEXT_COLOR} file moved to ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets${___PROJECTNAME____WARNING_TEXT_COLOR}.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
else
	___PROJECTNAME____ASSETS_FILE_UUID=`sed -n '/Assets.xcassets/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj`

	if [ -z "$___PROJECTNAME____ASSETS_FILE_UUID" ]; then
		echo "${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference UUID not found from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	___PROJECTNAME____ASSETS_FILE_REF_STRING=`sed -n "/$___PROJECTNAME____ASSETS_FILE_UUID \/\* Assets.xcassets \*\/,/p" ___PROJECTNAME___.xcodeproj/project.pbxproj`
	___PROJECTNAME____ASSETS_FILE_REF_STRING=${___PROJECTNAME____ASSETS_FILE_REF_STRING//\//\\/}
	___PROJECTNAME____ASSETS_FILE_REF_STRING=${___PROJECTNAME____ASSETS_FILE_REF_STRING//\*/\\*}

	if [ -z "$___PROJECTNAME____ASSETS_FILE_REF_STRING" ]; then
		echo "${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference group line not found from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	sed -i '' -e "/$___PROJECTNAME____ASSETS_FILE_REF_STRING/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference group line from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	sed -i '' -e "s/Info.plist \*\/,/Info.plist \*\/,\n$___PROJECTNAME____ASSETS_FILE_REF_STRING/g" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error adding ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference group line from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	mv ___PROJECTNAME___/Assets.xcassets ___PROJECTNAME___/Resources/Assets.xcassets

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error moving ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${___PROJECTNAME____FAILURE_TEXT_COLOR} file to ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets${___PROJECTNAME____FAILURE_TEXT_COLOR}.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${___PROJECTNAME____SUCCESS_TEXT_COLOR}Success moving ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${___PROJECTNAME____SUCCESS_TEXT_COLOR} file to ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets${___PROJECTNAME____SUCCESS_TEXT_COLOR}.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
fi

# Moving LaunchScreen.storyboard
echo "\n${___PROJECTNAME____DEFAULT_TEXT_COLOR}Moving ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____DEFAULT_TEXT_COLOR} file to ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____DEFAULT_TEXT_COLOR}."

if [ ! -d "./___PROJECTNAME___/Base.lproj" ]; then
	echo "${___PROJECTNAME____WARNING_TEXT_COLOR}Already ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____WARNING_TEXT_COLOR} file moved to ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____WARNING_TEXT_COLOR}.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
else
	___PROJECTNAME____LAUNCHSCREEN_FILE_UUID=`sed -n '/LaunchScreen.storyboard/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj`

	if [ -z "$___PROJECTNAME____LAUNCHSCREEN_FILE_UUID" ]; then
		echo "${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference UUID not found from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	___PROJECTNAME____LAUNCHSCREEN_FILE_REF_STRING=`sed -n "/$___PROJECTNAME____LAUNCHSCREEN_FILE_UUID \/\* LaunchScreen.storyboard \*\/,/p" ___PROJECTNAME___.xcodeproj/project.pbxproj`
	___PROJECTNAME____LAUNCHSCREEN_FILE_REF_STRING=${___PROJECTNAME____LAUNCHSCREEN_FILE_REF_STRING//\//\\/}
	___PROJECTNAME____LAUNCHSCREEN_FILE_REF_STRING=${___PROJECTNAME____LAUNCHSCREEN_FILE_REF_STRING//\*/\\*}

	if [ -z "$___PROJECTNAME____LAUNCHSCREEN_FILE_REF_STRING" ]; then
		echo "${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/LaunchScreen.storyboard${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference group line not found from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	sed -i '' -e "/$___PROJECTNAME____LAUNCHSCREEN_FILE_REF_STRING/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error removing ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference group line from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	sed -i '' -e "s/Info.plist \*\/,/Info.plist \*\/,\n$___PROJECTNAME____LAUNCHSCREEN_FILE_REF_STRING/g" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error adding ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____FAILURE_TEXT_COLOR} file reference group line from project file.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	mv ___PROJECTNAME___/Base.lproj ___PROJECTNAME___/Resources/Base.lproj

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error moving ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____FAILURE_TEXT_COLOR} file to ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____FAILURE_TEXT_COLOR}.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${___PROJECTNAME____SUCCESS_TEXT_COLOR}Success moving ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____SUCCESS_TEXT_COLOR} file to ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard${___PROJECTNAME____SUCCESS_TEXT_COLOR}.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
fi

# Setting Info.plist file path in project build settings
echo "\n${___PROJECTNAME____DEFAULT_TEXT_COLOR}Setting ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${___PROJECTNAME____DEFAULT_TEXT_COLOR} path to build settings in project."
if [ `sed -n '/INFOPLIST_FILE \= "___PROJECTNAME___\/Resources\/Info\.plist";/p' ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -gt 1 ]; then
	echo "${___PROJECTNAME____WARNING_TEXT_COLOR}Already set ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${___PROJECTNAME____WARNING_TEXT_COLOR} path to build settings in project.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
else
	sed -i '' -e '/\tINFOPLIST_FILE \=/d' ___PROJECTNAME___.xcodeproj/project.pbxproj
	sed -i '' -e 's/INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/INFOPLIST_FILE \= \"___PROJECTNAME___\/Resources\/Info.plist\";\n\t\t\t\tINFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/g' ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error setting ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${___PROJECTNAME____FAILURE_TEXT_COLOR} path to build settings in project.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${___PROJECTNAME____SUCCESS_TEXT_COLOR}Success setting ${___PROJECTNAME____FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${___PROJECTNAME____SUCCESS_TEXT_COLOR} path to build setting in project.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
fi

echo "\n${___PROJECTNAME____DEFAULT_TEXT_COLOR}Setting \"ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES\" flag to inherit in project build settings."
if [ `sed -n '/\tALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES \= /p' ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -lt 2 ]; then
	echo "${___PROJECTNAME____WARNING_TEXT_COLOR}Already set \"ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES\" flag to inherit in project build settings.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
else
	sed -i '' -e '/\tALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES \= /d' ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${___PROJECTNAME____FAILURE_TEXT_COLOR}Error setting \"ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES\" flag to inherit in project build settings.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${___PROJECTNAME____SUCCESS_TEXT_COLOR}Success setting \"ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES\" flag to inherit in project build settings.${___PROJECTNAME____DEFAULT_TEXT_COLOR}"
fi

echo "\n${___PROJECTNAME____WARNING_TEXT_COLOR}[!] This project is not supports multiple scenes. If you want to support multiple scenes, modify property \"UIApplicationSceneManifest\" in Info.plist and add SceneDelegate.\n${___PROJECTNAME____DEFAULT_TEXT_COLOR}"

unset_variables

pod repo update
pod install
