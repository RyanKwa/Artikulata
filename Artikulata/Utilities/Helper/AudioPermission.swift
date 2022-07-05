//
//  AudioPermission.swift
//  Artikulata
//
//  Created by Evelin Evelin on 29/06/22.
//

import Foundation
import AVFoundation

class AudioPermission {
    func requestPermission(){
        switch AVAudioSession.sharedInstance().recordPermission {
            case .granted:
                print("Permission granted")
            case .denied:
                print("Permission denied")
            case .undetermined:
                print("Request permission here")
                AVAudioSession.sharedInstance().requestRecordPermission({ granted in
                    // Handle granted
                })
            @unknown default:
                print("Unknown case")
            }
    }
}
