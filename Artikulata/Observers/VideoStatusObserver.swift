//
//  VideoStatusObserver.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 22/06/22.
//

import Foundation


class VideoStatusObserver: ObservableObject{
    @Published var videoIsPlaying = true
    @Published var willStartPlaying = false
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.videoIsPlaying = false
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
