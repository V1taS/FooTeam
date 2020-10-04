//
//  EditPhoto.swift
//  FooTeam
//
//  Created by Виталий Сосин on 27.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditPhoto: View {

    var player: Player
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()

    var body: some View {
        VStack {

            WebImage(url: URL(string: player.avatarStringURL))
                .resizable()
                .renderingMode(.original)
                .onSuccess { image, data, cacheType in }
                .placeholder(Image(uiImage: image))
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .aspectRatio(contentMode: .fill)
                .frame(width: 125, height: 125, alignment: .center)
                .cornerRadius(20)

            VStack {
                Button(action: {
                    self.isShowPhotoLibrary = true
                }) {
                    HStack {
                        Image(systemName: "photo")
                            .font(.system(size: 20))

                        Text("Галерея")
                            .font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: 250, minHeight: 0, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                } .padding(.bottom)
                
                Button(action: {
                    EditPlayerThree.shared.editPlayerInTeam(player: player, avatarUIImage: image)
                }) {
                    HStack {
                        Text("Сохранить")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .frame(minWidth: 0, maxWidth: 250, minHeight: 0, maxHeight: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EditPhoto(player: Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGoals: 0, winGame: 0, losGame: 9, captain: false))
    }
}
