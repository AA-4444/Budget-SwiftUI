//
//  Home.swift
//  Budget
//
//  Created by Алексей Зарицький on 20.01.2023.
//

import SwiftUI

let ubuntu = "Ubuntu"
struct Home: View {
    ///  -Animation  Properties
    @State private var expandMenu: Bool  = false
    @State private var dimContent: Bool  = false
    var body: some View {
        VStack(spacing: 0) {
               HeaderView()
            
            VStack(spacing: 10){
                Text("Budgets")
                    .font(.custom(ubuntu, size: 30, relativeTo: .title))
                    .foregroundColor(expandMenu ? Color("Blue") : Color.white)
                    .contentTransition(.interpolate)
                //relativeTo: .title it will make adaptively scale the providede font size into the given text style...
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,15)
                    .padding(.top,10)
                
                CardView()
                /// -Making it Above the ScrollView...
                .zIndex(1)
                
                ScrollView(.vertical,showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(expenses){expense in
                            ExpenseCardView(expense)
                        }
                    }
                    .padding(.top,40)
                    .padding([.horizontal,.bottom],15)
                }
                .padding(.top,-20)
                .zIndex(0)
            }
            // - Moving View Up By Negative Padding...
            .padding(.top,expandMenu ? 30 : -130)
            // Diming Content
            .overlay {
                Rectangle()
                    .fill(.black)
                    .opacity(dimContent ? 0.45 : 0)
                    .ignoresSafeArea()
            }
        }
        .frame(maxHeight: .infinity,alignment: .top)
        .background {
            Color("BG")
                .ignoresSafeArea()
        }
    }
    
    // MARK:  -HEader View-
    @ViewBuilder
    func HeaderView()->some View {
        GeometryReader {
            let size = $0.size
            let offset = (size.height + 200.0) * 0.2 // -> 200 size of padding that added to the bottom when the header is expanded
            
            HStack {
                //MARK: menu button...
                // using 3 rounded rectangle to make 3 single lins in column
                VStack(alignment: .leading, spacing: 4) {
                    RoundedRectangle(cornerRadius: 2,style: .continuous)
                    // Hiding the line , when expanded...
                        .menuTitleView(CGSize(width: 15, height: 2),"Limits", offset, expandMenu){
                            print("Tapped Limits")
                            // Type in console
                        }
                       
                    RoundedRectangle(cornerRadius: 2,style: .continuous)
                        .menuTitleView(CGSize(width: 25, height: 2),"Money", (offset * 2), expandMenu){
                            print("Tapped Money")
                            // Type in console
                        }
                    
                    RoundedRectangle(cornerRadius: 2,style: .continuous)
                        .menuTitleView(CGSize(width: 20, height: 2),"Wallet", (offset * 3), expandMenu){
                            print("Tapped Wallet")
                            // Type in console
                        }
                }
                .overlay(content: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.white)
                        .scaleEffect(expandMenu ? 1 : 0.001)
                        .rotationEffect(.init(degrees: expandMenu ? 0 : -180))
                })
                .overlay(content: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture(perform: animateMenu)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button{
                   
                    
                    
                } label: {
                    Image("Pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                }

            }
            .padding(15)
        }
        .frame(height: 60)
        .padding(.bottom,expandMenu ? 200 : 130)
        .background {
            LinearGradient(gradient: Gradient(colors: [.green, .mint]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
    }
    
    
    //MARK:  - Animating Menu
    func animateMenu(){
        if expandMenu{
            /// Closing With little Speed
            withAnimation(.easeInOut(duration: 0.25)){
                dimContent = false
            }
            
            // -Diming Content Little LAter
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                withAnimation(.easeInOut(duration: 0.3)){
                    expandMenu = false
                }
            }
        }else{
            withAnimation(.easeInOut(duration: 0.35)) {
                expandMenu = true
            }
            
            //  - Diming Content Little later
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                withAnimation(.easeInOut(duration: 0.3)){
                    dimContent = true
                }
             }
        }
    }
    
    //MARK: -Card View-
    @ViewBuilder
    func CardView()->some View {
        HStack{
            VStack(alignment: .leading, spacing: 10) {
                Text("Total")
                    .font(.custom(ubuntu, size: 16, relativeTo: .body))
                Text("$8,467")
                    .font(.system(size: 40))
                    .fontWeight(.medium)
                    .foregroundColor(Color("Blue"))
                Text("-350 today")
                    .font(.custom(ubuntu,size: 13, relativeTo: .caption))
                    .foregroundColor(.red)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            Button {

            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .scaleEffect(0.9)
                    .foregroundColor(.white)
                    .frame(width: 60,height: 60)
                    .background{
                        LinearGradient(gradient: Gradient(colors: [.green, .mint]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                            .ignoresSafeArea()
                    }
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2),radius: 5, x: 10, y: 10)
            }
        }
        .padding(15)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15,style: .continuous))
        .shadow(color: .black.opacity(0.2),radius: 10,x: 5, y: 5)
        .padding(.horizontal,15)
        .padding(.top,10)
    }
    
    // Expense Card View
    @ViewBuilder
    func ExpenseCardView(_ expense: Expense)->some View{
        HStack(spacing: 12){
            Image(expense.productIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40,height: 40)
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.product)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                Text(expense.spendType)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            Text(expense.amountSpent)
                .font(.custom(ubuntu, size: 18, relativeTo: .title3))
                .fontWeight(.medium)
                .foregroundColor(Color("Blue"))
        }
        .padding(10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
        .shadow(color: .black.opacity(0.05),radius: 5,x: 5,y: 5)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


// Custom Extension to avoid Redunt Codes
extension View {
    @ViewBuilder
    fileprivate func menuTitleView(_ size: CGSize,_ title: String,_ offset: CGFloat,_ condition: Bool,onTap: @escaping ()->())->some View { // onTap: -> its callback that will be called whenever the menu item is locked.
        self
            .foregroundColor(condition ? .clear : .white)
            .contentTransition(.interpolate)
            .frame(width: size.width, height: size.height)
        .background(alignment: .topLeading) {
            Text(title)
                .font(.system(size: 25))
                .foregroundColor(.white)
                .frame(width: 150,alignment: .leading)
                .scaleEffect(condition ? 1 : 0.01, anchor: .topLeading)
                .offset(y: condition ? -6 : 0)
                .onTapGesture(perform: onTap)
        }
        .offset(x: condition ? 40 : 0,y: condition ? offset : 0)
    }
}
