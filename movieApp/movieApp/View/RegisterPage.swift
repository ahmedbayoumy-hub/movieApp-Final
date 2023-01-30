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
    
    var body: some View {
        
        let gradient = LinearGradient(colors: [Color.blue,Color.white],
                                          startPoint: .top, endPoint: .bottom)
        
//        NavigationStack {
            ZStack {
                gradient
                    .opacity(0.50)
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 15) {
                    
                    TextField("Email",
                              text: $email ,
                              prompt: Text("Name").foregroundColor(.blue)
                    )
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Group {
                            if showPassword { // when this changes, you show either TextField or SecureField
                                TextField("Password",
                                          text: $password,
                                          prompt: Text("Password").foregroundColor(.blue)) // How to change the color of the TextField Placeholder
                            } else {
                                SecureField("Password", // how to create a secure text field
                                            text: $password,
                                            prompt: Text("Password").foregroundColor(.blue)) // How to change the color of the TextField Placeholder
                            }
                        }
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                        }
                        
                    }.padding(.horizontal)
                    
                    NavigationLink(destination: ListOrMovieView()) {
                        Button {
                            // run your code
                            viewModel.signUp(email: email, password: password)
                            // then set
                            isActive = true

                        } label: {
                            Text("Create An Account")
                                .font(Font.custom("Righteous-Regular", size: 20))
                                .bold()
                                .foregroundColor(.white)
                        }.frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(
                               LinearGradient(colors: [.black, .blue],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
                            )
                            .cornerRadius(10)
                            .padding()
                    }
            }
            
            }
//        }
        
       
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}
