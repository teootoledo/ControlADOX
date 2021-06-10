//
//  MainView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 07/06/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ScrollView{
            VStack{
                ContentView().frame(height: 300)
                ImageView().offset(y: -160)
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                
        }
    }
}
