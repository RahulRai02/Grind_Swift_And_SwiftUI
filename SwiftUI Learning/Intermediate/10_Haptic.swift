//
//  10_Haptic.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 28/08/24.
//

import SwiftUI

class HapticManager{
    // Make an one and only single instance of the haptic manager, so that it can be accessed thruout the view
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}


struct _0_Haptic: View {
    var body: some View {
        VStack{
            Button("Success"){
                HapticManager.instance.notification(type: .success)
            }
            Button("Warning"){
                HapticManager.instance.notification(type: .warning)
            }
            Button("Error"){
                HapticManager.instance.notification(type: .error)
            }
            
            Divider()
            
            Button("Soft"){
                HapticManager.instance.impact(style: .soft)
            }
            Button("Medium"){
                HapticManager.instance.impact(style: .medium)
            }
            Button("Light"){
                HapticManager.instance.impact(style: .light)
            }
            Button("Rigid"){
                HapticManager.instance.impact(style: .rigid)
            }
            Button("Heavy"){
                HapticManager.instance.impact(style: .heavy)
            }
        }
    }
}

#Preview {
    _0_Haptic()
}
