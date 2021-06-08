//
//  ListView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 07/06/2021.
//

import SwiftUI

final class DispositiveModelData: ObservableObject {
    @Published var dispositives =
        [  Dispositive(id: 0, name: "Fenotipado", description: "Consola de comandos", ip: "192.168.0.84", port: 8888, avatar: Image(systemName: "terminal.fill"), favorite: true),
        ]
}

struct ListView: View {
    
    @EnvironmentObject var dispositiveModelData:
        DispositiveModelData
    @State private var showFavorites = false
    
    private var filteredDispositives: [Dispositive] {
        return dispositiveModelData.dispositives.filter{ dispositive in
            return !showFavorites || dispositive.favorite
        }
    }
    
    var body: some View {
        NavigationView {
        VStack{
            Toggle(isOn: $showFavorites) {
                Text("Mostrar favoritos")
            }.padding()
            
                List(filteredDispositives, id: \.id){ dispositive in
                    NavigationLink (destination: ListDetailView(dispositive: dispositive, favorite: $dispositiveModelData.dispositives[dispositive.id].favorite)) {
                        RowView(dispositive: dispositive)
                    }
                }
            }.navigationTitle("Dispositives")
        }
        
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(DispositiveModelData())
    }
}
