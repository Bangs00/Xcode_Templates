//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

final class AppAppearance {
    static func setupAppearance() {
        // Set NavigationBar Appearance
        if #available(iOS 15, *) {
//            let navigationBarAppearance = UINavigationBarAppearance()
//            navigationBarAppearance.configureWithOpaqueBackground()
//            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            navigationBarAppearance.backgroundColor = UIColor(red: 37/255.0, green: 37/255.0, blue: 37.0/255.0, alpha: 1.0)
//            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        } else {
//            UINavigationBar.appearance().barTintColor = .black
//            UINavigationBar.appearance().tintColor = .white
//            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        // Set TabBar Appearance
        if #available(iOS 15, *) {
//            let tabBarAppearance = UITabBarAppearance()
//            tabBarAppearance.configureWithOpaqueBackground()
//            tabBarAppearance.backgroundColor = UIColor.white
//
//            UITabBar.appearance().standardAppearance = tabBarAppearance
//            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//            UITabBar.appearance().tintColor = .Custom.gray_1
//            UITabBar.appearance().unselectedItemTintColor = .Custom.gray_4
        }
        // Set TabBar Tint Color here
//        UITabBar.appearance().tintColor = CUSTOM_TINT_COLOR
//        UITabBar.appearance().unselectedItemTintColor = CUSTOM_UNSELETED_TINT_COLOR
    }
}
