echo "\033[0;31mRemoving \033[4;32m___PROJECTNAME___/AppDelegate.swift\033[0;31m file"
app_delegate_file_uuid=`sed -n '/AppDelegate.swift/{s/.*fileRef \= \(.*\) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj | head -n 1`
sed -i '' -e "/$app_delegate_file_uuid/d" ___PROJECTNAME___.xcodeproj/project.pbxproj
rm -rf ___PROJECTNAME___/AppDelegate.swift

echo "Removing \033[4;32m___PROJECTNAME___/ContentView.swift\033[0;31m file"
sed -i '' -e '/ContentView.swift/d' ___PROJECTNAME___.xcodeproj/project.pbxproj
rm -rf ___PROJECTNAME___/ContentView.swift

echo "\033[0;37mSetting \033[4;32m___PROJECTNAME___/Resources/Info.plist\033[0;37m path to build settings in project"
sed -i '' -e 's/INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/INFOPLIST_FILE\="___PROJECTNAME___\/Resources\/Info.plist";\n\t\t\t\tINFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/g' ___PROJECTNAME___.xcodeproj/project.pbxproj

pod repo update
pod install
