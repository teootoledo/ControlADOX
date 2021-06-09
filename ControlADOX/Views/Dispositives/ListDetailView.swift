//
//  ListDetailView.swift
//  ControlADOX
//
//  Created by Teo Toledo on 07/06/2021.
//

import SwiftUI

struct ListDetailView: View {
    
    var dispositive: Dispositive
    
    @Binding var favorite: Bool
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 15){
                
                //Header View...
                GeometryReader{
                    proxy -> AnyView in
                    
                    //Sticky Header
                    let minY = proxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return AnyView(
                        ZStack{
                            
                            //Banner...
                            Image("fenotipadoBanner")
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(0)
                        }
                        //Stretchy Header...
                        .frame(height: minY > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : 0)
                    )
                }
                .frame(height: 100)
                
                Spacer()
                
                //Dispositive Image
                HStack{
                    
                    dispositive.avatar
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Text("Edit dispositive")
                            .foregroundColor(.blue)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(
                                Capsule()
                                    .stroke(Color.blue)
                            )
                    })
                } .padding(.horizontal)
            }
            
        })
        .ignoresSafeArea(.all, edges: .top)
        }
    }

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(dispositive: Dispositive(id: 0, name: "Fenotipado", description: "Consola de comandos", ip: "192.168.0.84", port: 8888, avatar: Image(systemName: "terminal.fill"), favorite: true), favorite: .constant(true))
    }
}

// Extending View to get Screen Size
extension View{
    
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
}
