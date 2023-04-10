//
//  ContentView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 07/04/2023.
//

import SwiftUI
import Alamofire

struct Post: Encodable {
    let q: String
    let source: String
    let target: String
}

let translationRequest = Post(q: "Hello!", source: "en", target: "pt")

struct ContentView: View {
    @State private var cards = [Card](repeating: Card.example, count: 10)
    @State var translation: String? = nil
    
    func translateData() {
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
                                print("translatedText")
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
        Button("Button title") {
            translateData()
        }
        ZStack {
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index])
                            .stacked(at: index, in: cards.count)
                    }
                }
            }
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
