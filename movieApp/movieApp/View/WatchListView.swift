//
//  WatchListView.swift
//  movieApp
//
//  Created by Consultant on 1/27/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


struct WatchListView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @StateObject var MovieviewModel = ViewModel()
    let gradient = LinearGradient(colors: [Color(UIColor(red: 0.95, green: 0.94, blue: 0.88, alpha: 1.00)),Color(UIColor(red: 1.00, green: 0.92, blue: 0.68, alpha: 1.00))], startPoint: .bottom, endPoint: .top)


    
    var body: some View {
        
        VStack {
//            NavigationView {
            if !viewModel.isSignedIn {
                ZStack {
                    Image("movieGrain").resizable().aspectRatio(UIImage(named: "movieGrain")!.size, contentMode: .fill).ignoresSafeArea()
                    VStack {
                        Text("This Feature is Only Available to Users.")
                            .font(Font.custom("Righteous-Regular", size: 15))
                            .bold()
                            .foregroundStyle(gradient)
                            .padding(.bottom, 10)
                        Text("Please Sign In or Create an Account.")
                            .font(Font.custom("Righteous-Regular", size: 15))
                            .bold()
                            .foregroundStyle(gradient)
                    }
                }
            } else {
                List (MovieviewModel.moviesData) {movie in
                    HStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(movie.imageUrl)"))
                        {
                            image in image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 80)
                        .cornerRadius(10)
                        VStack {
                            Text(movie.title)
                                .font(Font.custom("Righteous-Regular", size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .swipeActions {
                                    Button (role: .destructive)  {
                                        MovieviewModel.deleteMovies(movieDelete: movie)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                            
                        }
                        
                    }
                    
                    
                }
                
            }
                    
                }
                .navigationTitle("Watch List")
//                .foregroundStyle(gradient)
                .onAppear() {
                    MovieviewModel.loadMovies()
                }
                .toolbar {
                    if viewModel.isSignedIn {
                        NavigationLink(destination: LoginPage()) {
                            Text("Log Out")
                                .font(Font.custom("Righteous-Regular", size: 15))
                                .bold()
                                .foregroundColor(.blue)
                        }.simultaneousGesture(TapGesture().onEnded{
                            print("log Out pressed!")
                            try? Auth.auth().signOut()
                        })
                    }
                    else {
                        NavigationLink(destination: RegisterPage()) {
                            Text("Register")
                                .font(Font.custom("Righteous-Regular", size: 15))
                                .bold()
                                .foregroundColor(.blue)
                        }.simultaneousGesture(TapGesture().onEnded{
                            print("log Out pressed!")
                            try? Auth.auth().signOut()
                        })
                        NavigationLink(destination: LoginPage()) {
                            Text("Sign In")
                                .font(Font.custom("Righteous-Regular", size: 15))
                                .bold()
                                .foregroundColor(.blue)
                        }.simultaneousGesture(TapGesture().onEnded{
                            print("log Out pressed!")
                            try? Auth.auth().signOut()
                        })
                    }
                        
                }
                
                
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
