//
//  RegisterPage.swift
//  movieApp
//
//  Created by Consultant on 1/27/23.
//

import SwiftUI

struct RegisterPage: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    
    @State var isActive: Bool = false
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    let gradient = LinearGradient(colors: [Color(UIColor(red: 0.95, green: 0.94, blue: 0.88, alpha: 1.00)),Color(UIColor(red: 1.00, green: 0.92, blue: 0.68, alpha: 1.00))], startPoint: .bottom, endPoint: .top)
    
    let gradient2 = LinearGradient(colors: [Color.gray,Color.gray],
                                      startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        
        

        
//        NavigationStack {
            ZStack {
                Image("movieGrain").resizable().aspectRatio(UIImage(named: "movieGrain")!.size, contentMode: .fill).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Email: should include @ and .com. i.e. user@gmail.com")
                        .foregroundColor(.white).padding([.horizontal, .bottom], 22)
                        .font(Font.custom("Righteous-Regular", size: 12))
                    Text("Password: should include atleast 6 characters")
                        .foregroundColor(.white).padding([.horizontal, .bottom], 22)
                        .font(Font.custom("Righteous-Regular", size: 12))
                    Text("If user not created properly, user will be redirected to free version")
                        .foregroundColor(.white).padding([.horizontal, .bottom], 22)
                        .font(Font.custom("Righteous-Regular", size: 12))
                    
                    TextField("Email",
                              text: $email ,
                              prompt: Text("Name").foregroundColor(.gray)
                    ).foregroundColor(.white)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Group {
                            if showPassword { // when this changes, you show either TextField or SecureField
                                TextField("Password",
                                          text: $password,
                                          prompt: Text("Password").foregroundColor(.gray)).foregroundColor(.white) // How to change the color of the TextField Placeholder
                            } else {
                                SecureField("Password", // how to create a secure text field
                                            text: $password,
                                            prompt: Text("Password").foregroundColor(.gray)).foregroundColor(.white) // How to change the color of the TextField Placeholder
                            }
                        }
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.white, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                        }
                        
                    }.padding(.horizontal, 20)
                    
                    
                    
                    NavigationLink(destination: ListOrMovieView()) {
                        Text("Create an Account")
                            .font(Font.custom("Righteous-Regular", size: 20))
                            .bold()
                            .foregroundColor(.black)
                    }
                    .disabled(email.isEmpty || password.isEmpty)
                    .simultaneousGesture(TapGesture().onEnded{
                        print("log in pressed!")
                        viewModel.signUp(email: email, password: password)
                    })
                    .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(!email.isEmpty && !password.isEmpty ? gradient : gradient2)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    
                }.navigationBarBackButtonHidden(true)
                
            }
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}
