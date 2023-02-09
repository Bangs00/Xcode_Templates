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
	unset IS_SET_API_URL
	unset API_BASE_URL
	unset PLATFORM
}

unset_variables

FILE_PROJECT_COLOR='\033[0m\033[3;4;36m'
SUCCESS_TEXT_COLOR='\033[0m\033[0;32m'
FAILURE_TEXT_COLOR='\033[0m\033[0;31m'
WARNING_TEXT_COLOR='\033[0m\033[0;33m'
DEFAULT_TEXT_COLOR='\033[0;37m'

# Set platform in project build settings
echo "Which platform do you want to support in this project?\033[3;36m"
echo "1. iOS"
echo "2. iPad"
echo "3. iOS, iPad"
echo -n "${DEFAULT_TEXT_COLOR}> \033[0;36m"
read "PLATFORM?"

until [[ "$PLATFORM" =~ ^[123]$ ]]; do
	echo "${WARNING_TEXT_COLOR}[!] You must choose one of [1, 2, 3]"
	echo -n "${DEFAULT_TEXT_COLOR}> \033[0;36m"
	read "PLATFORM?"
done

sed -i '' -e "/\tSUPPORTED_PLATFORMS /d" ___PROJECTNAME___.xcodeproj/project.pbxproj
sed -i '' -e "/\tSUPPORTS_MACCATALYST /d" ___PROJECTNAME___.xcodeproj/project.pbxproj
sed -i '' -e "/\tSUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD /d" ___PROJECTNAME___.xcodeproj/project.pbxproj

if [[ "$PLATFORM" =~ ^[1]$ ]]; then # iOS
	echo "${DEFAULT_TEXT_COLOR}Platform: iOS"

	sed -i '' -e "s/SWIFT_EMIT_LOC_STRINGS/SUPPORTED_PLATFORMS \= \"iphoneos iphonesimulator\";\n\t\t\t\tSUPPORTS_MACCATALYST \= NO;\n\t\t\t\tSUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD \= YES;\n\t\t\t\tSWIFT_EMIT_LOC_STRINGS/g" ___PROJECTNAME___.xcodeproj/project.pbxproj
	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error setting supported platforms in project.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi
	sed -i '' -e "s/.*\tTARGETED_DEVICE_FAMILY .*/\t\t\t\tTARGETED_DEVICE_FAMILY \= 1;/g" ___PROJECTNAME___.xcodeproj/project.pbxproj
elif [[ "$PLATFORM" =~ ^[2]$ ]]; then # iPad
	echo "${DEFAULT_TEXT_COLOR}Platform: iPad"

	sed -i '' -e "s/SWIFT_EMIT_LOC_STRINGS/SUPPORTED_PLATFORMS \= \"iphoneos iphonesimulator\";\n\t\t\t\tSUPPORTS_MACCATALYST \= NO;\n\t\t\t\tSUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD \= YES;\n\t\t\t\tSWIFT_EMIT_LOC_STRINGS/g" ___PROJECTNAME___.xcodeproj/project.pbxproj
	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error setting supported platforms in project.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi
	sed -i '' -e "s/.*\tTARGETED_DEVICE_FAMILY .*/\t\t\t\tTARGETED_DEVICE_FAMILY \= 2;/g" ___PROJECTNAME___.xcodeproj/project.pbxproj
elif [[ "$PLATFORM" =~ ^[3]$ ]]; then # iOS, iPad
	echo "${DEFAULT_TEXT_COLOR}Platform: iOS, iPad"

	sed -i '' -e "s/.*\tTARGETED_DEVICE_FAMILY .*/\t\t\t\tTARGETED_DEVICE_FAMILY \= \"1,2\";/g" ___PROJECTNAME___.xcodeproj/project.pbxproj
fi

if [ $? -ne 0 ]; then
	echo "${FAILURE_TEXT_COLOR}Error setting supported platforms in project.${DEFAULT_TEXT_COLOR}"
	unset_variables
	exit 1
fi

echo "${SUCCESS_TEXT_COLOR}Success setting supported platforms in project.${DEFAULT_TEXT_COLOR}\n"
echo "${SUCCESS_TEXT_COLOR}[!] If you want to supprot Mac Catalyst, add destination to project targets.${DEFAULT_TEXT_COLOR}"

