//
//  TranslationListView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import SwiftUI
import Alamofire

struct Post: Encodable {
    let q: String
    let source: String
    let target: String
}

struct TranslatedItem: Identifiable, Codable {
    let id: UUID
    var english: String
    var portuguese: String
    
    init(id: UUID = UUID(), english: String, portuguese: String) {
        self.id = id
        self.english = english
        self.portuguese = portuguese
    }
}

struct TranslationListView: View {
    @State private var translatedTextRequest: String = ""
    @State private var translation: String? = nil
    
    @Binding var translations: [TranslatedItem]
    let saveAction: ()->Void
    
    func translateData() {
        let translationRequest = Post(q: translatedTextRequest, source: "en", target: "pt")
        AF.request(
            "https://translate.terraprint.co/translate",
            method: .post,
            parameters: translationRequest,
            encoder: JSONParameterEncoder.default).response { response in
                switch response.result {
                    case let .success(value):
                        do {
                            let json = try JSONSerialization.jsonObject(with: value!, options: [])
                            if let dict = json as? [String: Any],
                            let translatedText = dict["translatedText"] as? String {
                                print("translated text")
                                print(translatedText)
                                print("translated text")
                                self.translation = translatedText
                                translations.append(TranslatedItem(id: UUID(), english: translatedTextRequest, portuguese: translatedText))
                                saveAction()
                                self.translatedTextRequest = ""
                            } else {
                                print("Invalid response format")
                            }
                        } catch {
                            print("Error decoding response: \(error)")
                    }

                    case let .failure(error):
                        print(error)
                }
            }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack (alignment: .top) {
                TextField("Translate...", text: $translatedTextRequest)
                    .frame(height: 60.0, alignment: .top)
                    .padding()
            }
            HStack {
                Spacer()
                Button("Translate") {
                    translateData()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            
    
            List(translations, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(item.english)
                        .fontWeight(.heavy)
                    Text(item.portuguese)
                        .opacity(0.8)
                }
            }
            Spacer()
        }
    }
}

