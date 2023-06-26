//
//  Home.swift
//  pokedexIOS
//
//  Created by João Vitor Alves Holanda on 23/06/23.
//
import SwiftUI

struct Home: View {
    @State var pokemon = [PokemonEntry]()
    @State var searchText = ""
    var title = "Pokedex"
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchText == "" ? pokemon : pokemon.filter({ $0.name.contains(searchText.lowercased()) })) { pokemon in
                    HStack {
                        PokeImages(imageLink: "\(pokemon.url)")
                        NavigationLink("\(pokemon.name)".capitalized, destination: Text("Detailed view for \(pokemon.name)"))
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle(title)
        }
        .onAppear {
            Api().getData { pokemon in
                self.pokemon = pokemon
            }
        }
    }
}

struct TesteDosNomes_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
