//
//  UIViewControllerPrc.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 05/10/24.
//

import SwiftUI
// basically UIViewController is used to convert a while ui view thats a controller indirectly into swiftUI.. the one we did previously was for specific views liek Text,image etc etc that can be done using uiviewRepresentable......


struct UIViewControllerPrc: View {
    @State private var showScreen: Bool = false
    var body: some View {
        VStack{
            Text("hi")
            Button(action: {
                showScreen.toggle()
            }, label: {
                Text("Click here")
            })
            .sheet(isPresented: $showScreen, content: {
                BasicUIViewControllerRepresentable(labelText: "This is my next texrt")
            })
        }
    }
}

#Preview {
    UIViewControllerPrc()
}


struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    let labelText:String
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        
        // Add a label
        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.white
        
        vc.view.addSubview(label)
        label.frame = vc.view.frame
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


// protocol - simple set of rules or requurements that a class or struct need to have
//  for example: Creating a new view... Ek struct banata hai jisee we confirm to View... And the requirement of view protocol is that the struct hava a body
