//
//  ContentView.swift
//  Shared
//
//  Created by nyannyan0328 on 2021/09/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{proxy in
            
            let size = proxy.size
            let bottomEdge = proxy.safeAreaInsets.bottom
          
            
            BaseView(size: size,bottomEdge : bottomEdge)
              
               .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension View{
    
    func getSafeArea()->UIEdgeInsets{
        
        
        let null = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            return null
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            
            return null
        }
        return safeArea
    }
}
