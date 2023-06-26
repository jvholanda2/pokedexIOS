
import SwiftUI

struct PokeImages: View {
    var imageLink = ""
    @State private var pokemonSprite = ""
    var body: some View {
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 75, height: 75)
            .onAppear{
                let loadData = UserDefaults.standard.string(forKey: imageLink)
                if loadData == nil {
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                    print("aaaaa")
                }else{
                    getSprite(url: loadData!)
                    print("aaaaaaa")
                    
                }
            }
            .clipShape(Circle())
            .foregroundColor(Color.gray.opacity(0.60))
    }
    
    func getSprite(url: String) {
        var tempSprite: String?
        PokemonSelectedApi().getSprite(url: url){ sprite in
            
            tempSprite = sprite.front_default
            self.pokemonSprite = tempSprite ?? "placeholder"
        }
    }
        
}

struct PokeImages_Previews: PreviewProvider {
    static var previews: some View {
        PokeImages()
    }
}
