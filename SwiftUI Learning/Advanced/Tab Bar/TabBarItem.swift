//
//  TabBarItem.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 18/09/24.
//

import Foundation
import SwiftUI
//
//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, favorites, profile
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favorites:
            return "Favorites"
        case .profile:
            return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return Color.red
        case .favorites:
            return Color.green
        case .profile:
            return Color.blue
        }
    }
}

//
//static let tabs: [TabBarItem] = [
//    TabBarItem(iconName: "house", title: "Home", color: Color.red),
//    TabBarItem(iconName: "heart", title: "Favorites", color: Color.green),
//    TabBarItem(iconName: "person", title: "Profile", color: Color.blue)
//]
