//
//  ListView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 07/06/2021.
//

import SwiftUI

final class DispositiveModelData: ObservableObject {
    @Published var dispositives =
        [  Dispositive(id: 0, name: "Microscopio", description: "Consola de comandos", color: .accentColor, banner: Image("microscopioBanner"), ip: "192.168.0.205", port: 3489, control: 1, avatar: Image(systemName: "eye.circle.fill"), favorite: true),
           Dispositive(id: 1, name: "Fenotipado", description: "Consola de comandos", color: .green, banner: Image("fenotipadoBanner"), ip: "192.168.0.84", port: 8888, control: 2, avatar: Image(systemName: "leaf.fill"), favorite: false),
           Dispositive(id: 2, name: "Columna UV", description: "Panel de control", color: .purple, banner: Image("columnauvBanner"), ip: "192.168.0.99", port: 3434, control: 3, avatar: Image(systemName: "sun.max.fill"), favorite: false)
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
