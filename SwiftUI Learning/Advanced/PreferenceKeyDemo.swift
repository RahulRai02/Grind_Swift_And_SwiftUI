//
//  PreferenceKeyDemo.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 09/09/24.
//

import SwiftUI

struct PreferenceKeyDemo: View {
    
    @State private var text: String = "Hello, World!"
    
    var body: some View {
        NavigationView{
            VStack{
                SecondaryScreen(text: text) // PAssing from parent level to child level
            }
            .navigationTitle("Navigation Title")    // But navigationTitle changes passes from child level to parent level. Basically it passes the text to NavigationView...
            .customTitle("hellow this is rahul ")
//            .preference(key: CustomTitlePreferenceKey.self, value: "New value")
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        })
    
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        self
        .preference(key: CustomTitlePreferenceKey.self, value: text)    }
}


#Preview {
    PreferenceKeyDemo()
}


struct SecondaryScreen: View{
    let text: String
    var body: some View{
        Text(text)
//            .preference(key: CustomTitlePreferenceKey.self, value: "New value")
        
        // So basucally we dont even have a reference from the child to parent but we are able to do this because we have set up the prefern ekey, so if it changes it passes the new value to the parent and the vciew changes ....
    }
}

// How .navigationTitle works?? We are creating a preference key, therefore we are able to pass it from child to parent

// The preference key will be a global level key....
struct CustomTitlePreferenceKey: PreferenceKey {
    
    // Initially kya value rhegi, for ex in nav title its an empty string be default
    // so if you dont provide it the title will be empty
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        // inout -> Will get this value as a string and will return down the string as well
        
        value = nextValue()
    }
    
    
}
