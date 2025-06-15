//
//  AVPlayerExtension.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/21/25.
//

import Foundation
import AVFoundation

var backgroundAudioPlayer: AVAudioPlayer? // Must be an optional

func startBackgroundSound(musicFileName: String) {
	if let player = backgroundAudioPlayer, player.isPlaying {return}
 
	if let bundle = Bundle.main.path(forResource: musicFileName, ofType: "mp3") {
		let backgroundSound = NSURL(fileURLWithPath: bundle)
		do {
			backgroundAudioPlayer = try AVAudioPlayer(contentsOf: backgroundSound as URL)
			try AVAudioSession.sharedInstance().setCategory(.playback)
			guard let backgroundAudioPlayer = backgroundAudioPlayer else { return }
			backgroundAudioPlayer.numberOfLoops = -1
			backgroundAudioPlayer.setVolume(0.1, fadeDuration: 0)
			backgroundAudioPlayer.prepareToPlay()
			backgroundAudioPlayer.play()
		} catch {
			print(error)
		}
	}
}


func stopBackgroundSound() {
	guard let backgroundAudioPlayer = backgroundAudioPlayer else {return}
	backgroundAudioPlayer.stop()
}
