//
//  ImageView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 07/06/2021.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        VStack {
            Image("controlLogo").resizable().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).clipShape(Circle()).overlay(Circle().stroke(Color.accentColor, lineWidth: 5)).shadow(radius: 5)
            Image(systemName: "person.fill").resizable().padding(70).frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.gray).clipShape(Circle()).overlay(Circle().stroke(Color.accentColor, lineWidth: 5)).shadow(radius: 5)
        }
        
        //.scaledToFill().scaledToFit()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
