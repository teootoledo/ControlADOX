//
//  RowView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 07/06/2021.
//

import SwiftUI

struct RowView: View {
    
    var dispositive: Dispositive
    
    var body: some View {
        HStack{
            dispositive.avatar
                .resizable()
                .frame(width: 40, height: 40).padding()
            VStack(alignment: .leading){
                Text(dispositive.name)
                    .font(.title)
                Text(dispositive.description)
                    .font(.subheadline)
            }
            Spacer()
            
            if(dispositive.favorite)
            {Image(systemName: "star.fill").foregroundColor(.yellow)}
            
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(dispositive: Dispositive(id: 0, name: "Fenotipado", description: "Consola de comandos", color: .blue, banner: Image("fenotipadoBanner"), ip: "192.168.0.205", port: 3489, control: 1, avatar: Image(systemName: "terminal.fill"), favorite: true)).previewLayout(.fixed(width: 400, height: 60))
    }
}
