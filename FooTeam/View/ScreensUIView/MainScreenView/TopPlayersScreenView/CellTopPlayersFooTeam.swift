//
//  CellTopPlayersFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CellTopPlayersFooTeam: View {
    
    let namePlayer: String
    let photoPlayer: String
    let ratingPlayer: String
    let positionPlayer: String
    
    let locationCountryImage: String
    let logoTeamImage: String
    
    let game: String
    let goal: String
    let win: String
    let los: String
    
    var body: some View {
        ZStack {
            Color("WhiteAndBlack")
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 45))
                .overlay(RoundedRectangle(cornerRadius: 45)
                            .stroke(Color("BlackAndWhite"))
                )
            
            VStack {
                ZStack {
                    ImagePlayer(avatarStringURL: photoPlayer, avatarSize: 125)
                } .offset(x: 20, y: -5)
                
                Text(namePlayer)
                    .foregroundColor(Color("BlackAndWhite"))
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: 180)
                    .lineLimit(1)
                
                ZStack {
                    Color("BlackAndWhite")
                        .frame(width: 180, height: 1)
                } .offset(x: 0, y: -10)
                
                HStack {
                    VStack {
                        HStack {
                            Text(game)
                                .foregroundColor(Color("BlackAndWhite"))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                            
                            Text("GAME")
                                .foregroundColor(Color("BlackAndWhite"))
                        }
                        
                        HStack {
                            Text(goal)
                                .foregroundColor(Color("BlackAndWhite"))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                            
                            Text("GOAL")
                                .foregroundColor(Color("BlackAndWhite"))
                        }
                    } .offset(x: -10, y: 0)
                    
                    VStack {
                        HStack {
                            Text("WIN")
                                .foregroundColor(Color("BlackAndWhite"))
                            Text(win)
                                .foregroundColor(Color("BlackAndWhite"))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                        }
                        
                        HStack {
                            Text("LOS")
                                .foregroundColor(Color("BlackAndWhite"))
                            Text(los)
                                .foregroundColor(Color("BlackAndWhite"))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                        }
                    } .offset(x: -5, y: 0)
                }
            }
            
            ZStack {
                VStack {
                    Text(ratingPlayer)
                        .foregroundColor(Color("BlackAndWhite"))
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                    
                    Text(positionPlayer)
                        .foregroundColor(Color("BlackAndWhite"))
                        .font(.system(size: 12))
                    
                    Color("BlackAndWhite")
                        .frame(width: 20, height: 1)
                    
                    WebImage(url: URL(string: locationCountryImage))
                        .resizable()
                        .onSuccess { image, data, cacheType in }
                        .placeholder(Image("russia"))
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .frame(width: 25, height: 16)
                    
                    Color("BlackAndWhite")
                        .frame(width: 20, height: 1)
                    
                    WebImage(url: URL(string: logoTeamImage))
                        .resizable()
                        .onSuccess { image, data, cacheType in }
                        .placeholder(Image("khimki"))
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .frame(width: 30, height: 30)
                } .offset(x: -70, y: -60)
            }
            
            ZStack {
                Color("BlackAndWhite")
                    .frame(width: 1, height: 60)
            } .offset(x: 0, y: 90)
            
            ZStack {
                Color("BlackAndWhite")
                    .frame(width: 40, height: 1)
            } .offset(x: 0, y: 130)
        }
    }
}

struct CellTopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        CellTopPlayersFooTeam(namePlayer: "Raul",
                              photoPlayer: "",
                              ratingPlayer: "80",
                              positionPlayer: "ST",
                              locationCountryImage: "",
                              logoTeamImage: "",
                              game: "5",
                              goal: "10",
                              win: "5",
                              los: "0")
    }
}
