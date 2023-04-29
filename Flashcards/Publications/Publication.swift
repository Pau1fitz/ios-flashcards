//
//  Publication.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import Foundation

struct Publication {
    var name: String
    var url: URL
    var image: String
}

func createFavicon(url: String) -> String {
    return ("https://t3.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=\(url)&size=128")
}

let sportPublications: [Publication] = [
    Publication(
        name:"A Bola",
        url: URL(string: "https://www.abola.pt/")!,
        image: createFavicon(url: "https://www.abola.pt/")
    ),
    Publication(
        name:"Record",
        url: URL(string: "https://www.record.pt/")!,
        image: createFavicon(url: "https://www.record.pt/")
    ),
    Publication(
        name:"O Jogo",
        url: URL(string: "https://www.ojogo.pt/")!,
        image: createFavicon(url: "https://www.ojogo.pt/")
    ),
    Publication(
        name:"Bola VIP",
        url: URL(string: "https://www.bolavip.com/")!,
        image: createFavicon(url: "https://www.bolavip.com/")
    ),
    Publication(
        name:"ESPN",
        url: URL(string: "https://www.espn.com.br/")!,
        image: createFavicon(url: "https://www.espn.com.br/")
    ),
    Publication(
        name:"Surftotal",
        url: URL(string: "https://surftotal.com/")!,
        image: createFavicon(url: "https://surftotal.com/")
    )
]

let fashionPublications: [Publication] = [
    Publication(
        name:"Vogue",
        url: URL(string: "https://www.vogue.pt/")!,
        image: createFavicon(url: "https://www.vogue.com/")
    ),
    Publication(
        name:"Marie Claire",
        url: URL(string: "https://revistamarieclaire.globo.com/")!,
        image: createFavicon(url: "https://www.marieclaireinternational.com/")
    ),
    Publication(
        name:"Máxima",
        url: URL(string: "https://www.maxima.pt/")!,
        image: createFavicon(url: "https://www.maxima.pt/")
    ),
    Publication(
        name:"Activa",
        url: URL(string: "https://activa.sapo.pt/")!,
        image: createFavicon(url: "https://activa.sapo.pt/")
    ),
    Publication(
        name:"Glamour",
        url: URL(string: "https://glamour.globo.com/")!,
        image: createFavicon(url: "https://www.glamour.com/")
    )
]

let celebrityPublications: [Publication] = [
    Publication(
        name:"Caras",
        url: URL(string: "https://caras.sapo.pt/")!,
        image: createFavicon(url: "https://caras.sapo.pt/")
    ),
    Publication(
        name:"Vidas",
        url: URL(string: "https://www.vidas.pt/")!,
        image: createFavicon(url: "https://www.vidas.pt/")
    ),
    Publication(
        name:"Maria",
        url: URL(string: "https://www.maria.pt/")!,
        image: createFavicon(url: "https://www.maria.pt/")
    ),
    Publication(
        name:"Nova Gente",
        url: URL(string: "https://www.novagente.pt/")!,
        image: createFavicon(url: "https://www.novagente.pt/")
    ),
    Publication(
        name:"Contigo",
        url: URL(string: "https://contigo.uol.com.br/")!,
        image: createFavicon(url: "https://contigo.uol.com.br/")
    )
]

let otherPublications = [
    Publication(
        name:"Rolling Stone",
        url: URL(string: "https://rollingstone.uol.com.br/")!,
        image: createFavicon(url: "https://rollingstone.uol.com.br/")
    ),
    Publication(
        name:"Women's Health",
        url: URL(string: "https://www.womenshealth.pt/")!,
        image: createFavicon(url: "https://www.womenshealth.pt/")
    ),
    Publication(
        name:"Men's Health",
        url: URL(string: "https://www.menshealth.pt/")!,
        image: createFavicon(url: "https://www.menshealth.pt/")
    ),
    Publication(
        name:"Tecmundo",
        url: URL(string: "https://www.tecmundo.com.br/")!,
        image: createFavicon(url: "https://www.tecmundo.com.br/")
    ),
    Publication(
        name:"Veja",
        url: URL(string: "https://veja.abril.com.br/")!,
        image: createFavicon(url: "https://veja.abril.com.br/")
    )
]

let generalPublications: [Publication] = [
    Publication(
        name:"CNN",
        url: URL(string: "https://cnnportugal.iol.pt/")!,
        image: createFavicon(url: "https://cnnportugal.iol.pt/")
    ),
    Publication(
        name:"TVI",
        url: URL(string: "https://tvi.iol.pt/noticias/")!,
        image: createFavicon(url: "https://tvi.iol.pt/")
    ),
    Publication(
        name:"Correio da Manhã",
        url: URL(string: "https://www.cmjornal.pt/")!,
        image: createFavicon(url: "https://www.cmjornal.pt/")
    ),
    Publication(
        name:"Globo",
        url: URL(string: "https://www.globo.com/")!,
        image: createFavicon(url: "https://www.globo.com/")
    ),
    Publication(
        name:"Expresso",
        url: URL(string: "https://expresso.pt/")!,
        image: createFavicon(url: "https://expresso.pt/")
    ),
    Publication(
        name:"RTP",
        url: URL(string: "https://www.rtp.pt/noticias/")!,
        image: createFavicon(url: "https://www.rtp.pt/")
    ),
    Publication(
        name:"Terra",
        url: URL(string: "https://www.terra.com.br/")!,
        image: createFavicon(url: "https://www.terra.com.br/")
    ),
    Publication(
        name:"Diário de Notícias",
        url: URL(string: "https://www.dn.pt/")!,
        image: createFavicon(url: "https://www.dn.pt/")
    ),
    Publication(
        name:"Público",
        url: URL(string: "https://www.publico.pt/")!,
        image: createFavicon(url: "https://www.publico.pt/")
    ),
    Publication(
        name:"Observador",
        url: URL(string: "https://www.observador.pt/")!,
        image: createFavicon(url: "https://www.observador.pt/")
    ),
    Publication(
        name:"Jornal de Notícias",
        url: URL(string: "https://www.jn.pt/")!,
        image: createFavicon(url: "https://www.jn.pt/")
    ),
    Publication(
        name:"Diario dos Açores",
        url: URL(string: "http://diariodosacores.pt/")!,
        image: createFavicon(url: "http://diariodosacores.pt/")
    )
]


let allPublications = sportPublications + fashionPublications + generalPublications + celebrityPublications + otherPublications
