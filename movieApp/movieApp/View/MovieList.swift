//
//  MovieList.swift
//  movieApp
//
//  Created by Consultant on 1/27/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore



struct Result: Codable, Hashable {
    let title: String
    let overview: String
    let release_date: String
    let vote_average: Double
    let poster_path: String
    let id : Int
}

struct Movie: Codable, Hashable {
    let results: [Result]
}




struct MovieList: View {
    
    
    let gradient = LinearGradient(colors: [Color(UIColor(red: 0.95, green: 0.94, blue: 0.88, alpha: 1.00)),Color(UIColor(red: 1.00, green: 0.92, blue: 0.68, alpha: 1.00))], startPoint: .bottom, endPoint: .top)
    
    @StateObject var viewModel = ViewModel()
    @EnvironmentObject var viewModel1: AppViewModel
    let listColor : UIColor = .random
    
//    NavigationLink(movie.title, destination: MovieDetailView(viewModel.idToResultDic[movie.id]!))
    
    var body: some View {
        
//            NavigationView {
                ZStack {
        
                VStack{
                    List {
                        ForEach (viewModel.movies.results, id: \.id) { movie in
                            HStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(movie.poster_path)"))
                                {
                                    image in image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 50, height:80)
                                .cornerRadius(10)
                                VStack {
//                                    NavigationLink(movie.title, destination: MovieDetailView(viewModel.idToResultDic[movie.id]!))
//
                                    NavigationLink(destination: MovieDetailView(viewModel.idToResultDic[movie.id]!)) {
                                        VStack {
                                            Text(movie.title)
                                                .frame(maxWidth: .infinity, alignment: .leading)
//                                                .foregroundStyle(gradient)
                                            Text(movie.overview)
                                                .foregroundColor(Color(uiColor: .systemGray))
                                                .lineLimit(2)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .font(Font.custom("Righteous-Regular", size: 10))
                                            
                                            Text ("Rating: \(String(format: "%.1f", movie.vote_average))")
                                                .font(Font.custom("Righteous-Regular", size: 10))
                                                .frame(maxWidth: .infinity, alignment: .leading)
//                                                .foregroundStyle(gradient)
                                        }
                                        
                                    }
                                    
                                    
                                    
                                }

                                
                            } .font(Font.custom("Righteous-Regular", size: 15))
                                .bold()
                                .scrollContentBackground(.hidden)
                                
                            
                        }
                    }
                    
                    .navigationTitle("Trending Movies")
                    
                    .onAppear {
                        viewModel.fetch()
                        
                    }
                    .toolbar {
                        if viewModel1.isSignedIn {
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
    }
}


extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}



struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
