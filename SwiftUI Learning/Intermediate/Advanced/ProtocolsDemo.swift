//
//  ProtocolsDemo.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 05/10/24.
//

import SwiftUI

// Suppose now we want a new color theme an alternate color theme mayber for a new user ro for specific amount pf user...
// one way is to make a new struct and intialize it and then use it.

// Purpose

// -------------------------------------------------//
struct DefaultColorTheme : ColorThemeProtocol {
    let primary : Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternateColorTheme: ColorThemeProtocol {
    let primary : Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .blue
    var secondary: Color = .red
    var tertiary: Color = .purple
    
    
}

protocol ColorThemeProtocol {
    var primary: Color { get  }
    var secondary: Color { get }
    var tertiary: Color { get }
}

// -------------------------------------------------//

protocol ButtonTextProtocol {
    // Requirements
    var buttonText: String { get }
    
    // Functions
//    func buttonPressed()
}
protocol ButtonPressedProtocol {
    func buttonPressed()
}

// Protocol Inheritance
protocol ButtonDataSouceProtocol: ButtonTextProtocol, ButtonPressedProtocol{
    
}

class DefaultDataSource: ButtonDataSouceProtocol {
    var buttonText: String = "Protocols are awesome"
    func buttonPressed() {
        print("Button was tapped")
    }
}

class AlternateDataSource : ButtonTextProtocol {
    
    var buttonText: String = "Protocols are lame"
    
}
// -------------------------------------------------//

struct ProtocolsDemo: View {
//    let colorTheme: DefaultColorTheme = DefaultColorTheme()
//    let colorTheme: AlternateColorTheme = AlternateColorTheme()
    
    // Now using protocol....
    let colorTheme: ColorThemeProtocol
    
    let dataSource: ButtonDataSouceProtocol
    
    var body: some View {
        ZStack{
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundStyle(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsDemo(colorTheme: DefaultColorTheme(), dataSource: DefaultDataSource())
}
