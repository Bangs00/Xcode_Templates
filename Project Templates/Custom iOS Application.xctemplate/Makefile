init:
	sed -i '' -e '/ContentView.swift/d' ___PROJECTNAME___.xcodeproj/project.pbxproj
	rm -rf ___PROJECTNAME___/ContentView.swift
	pod repo update
	pod install
