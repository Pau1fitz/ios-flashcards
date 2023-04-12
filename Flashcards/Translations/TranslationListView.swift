//
//  TranslationListView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import SwiftUI
import Alamofire

struct TranslationListView: View {
    @State private var translatedTextRequest: String = ""
    @State private var translation: String? = nil
    
    @Binding var translations: [TranslatedItem]
    @Binding var currentIndex: Int
    let saveAction: () -> Void
    
    @FocusState private var isTextFieldFocused: Bool
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func translateData() {
        if self.translatedTextRequest != "" {
            let parameters: Parameters = ["text": translatedTextRequest, "target_lang": "EN"]
            let headers: HTTPHeaders = [
                "Authorization": Bundle.main.infoDictionary?["API_KEY"] as! String,
                "Accept": "application/json"
            ]
            
            AF.request(
                 "https://api-free.deepl.com/v2/translate",
                 method: .post,
                 parameters: parameters,
                 headers: headers
             ).response { response in
                 switch response.result {
                     case let .success(value):
                         do {
                             let json = try JSONSerialization.jsonObject(with: value!, options: [])
                             if let jsonDict = json as? [String: Any] {
                             if let translationsArray = jsonDict["translations"] as? [[String: Any]] {
                                 if let firstTranslationDict = translationsArray.first {
                                     if let translatedText = firstTranslationDict["text"] as? String {
                                         self.translation = translatedText
                                         translations.insert(TranslatedItem(id: UUID(), english: translatedText, portuguese: translatedTextRequest), at: 0)
                                         saveAction()
                                         self.translatedTextRequest = ""
                                     }
                                 }
                             }
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
        ZStack {
            VStack(alignment: .leading) {
                Divider()
                
                ZStack(alignment: .leading) {
                    HStack (alignment: .top) {
                        TextEditor(text: $translatedTextRequest)
                            .focused($isTextFieldFocused)
                            .font(.system(size: 16.0))
                            .frame(height: 100.0)
                            .frame(maxHeight: 100.0)
                    }
                    .padding(8.0)
                    
                    if self.translatedTextRequest == "" {
                        HStack (alignment: .top) {
                            Text("Translate...")
                                .font(.system(size: 16.0))
                        }
                        .padding(8.0)
                        .offset(x: 6.0, y: -32.0)
                    }
                }
                
                HStack {
                    Spacer()
                    Button("Translate") {
                        translateData()
                        hideKeyboard()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.black)
                }
                .padding(.horizontal)
                
                Divider()
                
                List {
                   ForEach(translations, id: \.id) { item in
                       VStack(alignment: .leading) {
                           Text(item.portuguese)
                               .fontWeight(.heavy)
                               .font(.system(size: 16.0))
                               .offset(x: 12.0)
                                   
                           Text(item.english)
                               .opacity(0.8)
                               .font(.system(size: 14.0))
                               .offset(x: 12.0)
                       }
                       .padding(6.0)
                   }
                   .onDelete { indexSet in
                       translations.remove(atOffsets: indexSet)
                       currentIndex = 0
                       saveAction()
                       hideKeyboard()
                    }
                   .listRowInsets(EdgeInsets())
               }
               .listStyle(PlainListStyle())
                
                Spacer()
            }
        }
        .overlay(
            isTextFieldFocused ?
            Color.clear
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                .offset(y: 150)
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            
            : nil
        )
    }
}

