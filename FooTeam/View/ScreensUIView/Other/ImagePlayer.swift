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
    var placeholder: String?
    
    
    var body: some View {
        WebImage(url: URL(string: avatarStringURL))
            .resizable()
            .renderingMode(.original)
            .onSuccess { image, data, cacheType in }
            .placeholder(Image(placeholder ?? "player"))
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .aspectRatio(contentMode: .fill)
            .frame(width: avatarSize, height: avatarSize, alignment: .center)
            .cornerRadius(20)
            
    }
}

struct ImagePlayer_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlayer(avatarStringURL: "", avatarSize: 70)
    }
}
