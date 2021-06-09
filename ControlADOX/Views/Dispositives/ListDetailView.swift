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
    
    @Environment (\.colorScheme) var colorScheme
    
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
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    )
                }
                .frame(height: 180)
                .zIndex(1)
                
                //Dispositive Image
                VStack{
                    HStack{
                        dispositive.avatar
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .padding(8)
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .clipShape(Circle())
                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
                            .scaleEffect(getScale())
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("Edit dispositive")
                                .foregroundColor(.blue)
                                .padding(.vertical,10)
                                .padding(.horizontal)
                                .background(
                                    Capsule()
                                        .stroke(Color.blue, lineWidth: 1.5)
                                )
                        })
                    }
                    .padding(.top, -25)
                    .padding(.bottom, -10)
                    
                    VStack (alignment: .leading, spacing: 8, content: {
                        Text("Fenotipado")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Consola de comandos")
                            .foregroundColor(.gray)
                        
                        Text("Set de comandos para control de dispositivo a distancia mediante protocolo UDP.")
                    })
                    
                    Divider().padding()
                }
                .padding(.horizontal)
                //Moving de view back if it goes > 80...
                .zIndex(-offset > 80 ? 0 : 1)
            }
        })
        .ignoresSafeArea(.all, edges: .top)
        }
    
    // Dispositive Shrinking Effect
    func getOffset() -> CGFloat {
        let progress = (-offset / 80) * 20
        return progress <= 20 ? progress : 20
    }
    
    func getScale() -> CGFloat {
        let progress = -offset / 80
        let scale = 1.8 - ( progress < 1.0 ? progress : 1)
        
        return scale < 1 ? scale : 1
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
