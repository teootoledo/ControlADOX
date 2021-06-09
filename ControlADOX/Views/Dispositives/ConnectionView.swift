//
//  ConnectionView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 08/06/2021.
//

import SwiftUI

struct GreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
                        .scaleEffect(configuration.isPressed ? 1.05 : 1)
                        .animation(.easeOut(duration: 0.2))
            .shadow(radius: 5)
    }
}

struct RedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Capsule())
                        .scaleEffect(configuration.isPressed ? 1.05 : 1)
                        .animation(.easeOut(duration: 0.2))
            .shadow(radius: 5)
    }
}

struct ConnectionView: View {
    
    @State private var isConnected: Bool = false
    
    var body: some View {
        VStack{
            if(!isConnected){
                
                Button("Connect to dispositive"){
                    isConnected = !isConnected
                }.buttonStyle(GreenButton()).font(.headline)
                
            } else {
                
                Button("Disconnect from dispositive"){
                    isConnected = !isConnected
                }.buttonStyle(RedButton()).font(.headline)
                
                
                VStack(alignment: .leading, spacing: 5){
                    
                    Text("Connection info:").padding()
                    
                    VStack(alignment: .leading, spacing: 5){
                        
                        Text("IP: 192.168.0.84")
                        Text("PORT: 8888")
                        
                    }
                }
            }
            
        }
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}
