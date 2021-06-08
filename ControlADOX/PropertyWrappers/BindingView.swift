//
//  BindingView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 07/06/2021.
//

import SwiftUI

struct BindingView: View {
    
    @Binding var value: Int
    @ObservedObject var user: UserData
    @State private var selection: Int?
    
    var body: some View {
        VStack{
            Spacer()
            Text("El valor actual es \(value)")
            HStack{
                Button("Sumar 2"){
                    value += 2
                }.padding()
                Button("Restar 2"){
                    value -= 2
                }.padding()
            }
            Spacer()
            Text("Soy \(user.name) y tengo \(user.age)")
            Button("Actualizar datos"){
                user.name="Teo Martin Toledo"
                user.age=value
            }.padding()
            Spacer()
            NavigationLink(
                destination: EnvironmentView(), tag: 1, selection: $selection){
                Button("Ir a EnvironmentView"){
                    selection=1
                }
            }
            Spacer()
        }
    }
}

struct BindingView_Previews: PreviewProvider {
    static var previews: some View {
        BindingView(value: .constant(5), user: UserData())
    }
}
