//
//  VideoStatusObserver.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 22/06/22.
//

import Foundation


class VideoStatusObserver: ObservableObject{
    @Published var willStartPlaying = true
    @Published var videoTriggered = true
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.willStartPlaying = false
        self.videoTriggered = true
    }
    
    deinit{
        print("VIDEO DEINIT")
        NotificationCenter.default.removeObserver(self)
    }
}
