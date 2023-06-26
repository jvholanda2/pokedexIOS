//
//  File.swift
//  pokedexIOS
//
//  Created by João Vitor Alves Holanda on 23/06/23.
//

import Foundation

struct Pokemon : Codable {
    var results: [PokemonEntry]
}

struct PokemonEntry : Codable, Identifiable {
    let id = UUID()
    var name: String
    var url: String
}

class Api {
    func getData(completation: @escaping([PokemonEntry]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        
        URLSession.shared.dataTask(with: url) {(data, reponse, error) in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.async {
                completation(pokemonList.results)
            }
            
        }.resume()
    }
}
