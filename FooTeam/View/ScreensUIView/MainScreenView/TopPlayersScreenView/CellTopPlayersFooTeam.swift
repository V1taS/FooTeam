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
    
    let backgroundColor: Color
    
    let namePlayer: String
    let photoPlayer: String
    let ratingPlayer: String
    let positionPlayer: String
    
    let game: String
    let goal: String
    let win: String
    let los: String
    
    
    
    var body: some View {
        ZStack {
            BackgroundFooTeam(centerColor: backgroundColor)
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 45))
                .overlay(RoundedRectangle(cornerRadius: 45)
                            .stroke()
                )
                

            VStack {
                
                
                ZStack {
                    ImagePlayer(avatarStringURL: photoPlayer, avatarSize: 125)
                } .offset(x: 20, y: -5)
                
                
                Text(namePlayer)
                    .foregroundColor(Color(.black))
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: 180)
                    .lineLimit(1)
                
                ZStack {
                    Color(.black)
                        .frame(width: 180, height: 1)
                } .offset(x: 0, y: -10)
                
                
                
                
                HStack {
                    VStack {
                        HStack {
                            Text(game)
                                .foregroundColor(Color(.black))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                            
                            Text("GAME")
                                .foregroundColor(Color(.black))
                        }
                        
                        HStack {
                            Text(goal)
                                .foregroundColor(Color(.black))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                            
                            Text("GOAL")
                                .foregroundColor(Color(.black))
                        }
                    } .offset(x: -10, y: 0)
                    
                    
                    
                    VStack {
                        HStack {
                            Text("WIN")
                                .foregroundColor(Color(.black))
                            Text(win)
                                .foregroundColor(Color(.black))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                        }
                        
                        HStack {
                            Text("LOS")
                                .foregroundColor(Color(.black))
                            Text(los)
                                .foregroundColor(Color(.black))
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
                        .foregroundColor(Color(.black))
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                    
                    Text(positionPlayer)
                        .foregroundColor(Color(.black))
                        .font(.system(size: 12))
                    
                    Color(.black)
                        .frame(width: 20, height: 1)
                    
                    Image("russia")
                        .resizable()
                        .frame(width: 25, height: 15)
                    
                    Color(.black)
                        .frame(width: 20, height: 1)
                    
                    Image("khimki")
                        .resizable()
                        .frame(width: 25, height: 30)
                    
                    
                } .offset(x: -70, y: -60)
            }
            
            ZStack {
                
                Color(.black)
                    .frame(width: 1, height: 60)
            } .offset(x: 0, y: 90)
            
            ZStack {
                Color(.black)
                    .frame(width: 40, height: 1)
            } .offset(x: 0, y: 130)
        }
    }
}

struct CellTopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        CellTopPlayersFooTeam(backgroundColor: Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)), namePlayer: "Сосин Виталий", photoPlayer: "Сосин Виталий", ratingPlayer: "0", positionPlayer: "ФРВ", game: "2", goal: "2", win: "2", los: "2")
    }
}
