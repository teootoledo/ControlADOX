//
//  StateView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 07/06/2021.
//

import SwiftUI

class UserData: ObservableObject{
    @Published var name = "Teo"
    @Published var age = 21
}

struct StateView: View {
    
    @State private var value = 0
    @State private var selection: Int?
    @StateObject private var user = UserData()
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                VStack{
                    Text("El valor actual es \(value)")
                    HStack{
                        Button("Sumar"){
                            value += 1
                        }.padding()
                        Button("Restar"){
                            value -= 1
                        }.padding()
                    }
                }.padding()
                Spacer()
                Text("Mi nombre es \(user.name) y mi edad \(user.age)").font(.headline)
                Button("Actualizar datos"){
                    user.name="Teo Toledo"
                    user.age=value
                }.padding()
                Spacer()
                NavigationLink(
                    destination: BindingView(value: $value, user: user), tag: 1, selection: $selection){
                    Button("Ir a BindingView"){
                        selection=1
                    }
                }
            }.navigationTitle("StateView")
        }
        
        
    }
}

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        StateView().environmentObject(UserData())
    }
}
