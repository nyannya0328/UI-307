//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by nyannyan0328 on 2021/09/14.
//

import SwiftUI

struct CustomTabBar: View {
    var animation : Namespace.ID
    @Binding var currentTab : Tab
    @State var startAnimation = false
    var size : CGSize
    var bottomEdge : CGFloat
  
    var body: some View {
        HStack(spacing:0){
            
            
            ForEach(Tab.allCases,id:\.rawValue){tab in
                
                TabButton(tab: tab,currentTab: $currentTab, animation: animation) { pressTab in
                    
                    
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                        
                      startAnimation = true
                        
                        
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                        
                        
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                            
                          currentTab = pressTab
                            
                            
                        }
                        
                    }
                    
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45){
                        
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                            
                          startAnimation = false
                            
                            
                        }
                        
                        
                    }
                  
                }
                
            }
            
        }
      
        .background(
        
            ZStack{
                
                let animationOffset : CGFloat = (startAnimation ? (startAnimation ? 15 : 18) : (bottomEdge == 0 ? 26 : 27))
                let offset : CGSize = bottomEdge == 0 ? CGSize(width: animationOffset, height: 31) :CGSize(width: animationOffset, height: 31)
                
                Circle()
                    .fill(Color("red"))
                    .frame(width: 45, height: 45)
                    .offset(y: 40)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
                    .offset(x:offset.width, y: offset.height)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
                    .offset(x:-offset.width, y: offset.height)
                
                
            }
                .offset(x: getStartOffset())
                .offset(x: getOffset())
            ,alignment: .leading
        
        )//bottom BackGround
        .padding(.horizontal,15)
        .padding(.top,10)
        .padding(.bottom,bottomEdge == 0 ? 25 : bottomEdge)
        .offset(y: UIScreen.main.bounds.height > 750 ? 10 : 0)
    }
    func getStartOffset()->CGFloat{
        
        let reduced = (size.width - 30) / 4
        let center = (reduced - 45) / 2
        
        return center
        
        
    }
    
    func getOffset()->CGFloat{
        
        let reduced = (size.width - 30) / 4//4分割
        
        
        let index = Tab.allCases.firstIndex { checkTab in
            
           return checkTab == currentTab
            
           
        } ?? 0
        return reduced * CGFloat(index)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabButton : View{
    
    var tab : Tab
    //var image : String    not image
    @Binding var currentTab : Tab//tab
    var animation : Namespace.ID
    var onTap : (Tab) -> ()
  
    
    
    
    var body: some View{
        
        
        Image(systemName: tab.rawValue)//system not res aspect
            .frame(width: 45, height: 45)
            .foregroundColor(currentTab == tab ? .white : .gray)
            .background(
            
                ZStack{
                    if currentTab == tab{
                        
                        Circle()
                            .fill(Color("red"))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                        
                        
                    }
                }
            
            )
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
           
            .onTapGesture {
                if currentTab != tab{
                    
                    
                    onTap(tab)
                }
            }
       
    }
    
    
}
