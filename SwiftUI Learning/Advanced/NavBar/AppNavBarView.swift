//
//  AppNavBarView.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 18/09/24.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack{
                Color.orange.ignoresSafeArea()
                CustomNavLink {
                    Text("Destination")
                        .customNavigationTitle("2nd Screen title")
                        .customNavigationSubTitle("2nd screen subs")
                } label: {
                    Text("Navigate")
                }

            }
            .customNavigationTitle("Hellosss world")
            .customNavigationSubTitle("this is my subtitle")
            .customNavigationBarBackButtonHidden(true)
        }
        
//        NavigationView{
//            ZStack{
//                Color.green.ignoresSafeArea()
//                
//                NavigationLink(destination: Text("Destination")) {
//                    Text("Navigate")
//                }
//            }
//            .navigationTitle("Nav title here")
//        }
    }
}

#Preview {
    AppNavBarView()
}
