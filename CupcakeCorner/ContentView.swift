//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by ahmad kaddoura on 1/20/24.
//

import SwiftUI

struct Response : Codable {
    var results : [Result]
}

struct Result : Codable{
    // enum solves @observable problem since Swift rewrites code
    // this does nothing to current implementation
    enum keys : String, CodingKey {
        case _trackId = "trackId"
        case _trackName = "trackName"
        case _collectionName = "collectionName"
    }
    var trackId : Int
    var trackName : String
    var collectionName : String
}

struct ContentView: View {
    @State private var results = [Result]()

    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"),scale: 3) {phase in
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFill()
                }else if phase.error != nil{
                    Text("Loading Error")
                }else{
                    ProgressView()
                }
                   
            } .frame(width: 100, height: 100)
            List(results, id:\.trackId){ item in
                VStack(alignment: .leading){
                    HStack(alignment: .top){
                        VStack(alignment: .leading){
                            Text(item.trackName)
                                .font(.headline)
                            Text(item.collectionName)
                        }
                        Spacer()
                        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 4){phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                                    
                                    //.scaledToFill()
                            }else if phase.error != nil{
                                Text("Loading Error")
                            }else{
                                Color.red
                                //ProgressView()
                            }
                        }.frame(width: 64, height: 64)
                        
                    }
                }
            }
            .task{
                await loadData()
            }
            .padding()
        }
    }
    
    func loadData() async{
        guard let url = URL(string:
                                "https://itunes.apple.com/search?term=taylor+swift&entity=song"
        )else{
            print("invalid url")
            return
        }
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from:data)
                {
                results = decodedResponse.results
                }
        }catch {
            print("Invalid Data")
        }
        
        
    }
}

#Preview {
    ContentView()
}
