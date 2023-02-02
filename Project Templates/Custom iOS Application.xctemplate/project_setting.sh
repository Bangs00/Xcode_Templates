FILE_PROJECT_COLOR='\033[0m\033[3;4;36m'
SUCCESS_TEXT_COLOR='\033[0m\033[1;32m'
FAILURE_TEXT_COLOR='\033[0m\033[1;31m'
DEFAULT_TEXT_COLOR='\033[0;37m'

echo "${DEFAULT_TEXT_COLOR}Removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${DEFAULT_TEXT_COLOR} file"
unset app_delegate_file_uuid
app_delegate_file_uuid=`sed -n '/AppDelegate.swift/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj | head -n 1`

if [ -z "$app_delegate_file_uuid" ]; then
	echo "${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${FAILURE_TEXT_COLOR} file reference UUID not found from project file"
	exit 1
fi

sed -i '' -e "/$app_delegate_file_uuid/d" ___PROJECTNAME___.xcodeproj/project.pbxproj

if [ $? -ne 0 ]; then
	echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${FAILURE_TEXT_COLOR} file reference from project file"
	exit 1
fi

rm -rf ___PROJECTNAME___/AppDelegate.swift

if [ $? -ne 0 ]; then
	echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${FAILURE_TEXT_COLOR} file"
	exit 1
fi

echo "${SUCCESS_TEXT_COLOR}Success removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/AppDelegate.swift${SUCCESS_TEXT_COLOR} file"

echo "${DEFAULT_TEXT_COLOR}Removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${DEFAULT_TEXT_COLOR} file"
sed -i '' -e '/ContentView.swift/d' ___PROJECTNAME___.xcodeproj/project.pbxproj

if [ $? -ne 0 ]; then
	echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${FAILURE_TEXT_COLOR} file reference from project file"
	exit 1
fi

rm -rf ___PROJECTNAME___/ContentView.swift

if [ $? -ne 0 ]; then
	echo "${FAILURE_TEXT_COLOR}Error removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${FAILURE_TEXT_COLOR} file"
	exit 1
fi

echo "${SUCCESS_TEXT_COLOR}Success removing ${FILE_PROJECT_COLOR}___PROJECTNAME___/ContentView.swift${SUCCESS_TEXT_COLOR} file"

echo "${DEFAULT_TEXT_COLOR}Setting ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${DEFAULT_TEXT_COLOR} path to build settings in project"
sed -i '' -e 's/INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/INFOPLIST_FILE\="___PROJECTNAME___\/Resources\/Info.plist";\n\t\t\t\tINFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/g' ___PROJECTNAME___.xcodeproj/project.pbxproj

if [ $? -ne 0 ]; then
	echo "${FAILURE_TEXT_COLOR}Error setting ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${FAILURE_TEXT_COLOR} path to build settings in project"
	exit 1
fi

echo "${SUCCESS_TEXT_COLOR}Success setting ${FILE_PROJECT_COLOR}___PROJECTNAME___/Resources/Info.plist${SUCCESS_TEXT_COLOR} path to build setting in project${DEFAULT_TEXT_COLOR}"

unset FILE_PROJECT_COLOR
unset SUCCESS_TEXT_COLOR
unset FAILURE_TEXT_COLOR
unset DEFAULT_TEXT_COLOR
unset app_delegate_file_uuid

pod repo update
pod install
