//
//  MovieDetails.swift
//  movieApp
//
//  Created by Consultant on 1/8/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


struct MovieDetailView: View {
    
    
    let movieResult: Result
    let db = Firestore.firestore()
    
    init(_ movieInfo: Result)
    {
        movieResult = movieInfo
    }
    
    
    func addMovie () {
        let movieTitle = movieResult.title
        let movieSender = Auth.auth().currentUser?.email
        let imageUrl = movieResult.poster_path
        let userId = Auth.auth().currentUser?.uid
        var ref: DocumentReference? = nil
        ref = db.collection("movies").addDocument (data: [
            "userId": userId,
            "imageUrl": imageUrl ,
            "sender": movieSender as Any,
            "title": movieTitle,
            "date": Date().timeIntervalSince1970
        ]) { (error) in
            if let e = error {
                print("there was issue saving data to firestore, \(e)")
            } else {
                print("successfully saved data")
            }
        }
    }
    @EnvironmentObject var viewModel: AppViewModel
    
    let gradient = LinearGradient(colors: [Color(UIColor(red: 0.95, green: 0.94, blue: 0.88, alpha: 1.00)),Color(UIColor(red: 1.00, green: 0.92, blue: 0.68, alpha: 1.00))], startPoint: .bottom, endPoint: .top)
    
    let gradient2 = LinearGradient(colors: [Color.gray,Color.gray],
                                      startPoint: .top, endPoint: .bottom)
    
    var body: some View {

            ZStack {
                
                Image("movieGrain").resizable().aspectRatio(UIImage(named: "movieGrain")!.size, contentMode: .fill).ignoresSafeArea()
                
                VStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(movieResult.poster_path)"))
                    {
                        image in image
                            .resizable()
                            .aspectRatio(contentMode: .fill).ignoresSafeArea()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 200, height: 280)
                    .cornerRadius(10)
                    
                        Text (movieResult.title)
                            .padding()
                            .bold()
                            .font(Font.custom("Righteous-Regular", size: 20))
                            .foregroundStyle(gradient)
                        Text (movieResult.overview)
                            .padding()
                            .bold()
                            .foregroundStyle(gradient)
                            .font(Font.custom("Righteous-Regular", size: 13))
                        Text ("Release Date: \(movieResult.release_date)")
                            .padding()
                            .bold()
                            .font(Font.custom("Righteous-Regular", size: 15))
                            .foregroundStyle(gradient)
                        Text ("Rating: \(String(format: "%.1f", movieResult.vote_average))")
                            .bold()
                            .padding()
                            .font(Font.custom("Righteous-Regular", size: 15))
                            .foregroundStyle(gradient)
                    if viewModel.isSignedIn {
                        ZStack {
                            Button {
                                addMovie()
                            } label: {
                                HStack {
                                    Text("Add to List")
                                        .font(Font.custom("Righteous-Regular", size: 20))
                                        .bold()
                                        .foregroundColor(.black)
                                    Image(systemName: "plus.app")
                                        .foregroundColor(Color(uiColor: .black))
                                }
                                
                            }.frame(height: 35)
                                .frame(maxWidth: 180)
                                .background(gradient)
                                .cornerRadius(10)
                                .padding()
                        }
                    } else {
                        ZStack {
                            Button {
                            } label: {
                                HStack {
                                    Text("Add to List")
                                        .font(Font.custom("Righteous-Regular", size: 20))
                                        .bold()
                                        .foregroundColor(.white)
                                    Image(systemName: "plus.app")
                                        .foregroundColor(Color(uiColor: .white))
                                }
                                
                            }.frame(height: 35)
                                .frame(maxWidth: 180)
                                .background(gradient2)
                                .cornerRadius(10)
                                .padding()
                                
                        }
                    }
                    
                    
                }
            } .toolbar {
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
