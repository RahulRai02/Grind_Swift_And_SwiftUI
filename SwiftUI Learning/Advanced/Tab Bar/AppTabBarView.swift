//
//  AppTabBarView.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 17/09/24.
//


// How to make the custom Tab bar
// Generics, ViewBuilder, Preference Key, MatchedGeometry Effect (Neeeded all these)

import SwiftUI

struct AppTabBarView: View {
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.blue
                .tabBarItem(tab: .home,
                            selection: $tabSelection)
            Color.red
                .tabBarItem(tab: .favorites,
                            selection: $tabSelection)
            Color.green
                .tabBarItem(tab: .profile,
                            selection: $tabSelection)
        }
    }
}




//extension AppTabBarView {
//    private var defaultTabView: some View {
//        TabView(selection: $selection){
//            Color.red
//                .tabItem {
//                    Image(systemName: "house")
//                    Text("Home")
//                }
//            
//            Color.green
//                .tabItem {
//                    Image(systemName: "heart")
//                    Text("Favorites")
//                }
//            
//            Color.blue
//                .tabItem {
//                    Image(systemName: "person")
//                    Text("Profile")
//                }
//        }
//    }
//}


struct AppTabBarView_Previews : PreviewProvider {
    static let tabs: [TabBarItem] = [
        .home, .favorites, .profile
    ]
    static var previews: some View{
        AppTabBarView()
    }
}
