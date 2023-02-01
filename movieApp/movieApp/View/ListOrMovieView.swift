//
//  ListOrMovieView.swift
//  movieApp
//
//  Created by Consultant on 1/27/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore



struct ListOrMovieView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @StateObject var MovieviewModel = ViewModel()
    
    let gradient = LinearGradient(colors: [Color(UIColor(red: 0.95, green: 0.94, blue: 0.88, alpha: 1.00)),Color(UIColor(red: 1.00, green: 0.92, blue: 0.68, alpha: 1.00))], startPoint: .bottom, endPoint: .top)
    
    let gradient2 = LinearGradient(colors: [Color.gray,Color.gray],
                                      startPoint: .top, endPoint: .bottom)
    var body: some View {
//        NavigationView {
            ZStack {
                Image("movieGrain").resizable().aspectRatio(UIImage(named: "movieGrain")!.size, contentMode: .fill).ignoresSafeArea()
                VStack {
                    NavigationLink(destination: MovieList()) {
                        ZStack {
                            Button {
                            } label: {
                            }.frame(height: 70)
                                .frame(maxWidth: 250)
                                .background(gradient)
                                .cornerRadius(10)
                                .padding()
                            HStack {
                                Image(systemName: "film.stack.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color(uiColor: .black))
                                Text("TOP MOVIES")
                                    .font(Font.custom("Righteous-Regular", size: 25))
                                    .bold()
                                    .foregroundColor(.black)
                                
                            }
                            
                        }
                    }
                    
                    
                    NavigationLink(destination: WatchListView()) {
                        ZStack {
                            Button {
                                print("movies pressed!")
                            } label: {
                            }.frame(height: 70)
                                .frame(maxWidth: 250)
                                .background(gradient)
                                .cornerRadius(10)
                                .padding()
//                                .navigationBarBackButtonHidden(true)
                                
                            HStack {
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color(uiColor: .black))
                                Text("WATCH LIST")
                                    .font(Font.custom("Righteous-Regular", size: 25))
                                    .bold()
                                    .foregroundColor(.black)
                            }
                            .navigationBarBackButtonHidden(true)
                            
                        }
                    }
                }
            }
    }
}

struct ListOrMovieView_Previews: PreviewProvider {
    static var previews: some View {
        ListOrMovieView()
    }
}
