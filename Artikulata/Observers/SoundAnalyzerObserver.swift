//
//  SoundAnalyzerObserver.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 22/06/22.
//

import Foundation
import SoundAnalysis

class SoundAnalyzerObserver: NSObject, ObservableObject, SNResultsObserving {

    @Published var navigateToNextView = false

    private var currentWord: String = ""
    
    init(currentWord: String) {
        self.currentWord = currentWord
    }

    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult else{
            return
        }
        //ambil first result
        guard let highestResult = result.classifications.first else{
            return
        }
        DispatchQueue.main.async {
            if(self.currentWord == highestResult.identifier){
                self.navigateToNextView = true
                return
            }
        }
    }
    
}
