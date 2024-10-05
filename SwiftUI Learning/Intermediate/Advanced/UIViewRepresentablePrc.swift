//
//  UIViewRepresentablePrc.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 05/10/24.
//

import SwiftUI

/*
1. UIViewRepresentable - Used to convert UIView in UIKit to SwiftUI
2. makeUIView is the first function that is called on the intialization of BasicUIViewRepresentable
3. CHALLENEGE: To send UIKit data to and from uiview to swiftui
 
4. Suppose you have a swiftui textfield, you want to change the text color of the placeholder but you cant do it using swiftui. BUt you can do it using UIKIT. Thats an exmaple for point 3
*/
struct UIViewRepresentablePrc: View {
    @State private var text: String  = ""
    var body: some View {
        VStack{
            Text(text)
            TextField("Type here ....", text: $text)
                .frame(height: 55)
                .background(Color.gray)
            UITextFieldViewRepresentable(text: $text)
                .updatePlaceholder("eerugeurbue")
                .frame(height: 55)
                .background(Color.gray)
                
            
//            BasicUIViewRepresentable()
        }
        
    }
}

#Preview {
    UIViewRepresentablePrc()
}

struct UITextFieldViewRepresentable: UIViewRepresentable{
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String = "Default placeholder...", placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField =  getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    // update is used to send data from swiftui to uikit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        
        let placeholder = NSAttributedString(string: placeholder,
                                             attributes: [
                                                .foregroundColor: placeholderColor
                                             ])
        
        textField.attributedPlaceholder = placeholder
        return textField
    }
    func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
            var viewRepresentable = self    // self refers to the main struct UITexrViewReprestabnle
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    
    // Coordinate change from uikit to swiftui. for ex idhar we are returning text
    // From uikit to swiftui
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
     
    class Coordinator: NSObject, UITextFieldDelegate{
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
    
}


struct BasicUIViewRepresentable : UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
