//
//  CommunicationsView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 08/06/2021.
//

import SwiftUI
import Foundation
import Network
var connection: NWConnection?
var hostUDP: NWEndpoint.Host = "192.168.0.205"
var portUDP: NWEndpoint.Port = 3489

struct CommunicationsView: View {

    @State var confirm = false
    @State var plusY = false
    @State var minusY = false
    @State var plusX = false
    @State var minusX = false
    @State var plusZ = false
    @State var minusZ = false
    @State var stopMOVE = false
    @State var command: String = ""
    
    var body: some View {
            
        
        VStack {
            HStack{
                VStack{
                    HStack{
                            Button(action: {
                                self.plusY = true
                                self.connectToUDP(hostUDP, portUDP, message:"<ARRIBA1>")
                            }) {
                                Text("Y+")
                            }
                    }
                    .padding()
                    .background(
                        Capsule()
                            .stroke(Color.blue, lineWidth: 1.5)
                        )
                    
                    HStack{
                        Button(action: {
                            self.minusX = true
                            self.connectToUDP(hostUDP, portUDP, message:"<IZQUIERDA1>")
                        }) {
                            Text("X-")
                        }
                        .padding()
                        .background(
                            Capsule()
                                .stroke(Color.blue, lineWidth: 1.5)
                            )
                        Button(action: {
                            self.stopMOVE = true
                            self.connectToUDP(hostUDP, portUDP, message:"<PARAR>")
                        }) {
                            Text("STOP")
                        }
                        .padding()
                        .background(
                            Capsule()
                                .stroke(Color.blue, lineWidth: 1.5)
                            )
                        Button(action: {
                            self.plusX = true
                            self.connectToUDP(hostUDP, portUDP, message:"<DERECHA1>")
                        }) {
                            Text("X+")
                        }
                        .padding()
                        .background(
                            Capsule()
                                .stroke(Color.blue, lineWidth: 1.5)
                            )
                    }
                    HStack{
                        Button(action: {
                            self.minusY = true
                            self.connectToUDP(hostUDP, portUDP, message:"<ABAJO1>")
                        }) {
                            Text("Y-")
                        }
                    }
                    .padding()
                    .background(
                        Capsule()
                            .stroke(Color.blue, lineWidth: 1.5)
                        )
                }
                .padding()
                Divider()
                    .padding()
                    .frame(height: 200)
                VStack{
                    HStack{
                        Button(action: {
                            self.plusZ = true
                            self.connectToUDP(hostUDP, portUDP, message:"<SUBIR>")
                        }) {
                            Text("Z+")
                        }
                        .padding()
                        .background(
                            Capsule()
                                .stroke(Color.blue, lineWidth: 1.5)
                            )
                    }
                    HStack{
                        Button(action: {
                            self.minusZ = true
                            self.connectToUDP(hostUDP, portUDP, message:"<BAJAR>")
                        }) {
                            Text("Z-")
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
                                        self.connectToUDP(hostUDP, portUDP, message:command)
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


struct CommunicationsView_Previews: PreviewProvider {
    static var previews: some View {
        CommunicationsView().previewLayout(.fixed(width: 400, height: 320))
    }
}

