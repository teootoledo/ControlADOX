//
//  ControllerFenotipado.swift
//  ControlADOX
//
//  Created by Teo Toledo on 10/06/2021.
//

import SwiftUI
import Foundation
import Network

struct ControllerFenotipado: View {
    
    var dispositive: Dispositive

    @State var confirm = false
    @State var command: String = ""
    
    var body: some View {
        
        let IP: NWEndpoint.Host = .name(dispositive.ip, nil)
        let PORT: NWEndpoint.Port = NWEndpoint.Port(integerLiteral: dispositive.port)
        
        VStack {
            HStack{
                VStack{
                    HStack{
                            Button(action: {
                                self.connectToUDP(IP, PORT, message:"<CONTINUAR>")
                            }) {
                                Text("CONTINUAR")
                            }
                    }
                    .padding()
                    .background(
                        Capsule()
                            .stroke(Color.blue, lineWidth: 1.5)
                        )
                    
                    HStack{
                        Button(action: {
                            self.connectToUDP(IP, PORT, message:"<PESAR>")
                        }) {
                            Text("PESAR")
                        }
                        .padding()
                        .background(
                            Capsule()
                                .stroke(Color.blue, lineWidth: 1.5)
                            )
                        Button(action: {
                            self.connectToUDP(IP, PORT, message:"<DETENER>")
                        }) {
                            Text("DETENER")
                        }
                        .padding()
                        .background(
                            Capsule()
                                .stroke(Color.blue, lineWidth: 1.5)
                            )
                    }
                }
                .padding()
            }
            
                
                
                VStack(alignment: .leading) {
                    Text("Terminal input")
                        .font(.callout)
                        .bold()
                    HStack{
                        TextField("Enter new command to send...", text: $command)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            self.confirm = true
                        }) {
                            Text("Enviar")
                        }
                        .actionSheet(isPresented: $confirm){
                            ActionSheet(
                                title: Text("Send custom message"),
                                message: Text("Are you Sure?"),
                                buttons: [
                                    .cancel(Text("Cancel")),
                                    .destructive(Text("Yes"), action: {
                                        print("Sound the Alarm")
                                        self.connectToUDP(IP, PORT, message:command)
                                    })
                                ]
                            )
                        }
                    }
                }.padding()
            }
    }

    
    func connectToUDP(_ hostUDP: NWEndpoint.Host, _ portUDP: NWEndpoint.Port, message: String) {
        // Transmited message:
        let messageToUDP = message

        connection = NWConnection(host: hostUDP, port: portUDP, using: .udp)

        connection?.stateUpdateHandler = { (newState) in
            print("This is stateUpdateHandler:")
            switch (newState) {
                case .ready:
                    print("State: Ready\n")
                    self.sendUDP(messageToUDP)
                    self.receiveUDP()
                case .setup:
                    print("State: Setup\n")
                case .cancelled:
                    print("State: Cancelled\n")
                case .preparing:
                    print("State: Preparing\n")
                default:
                    print("ERROR! State not defined!\n")
            }
        }

        connection?.start(queue: .global())
    }
    
    func sendUDP(_ content: String) {
        let contentToSendUDP = content.data(using: String.Encoding.utf8)
        connection?.send(content: contentToSendUDP, completion: NWConnection.SendCompletion.contentProcessed(({ (NWError) in
            if (NWError == nil) {
                print("Data was sent to UDP")
            } else {
                print("ERROR! Error when data (Type: Data) sending. NWError: \n \(NWError!)")
            }
        })))
    }

    func receiveUDP() {
        connection?.receiveMessage { (data, context, isComplete, error) in
            if (isComplete) {
                print("Receive is complete")
                if (data != nil) {
                    let backToString = String(decoding: data!, as: UTF8.self)
                    print("Received message: \(backToString)")
                } else {
                    print("Data == nil")
                }
            }
        }
    }
    
}


struct ControllerFenotipado_Previews: PreviewProvider {
    static var previews: some View {
        ControllerFenotipado(dispositive: Dispositive(id: 1, name: "Nombre", description: "Descripción", color: .blue, banner: Image(""), ip: "192.168.0.205", port: 3489, control: 1, avatar: Image("user"), favorite: true)).previewLayout(.fixed(width: 400, height: 320))
    }
}

