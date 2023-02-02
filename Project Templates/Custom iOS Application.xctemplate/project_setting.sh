app_delegate_file_uuid=`sed -n '/AppDelegate.swift/{s/.*fileRef \= \(.*/) \/.*/\1/p;}' ___PROJECTNAME___.xcodeproj/project.pbxproj | head -n 1`
sed -i '' -e "/$app_delegate_file_uuid/d" ___PROJECTNAME___.xcodeproj/project.pbxproj
rm -rf ___PROJECTNAME___/AppDelegate.swift
echo "Removing AppDelegate.swift file complete"
sed -i '' -e '/ContentView.swift/d' ___PROJECTNAME___.xcodeproj/project.pbxproj
rm -rf ___PROJECTNAME___/ContentView.swift
echo "Removing ContentView.swift file complete"
sed -i '' -e 's/INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/INFOPLIST_FILE\="___PROJECTNAME___\/Resources\/Info.plist";\n\t\t\t\tINFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents/g' ___PROJECTNAME___.xcodeproj/project.pbxproj
echo "Setting Info.plist path to build settings in project"
pod repo update
pod install
