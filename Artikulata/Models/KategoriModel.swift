//
//  ModulKategori.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 05/07/22.
//

import Foundation

struct KategoriModel: Hashable {
    var kategoriImage: String?
    var kategoriKata: WordCategories?
    var modulKata = KataModel()
    var kataDalamKategori: [KataModel]?
    
    func populateModulKategori() -> [KategoriModel] {
        let kategoriKata = [
            KategoriModel(kategoriImage: "Kata-benda", kategoriKata: WordCategories.KataBenda, kataDalamKategori: modulKata.populateKataBenda()),
            KategoriModel(kategoriImage: "Kata-sifat", kategoriKata: WordCategories.KataSifat, kataDalamKategori: modulKata.populateKataSifat()),
            KategoriModel(kategoriImage: "Kata-kerja", kategoriKata: WordCategories.KataKerja, kataDalamKategori: modulKata.populateKataKerja())
        ]
        return kategoriKata
    }
}
