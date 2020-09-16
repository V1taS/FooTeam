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
    
    let colorLine: UIColor
    let colorText: UIColor
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
            BackgroundFooTeam(firstColor: .gray, centerColor: backgroundColor, lastColor: .gray)
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 45))

            VStack {
                
                
                ZStack {
                    WebImage(url: URL(string: photoPlayer))
                    .onSuccess { image, data, cacheType in }
                    .resizable()
                    .placeholder(Image("player"))
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .frame(width: 125, height: 125, alignment: .center)
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fill)
                    
                    
                } .offset(x: 20, y: -5)
                
                
                Text(namePlayer)
                    .foregroundColor(Color(colorText))
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: 180)
                    .lineLimit(1)
                
                ZStack {
                    Color(colorLine)
                        .frame(width: 180, height: 1)
                } .offset(x: 0, y: -10)
                
                
                
                
                HStack {
                    VStack {
                        HStack {
                            Text(game)
                                .foregroundColor(Color(colorText))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                            
                            Text("GAME")
                                .foregroundColor(Color(colorText))
                        }
                        
                        HStack {
                            Text(goal)
                                .foregroundColor(Color(colorText))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                            
                            Text("GOAL")
                                .foregroundColor(Color(colorText))
                        }
                    } .offset(x: -10, y: 0)
                    
                    
                    
                    VStack {
                        HStack {
                            Text("WIN")
                                .foregroundColor(Color(colorText))
                            Text(win)
                                .foregroundColor(Color(colorText))
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .frame(width: 25)
                        }
                        
                        HStack {
                            Text("LOS")
                                .foregroundColor(Color(colorText))
                            Text(los)
                                .foregroundColor(Color(colorText))
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
                        .foregroundColor(Color(colorText))
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                    
                    Text(positionPlayer)
                        .foregroundColor(Color(colorText))
                        .font(.system(size: 12))
                    
                    Color(colorLine)
                        .frame(width: 20, height: 1)
                    
                    Image("russia")
                        .resizable()
                        .frame(width: 25, height: 15)
                    
                    Color(colorLine)
                        .frame(width: 20, height: 1)
                    
                    Image("khimki")
                        .resizable()
                        .frame(width: 25, height: 30)
                    
                    
                } .offset(x: -70, y: -60)
            }
            
            ZStack {
                
                Color(colorLine)
                    .frame(width: 1, height: 60)
            } .offset(x: 0, y: 90)
            
            ZStack {
                Color(colorLine)
                    .frame(width: 40, height: 1)
            } .offset(x: 0, y: 130)
        }
        .frame(width: 240, height: 320)
    }
}

struct CellTopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        CellTopPlayersFooTeam(colorLine: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), colorText: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), backgroundColor: Color(#colorLiteral(red: 0.3457017243, green: 0.02197306044, blue: 0.1431319714, alpha: 1)), namePlayer: "Сосин Виталий", photoPlayer: "Сосин Виталий", ratingPlayer: "0", positionPlayer: "ФРВ", game: "2", goal: "2", win: "2", los: "2")
    }
}