# Set API base URL in project build settings user-defined cateogry
if [ `sed -n "/API_BASE_URL \= /p" ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -gt 1 ]; then
	echo "\n${WARNING_TEXT_COLOR}Already set API base URL in project build settings user-defined category.${DEFAULT_TEXT_COLOR}"
else
	echo "\n${SUCCESS_TEXT_COLOR}[!] API base URL will set in project build setting user-defined category.${DEFAULT_TEXT_COLOR}\n"
	read "IS_SET_API_URL?Do you want to set API base URL in project build settings? (Y/[n]) "

	if [[ "$IS_SET_API_URL" =~ ^[Yy]$ ]]; then
		echo -n "Enter API base URL\n> \033[0m\033[4;36m"
		read "API_BASE_URL?"

		API_BASE_URL=${API_BASE_URL//\//\\/}
		API_BASE_URL=${API_BASE_URL//\*/\\*}
		sed -i '' -e '/API_BASE_URL \= /d' ___PROJECTNAME___.xcodeproj/project.pbxproj
		sed -i '' -e "s/ASSETCATALOG_COMPILER_APPICON_NAME/API_BASE_URL \= \"$API_BASE_URL\";\n\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME/g" ___PROJECTNAME___.xcodeproj/project.pbxproj
		
		if [ $? -ne 0 ]; then
			echo "${FAILURE_TEXT_COLOR}Error setting API base URL in project build settings user-defined category.${DEFAULT_TEXT_COLOR}"
			unset_variables
			exit 1
		fi
		
		echo "${SUCCESS_TEXT_COLOR}Success setting API base URL in project build settings user-defined category.${DEFAULT_TEXT_COLOR}\n"
		echo "${SUCCESS_TEXT_COLOR}[!] If you want to set urls to each configuration or scheme, change API_BASE_URL value in project build settings user-defined category.${DEFAULT_TEXT_COLOR}"
	fi
fi

# Removing AppDelegate.swift
echo "\n${DEFAULT_TEXT_COLOR}Removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${DEFAULT_TEXT_COLOR} file."
APPDELEGATE_FILE_UUID=`sed -n '/AppDelegate.swift/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj | head -n 1`

if [ -z "$APPDELEGATE_FILE_UUID" ]; then
	echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${FAILURE_TEXT_COLOR} file reference UUID not found from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
	exit 1
fi

if [ `sed -n '/AppDelegate.swift/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -lt 2 ]; then
	echo "${WARNING_TEXT_COLOR}Already ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${WARNING_TEXT_COLOR} file removed.${DEFAULT_TEXT_COLOR}"
else
	sed -i '' -e "/$APPDELEGATE_FILE_UUID/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${FAILURE_TEXT_COLOR} file reference from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	rm -rf ___PROJECTNAME___/AppDelegate.swift

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${FAILURE_TEXT_COLOR} file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${SUCCESS_TEXT_COLOR} file.${DEFAULT_TEXT_COLOR}"
fi

# Removing ContentView.swift
echo "\n${DEFAULT_TEXT_COLOR}Removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${DEFAULT_TEXT_COLOR} file."
if [ ! -f "___PROJECTNAME___/ContentView.swift" ]; then
	echo "${WARNING_TEXT_COLOR}Already ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${WARNING_TEXT_COLOR} file removed.${DEFAULT_TEXT_COLOR}"
else
	sed -i '' -e '/ContentView.swift/d' ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${FAILURE_TEXT_COLOR} file reference from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	rm -rf ___PROJECTNAME___/ContentView.swift

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${FAILURE_TEXT_COLOR} file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${SUCCESS_TEXT_COLOR} file.${DEFAULT_TEXT_COLOR}"
fi

# Moving Assets.xcassets
echo "\n${DEFAULT_TEXT_COLOR}Moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${DEFAULT_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets${DEFAULT_TEXT_COLOR}."
if [ ! -d "./___PROJECTNAME___/Assets.xcassets" ]; then
	echo "${WARNING_TEXT_COLOR}Already ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${WARNING_TEXT_COLOR} file moved to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets${WARNING_TEXT_COLOR}.${DEFAULT_TEXT_COLOR}"
else
	ASSETS_FILE_UUID=`sed -n '/Assets.xcassets/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj`

	if [ -z "$ASSETS_FILE_UUID" ]; then
		echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file reference UUID not found from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	ASSETS_FILE_REF_STRING=`sed -n "/$ASSETS_FILE_UUID \/\* Assets.xcassets \*\/,/p" ___PROJECTNAME___.xcodeproj/project.pbxproj`
	ASSETS_FILE_REF_STRING=${ASSETS_FILE_REF_STRING//\//\\/}
	ASSETS_FILE_REF_STRING=${ASSETS_FILE_REF_STRING//\*/\\*}

	if [ -z "$ASSETS_FILE_REF_STRING" ]; then
		echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file reference group line not found from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	sed -i '' -e "/$ASSETS_FILE_REF_STRING/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file reference group line from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	sed -i '' -e "s/Info.plist \*\/,/Info.plist \*\/,\n$ASSETS_FILE_REF_STRING/g" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error adding ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file reference group line from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	mv ___PROJECTNAME___/Assets.xcassets ___PROJECTNAME___/Resources/Assets.xcassets

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${FAILURE_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets${FAILURE_TEXT_COLOR}.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Assets.xcassets${SUCCESS_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Assets.xcassets${SUCCESS_TEXT_COLOR}.${DEFAULT_TEXT_COLOR}"
fi

# Moving LaunchScreen.storyboard
echo "\n${DEFAULT_TEXT_COLOR}Moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${DEFAULT_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard${DEFAULT_TEXT_COLOR}."

if [ ! -d "./___PROJECTNAME___/Base.lproj" ]; then
	echo "${WARNING_TEXT_COLOR}Already ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${WARNING_TEXT_COLOR} file moved to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard${WARNING_TEXT_COLOR}.${DEFAULT_TEXT_COLOR}"
else
	LAUNCHSCREEN_FILE_UUID=`sed -n '/LaunchScreen.storyboard/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj`

	if [ -z "$LAUNCHSCREEN_FILE_UUID" ]; then
		echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file reference UUID not found from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	LAUNCHSCREEN_FILE_REF_STRING=`sed -n "/$LAUNCHSCREEN_FILE_UUID \/\* LaunchScreen.storyboard \*\/,/p" ___PROJECTNAME___.xcodeproj/project.pbxproj`
	LAUNCHSCREEN_FILE_REF_STRING=${LAUNCHSCREEN_FILE_REF_STRING//\//\\/}
	LAUNCHSCREEN_FILE_REF_STRING=${LAUNCHSCREEN_FILE_REF_STRING//\*/\\*}

	if [ -z "$LAUNCHSCREEN_FILE_REF_STRING" ]; then
		echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file reference group line not found from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	sed -i '' -e "/$LAUNCHSCREEN_FILE_REF_STRING/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file reference group line from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	sed -i '' -e "s/Info.plist \*\/,/Info.plist \*\/,\n$LAUNCHSCREEN_FILE_REF_STRING/g" ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error adding ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file reference group line from project file.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	mv ___PROJECTNAME___/Base.lproj ___PROJECTNAME___/Resources/Base.lproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${FAILURE_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard${FAILURE_TEXT_COLOR}.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success moving ${FILE_PROJECT_COLOR}___PROJECTNAME___/Base.lproj/LaunchScreen.storyboard${SUCCESS_TEXT_COLOR} file to ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Base.lproj/LaunchScreen.storyboard${SUCCESS_TEXT_COLOR}.${DEFAULT_TEXT_COLOR}"
fi

# Setting Info.plist file path in project build settings
echo "\n${DEFAULT_TEXT_COLOR}Setting ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${DEFAULT_TEXT_COLOR} path to build settings in project."
if [ `sed -n '/INFOPLIST_FILE \= "___PROJECTNAME___\/Resources\/Info\.plist";/p' ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -gt 1 ]; then
	echo "${WARNING_TEXT_COLOR}Already set ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${WARNING_TEXT_COLOR} path to build settings in project.${DEFAULT_TEXT_COLOR}"
else
	sed -i '' -e '/\tINFOPLIST_FILE \=/d' ___PROJECTNAME___.xcodeproj/project.pbxproj
	sed -i '' -e 's/INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/INFOPLIST_FILE \= \"___PROJECTNAME___\/Resources\/Info.plist\";\n\t\t\t\tINFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/g' ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error setting ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${FAILURE_TEXT_COLOR} path to build settings in project.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success setting ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${SUCCESS_TEXT_COLOR} path to build setting in project.${DEFAULT_TEXT_COLOR}"
fi

echo "\n${DEFAULT_TEXT_COLOR}Setting \"ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES\" flag to inherit in project build settings."
if [ `sed -n '/\tALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES \= /p' ___PROJECTNAME___.xcodeproj/project.pbxproj | wc -l` -lt 2 ]; then
	echo "${WARNING_TEXT_COLOR}Already set \"ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES\" flag to inherit in project build settings.${DEFAULT_TEXT_COLOR}"
else
	sed -i '' -e '/\tALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES \= /d' ___PROJECTNAME___.xcodeproj/project.pbxproj

	if [ $? -ne 0 ]; then
		echo "${FAILURE_TEXT_COLOR}Error setting \"ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES\" flag to inherit in project build settings.${DEFAULT_TEXT_COLOR}"
		unset_variables
		exit 1
	fi

	echo "${SUCCESS_TEXT_COLOR}Success setting \"ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES\" flag to inherit in project build settings.${DEFAULT_TEXT_COLOR}"
fi

echo "\n${SUCCESS_TEXT_COLOR}[!] This project template is not supports multiple scenes. If you want to support multiple scenes, modify property \"UIApplicationSceneManifest\" in Info.plist and add SceneDelegate.\n${DEFAULT_TEXT_COLOR}"

unset_variables

pod repo update
pod install
