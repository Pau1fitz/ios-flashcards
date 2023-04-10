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

struct TranslationListView: View {
    @State private var translatedTextRequest: String = ""
    @State private var translation: String? = nil
    
    @Binding var translations: [TranslatedItem]
    @Binding var currentIndex: Int
    let saveAction: ()->Void
    
    func translateData() {
        if self.translatedTextRequest != "" {
            let translationRequest = Post(q: translatedTextRequest, source: "pt", target: "en")
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
                                    self.translation = translatedText
                                    translations.append(TranslatedItem(id: UUID(), english: translatedText, portuguese: translatedTextRequest))
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
    }

    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack (alignment: .top) {
                TextEditor(text: $translatedTextRequest)
                    .font(.system(size: 14))
                    .frame(height: 100.0)
                    .frame(maxHeight: 100.0)
                    
            }
            .padding(8.0)
            
            HStack {
                Spacer()
                Button("Translate") {
                    translateData()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            
            Divider()
            
            List {
                   ForEach(translations, id: \.id) { item in
                       VStack(alignment: .leading) {
                           Text(item.portuguese)
                               .fontWeight(.heavy)
                               .font(.system(size: 14))
                               .offset(x: 12.0)
                               
                           Text(item.english)
                               .opacity(0.8)
                               .font(.system(size: 12))
                               .offset(x: 12.0)
                       }
                       .padding(.vertical, 6.0)
                   }
                   .onDelete { indexSet in
                       translations.remove(atOffsets: indexSet)
                       currentIndex = 0
                       saveAction()
                    }
                   .listRowInsets(EdgeInsets())
               }
               .listStyle(PlainListStyle())
            
            Spacer()
        }
    }
}

