//
//  sondsEffects.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 06/01/2026.
//

import SwiftUI
import AudioToolbox


import AVFoundation
import AVKit

final class SoundManager {

    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    private init() {}

    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error playing sound:", error.localizedDescription)
        }
    }
}




struct SystmeSoundEffectDemo: View {
    @State var playsoundCount: Int = 0
    @State var shouldPlay: Bool = false

    var body: some View {
        VStack (spacing: 30) {
            Text("playsoundCount: \(playsoundCount)")
            Text("shouldPlay: \(shouldPlay)")

            Button(action: {
                shouldPlay = true
                playsoundCount = playsoundCount + 1
            }, label: {
                Text("Play New Mail Forever")
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))
                
            })
            
            Button(action: {
                shouldPlay = false
            }, label: {
                Text("Stop")
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))

            })
            Button("Pay Borrower") {
                SoundManager.shared.playSound(named: "sound2")
            }

        }
        .fixedSize(horizontal: true, vertical: false)

        .onChange(of: playsoundCount) {
            let soundId:SystemSoundID = 1104
            AudioServicesPlaySystemSoundWithCompletion(soundId, {
                if shouldPlay {
                    playsoundCount = playsoundCount + 1
                }
            })

        }
    }
}
#Preview {
    SystmeSoundEffectDemo()
}
