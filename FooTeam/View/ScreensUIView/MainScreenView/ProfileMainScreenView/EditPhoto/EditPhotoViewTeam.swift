//
//  EditPhotoViewTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditPhotoViewTeam: View {
    
    @StateObject private var viewModel = EditPhotoViewModel()
    var team: Team
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
                WebImage(url: URL(string: team.avatarStringURL))
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
                        
                        Text(NSLocalizedString("EditPhotoViewTeamGallery", comment: "Gallery"))
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
                    EditTeamAva.shared.editPlayerInTeam(team: team, avatarUIImage: viewModel.image)
                }) {
                    HStack {
                        Image(systemName: "opticaldiscdrive")
                            .font(.system(size: 20))
                        
                        Text(NSLocalizedString("EditPhotoViewTeamSave", comment: "Save"))
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

struct EditPhotoViewTeam_Previews: PreviewProvider {
    static var previews: some View {
        EditPhotoViewTeam(team: Team(avatarStringURL: "", teamName: "", location: "", teamType: "", rating: 0, maxCountPlayersInTeam: 0, isHidden: false, currentCountPlayersInTeam: 0, country: "", totalMoney: "", gameСosts: "", fieldType: ""), isPresentedChangeAvatar: .constant(false), image: .constant(UIImage(named: "")!))
    }
}

