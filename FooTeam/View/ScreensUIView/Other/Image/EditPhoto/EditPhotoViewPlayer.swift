//
//  EditPhoto.swift
//  FooTeam
//
//  Created by Виталий Сосин on 27.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditPhotoViewPlayer: View {
    
    @ObservedObject private var viewModel = EditPhotoViewModel()
    var player: Player
    @Binding var isPresentedChangeAvatar: Bool
    @Binding var image: UIImage
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack {
                Spacer()
                Button(action: { isPresentedChangeAvatar.toggle() } ) {
                    Image(systemName: "multiply")
                        .renderingMode(.original)
                        .font(.title)
                }
            } .padding(.horizontal)
            
            HStack {
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
            }
            
            DividerFooTeamMenu()
            
            HStack {
                Button(action: {
                    viewModel.isShowPhotoLibrary = true
                }) {
                    HStack {
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                        
                        Text(NSLocalizedString("EditPhotoViewPlayerGallery",
                                               comment: "Gallery"))
                            .font(.headline)
                    }
                    .frame(minWidth: 200, maxWidth: 250, minHeight: 30, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
            }
            
            DividerFooTeamMenu()
            
            HStack {
                Spacer()
                Button(action: {
                    EditPlayerAva.shared.editPlayerInTeam(player: player,
                                                          avatarUIImage: viewModel.image)
                }) {
                    HStack {
                        Image(systemName: "opticaldiscdrive")
                            .font(.system(size: 20))
                        
                        Text(NSLocalizedString("EditPhotoViewPlayerSave",
                                               comment: "Save"))
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .frame(minWidth: 200, maxWidth: 250, minHeight: 30, maxHeight: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
                Spacer()
            }
            
            .sheet(isPresented: $viewModel.isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$viewModel.image)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EditPhotoViewPlayer(player: DefaultPlayer.shared.player,
                            isPresentedChangeAvatar: .constant(false),
                            image: .constant(UIImage(named: "khimki")!))
    }
}
