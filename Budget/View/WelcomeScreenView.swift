//
//  WelcomeScreenView.swift
//  Budget
//
//  Created by Алексей Зарицький on 21.01.2023.
//

import SwiftUI

struct WelcomeScreenView: View {
    // Showing Login Page...
    @State var showHome: Bool = false
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Your Budget")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .padding(.top,20)
                .padding(.horizontal,20)
        
            Spacer()
            
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom,250)
            
            
            
            Button {
                withAnimation{
                    showHome = true
                }
            } label: {
                
                Text("Next")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Blue"))
            }
            .padding(.horizontal,30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .mint]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        )
        .overlay(
        
            Group{
                if showHome{
                    Home()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}


extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
