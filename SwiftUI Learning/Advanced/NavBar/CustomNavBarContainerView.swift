//
//  CustomNavBarContainerView.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 20/09/24.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View> : View {
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0){
            CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(CustomNavBarSubTitlePreferenceKey.self, perform: { value in
            self.subtitle = value
        })
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self, perform: { value in
            self.showBackButton = !value
        })
    }
}

#Preview {
    CustomNavBarContainerView{
        ZStack{
            Color.orange.ignoresSafeArea()
            Text("hello world")
                .foregroundStyle(Color.white)
                
        }
        .customNavigationTitle("Helloeoeoeoeo")
        .customNavigationSubTitle("Hell this is subtilte")
        
       
        
    }
}
