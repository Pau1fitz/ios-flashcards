//
//  TranslationStore.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import Foundation
import SwiftUI

class TranslationsStore: ObservableObject {
    @Published var translations: [TranslatedItem] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("translations.data")
    }
    
    static func load(completion: @escaping (Result<[TranslatedItem], Error>)->Void) {
         DispatchQueue.global(qos: .background).async {
             do {
                 let fileURL = try fileURL()
                 guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                     DispatchQueue.main.async {
                         completion(.success([]))
                     }
                     return
                 }
                 let dailyScrums = try JSONDecoder().decode([TranslatedItem].self, from: file.availableData)
                 DispatchQueue.main.async {
                     completion(.success(dailyScrums))
                 }
             } catch {
                 DispatchQueue.main.async {
                     completion(.failure(error))
                 }
             }
         }
     }
    
    static func save(translatedItems: [TranslatedItem], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(translatedItems)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(translatedItems.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
