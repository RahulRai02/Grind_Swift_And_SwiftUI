//
//  9_Sounds.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 28/08/24.
//

import SwiftUI
import AVKit

class SoundManager{
    // Create only one single instance of the sound manager
    // so that it can be accessed throughout the app...
    
    // Dont create the isntance in view, because if we did we will initialize it everytime whenever the view refreshes....
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String{
        case Sound1
        case Sound2
    }
    
    
    func playSound(sound: SoundOption){
        guard let soundURL = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else{
            return
        }
        
        do{
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        }catch let error{
            print("Error in playing sound: \(error)")
        }
    }
    
    func stopSound(){
        player?.stop()
    }
    
}


struct __Sounds: View {
    var body: some View {
        VStack(spacing: 40){
            Button("Play Sound 1"){
                SoundManager.instance.playSound(sound: .Sound1)
            }
            Button("Play Sound 2"){
                SoundManager.instance.playSound(sound: .Sound2)
            }
            Button("Stop Sound"){
                SoundManager.instance.stopSound()
            }
        }
        
    }
}

#Preview {
    __Sounds()
}
