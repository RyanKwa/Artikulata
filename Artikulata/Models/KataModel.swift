//
//  ModulKata.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 05/07/22.
//

import Foundation

struct KataModel: Hashable{
    var imageName: String?
    var imageText: String?
    var word: Words?
    var wordCategory: WordCategories?
    
    
    func populateKataSifat() -> [KataModel] {
        let kataSifat = [
            KataModel(imageName: "Senang", imageText: "Senang", word: Words.Senang, wordCategory: WordCategories.KataSifat),
            KataModel(imageName: "Marah", imageText: "Marah", word: Words.Marah, wordCategory: WordCategories.KataSifat),
            KataModel(imageName: "Sedih", imageText: "Sedih", word: Words.Sedih, wordCategory: WordCategories.KataSifat)
        ]
        return kataSifat
    }
    
    func populateKataBenda() -> [KataModel] {
        let kataBenda = [
            KataModel(imageName: "Baju", imageText: "Baju", word: Words.Baju, wordCategory: WordCategories.KataBenda),
            KataModel(imageName: "Celana", imageText: "Celana", word: Words.Celana, wordCategory: WordCategories.KataBenda),
            KataModel(imageName: "Bangku", imageText: "Bangku", word: Words.Bangku, wordCategory: WordCategories.KataBenda)
        ]
        return kataBenda
    }
    
    func populateKataKerja() -> [KataModel] {
        let kataKerja = [
            KataModel(imageName: "Tidur", imageText: "Tidur", word: Words.Tidur, wordCategory: WordCategories.KataKerja),
            KataModel(imageName: "Makan", imageText: "Makan", word: Words.Makan, wordCategory: WordCategories.KataKerja),
            KataModel(imageName: "Minum", imageText: "Minum", word: Words.Minum, wordCategory: WordCategories.KataKerja)
        ]
        return kataKerja
    }
}
