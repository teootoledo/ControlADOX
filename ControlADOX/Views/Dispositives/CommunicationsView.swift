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
var hostUDP: NWEndpoint.Host = "239.1.2.4"
var portUDP: NWEndpoint.Port = 40001

struct CommunicationsView: View {

    @State var confirm = false
    @State var username: String = ""
    
    var body: some View {
        NavigationView{
            VStack {
                
                VStack(alignment: .leading) {
                    Text("Terminal input")
                        .font(.callout)
                        .bold()
                    HStack{
                        TextField("Enter new command to send...", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            self.confirm = true
                        }) {
                            Text("Enviar")
                        }
                        .actionSheet(isPresented: $confirm){
                            ActionSheet(
                                title: Text("Sound the Alarm"),
                                message: Text("Are you Sure?"),
                                buttons: [
                                    .cancel(Text("Cancel")),
                                    .destructive(Text("Yes"), action: {
                                        print("Sound the Alarm")
                                        self.connectToUDP(hostUDP, portUDP)
                                    })
                                ]
                            )
                        }
                    }
                }.padding()
            }
        }
        
        
    }
    
    func connectToUDP(_ hostUDP: NWEndpoint.Host, _ portUDP: NWEndpoint.Port) {
        // Transmited message:
        let messageToUDP = "ALARM"

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
        CommunicationsView()
    }
}

