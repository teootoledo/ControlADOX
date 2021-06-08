//
//  ContentView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 07/06/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            
            Text("Bienvenidos a la aplicación de prueba de SwiftUI")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
                .padding()
            
            Spacer()
            
            HStack {
                Text("Hola hackerman")
                    .padding()
                    .background(Color.green)
                
                Spacer()
                
                Text("Bienvenido")
                    .padding()
                    .background(Color.secondary)
            }
            
        }
        .background(Color.yellow)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
