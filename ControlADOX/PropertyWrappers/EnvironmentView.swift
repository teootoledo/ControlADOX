//
//  EnvironmentView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 08/06/2021.
//

import SwiftUI

struct EnvironmentView: View {
    
    @EnvironmentObject var user: UserData
    
    var body: some View {
        
        Text(user.name)
    }
}

struct EnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentView()
            .environmentObject(UserData())
    }
}
