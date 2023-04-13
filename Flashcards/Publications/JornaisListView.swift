//
//  JornaisListView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 12/04/2023.
//

import SwiftUI

struct JornaisListView: View {

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(generalPublications, id: \.name) { publication in
                        HStack {
                            AsyncImage(url: URL(string: publication.image)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 25.0, height: 25.0)
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                            NavigationLink(publication.name) {
                                PublicationView(publication: publication)
                             }
                        }
                    }
                }
                header: {
                    Text("Geral")
                }
                Section {
                    ForEach(sportPublications, id: \.name) { publication in
                        HStack {
                            AsyncImage(url: URL(string: publication.image)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 25.0, height: 25.0)
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                            NavigationLink(publication.name) {
                                PublicationView(publication: publication)
                             }
                        }
                    }
                }
                header: {
                    Text("Esportes")
                }
                Section {
                    ForEach(fashionPublications, id: \.name) { publication in
                        HStack {
                            AsyncImage(url: URL(string: publication.image)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 25.0, height: 25.0)
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                            
                            NavigationLink(publication.name) {
                                PublicationView(publication: publication)
                             }
                        }
                    }
                }
                header: {
                    Text("Moda")
                }
            }
            .navigationTitle("Jornais")
        }
    }
}

