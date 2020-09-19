//
//  ImagePlayer.swift
//  FooTeam
//
//  Created by Виталий Сосин on 19.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImagePlayer: View {
    
    var avatarStringURL: String
    var avatarSize: CGFloat
    
    
    var body: some View {
        WebImage(url: URL(string: avatarStringURL))
            .renderingMode(.original)
            .onSuccess { image, data, cacheType in }
            .resizable()
            .placeholder(Image("player"))
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: avatarSize, height: avatarSize, alignment: .center)
            .cornerRadius(20)
            .aspectRatio(contentMode: .fill)
    }
}

struct ImagePlayer_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlayer(avatarStringURL: "", avatarSize: 120)
    }
}
