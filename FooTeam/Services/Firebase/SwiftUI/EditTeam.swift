//
//  EditTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 11.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class EditTeam {
    static let shared = EditTeam()
    
    // MARK: - Редактирование команды
    func editTeamInTeam(
        team: Team,
        teamName: String?,
        avatarImage: UIImage?,
        location: String?,
        teamType: String?,
        maxCountPlayersInTeam: Int?,
        isHidden: Bool?,
        currentCountPlayersInTeam: Int?,
        fieldType: String?,
        country: String?,
        totalMoney: String?,
        gameСosts: String?,
        rating: Int?
    ) {
        var team = team
        
        if let teamName = teamName { team.teamName = teamName }
        if let location = location { team.location = location }
        if let teamType = teamType { team.teamType = teamType }
        if let maxCountPlayersInTeam = maxCountPlayersInTeam { team.maxCountPlayersInTeam = maxCountPlayersInTeam }
        if let isHidden = isHidden { team.isHidden = isHidden }
        if let currentCountPlayersInTeam = currentCountPlayersInTeam { team.currentCountPlayersInTeam = currentCountPlayersInTeam }
        if let fieldType = fieldType { team.fieldType = fieldType }
        if let country = country { team.country = country }
        if let totalMoney = totalMoney { team.totalMoney = totalMoney }
        if let gameСosts = gameСosts { team.gameСosts = gameСosts }
        if let rating = rating { team.rating = rating }
        
        if let avatarImage = avatarImage {
            StorageService.shared.uploadAvaTeam(photo: avatarImage, idTeam: team.id) { (result) in
                switch result {
                case .success(let url): team.avatarStringURL = url.absoluteString
                case .failure(let error): print(error)
                }
            }
        }
        
        FirebaseReference(.teams).document(team.id).updateData(team.representation) { (error) in }
    }
}

class AddTeam {
    static let shared = AddTeam()
    
    // MARK: - Создать команду
    func addTeamWith(
        team: Team,
        teamName: String?,
        avatarImage: UIImage?,
        location: String?,
        teamType: String?,
        rating: Int?
    ) {
        var team = team
        
        if let teamName = teamName { team.teamName = teamName }
        if let location = location { team.location = location }
        if let teamType = teamType { team.teamType = teamType }
        if let rating = rating { team.rating = rating }
        
        StorageService.shared.uploadAvaTeam(photo: avatarImage!, idTeam: team.id) { (result) in
            switch result {
            case .success(let url): team.avatarStringURL = url.absoluteString
            case .failure(let error): print(error)
            }
        }
        FirebaseReference(.teams).document(team.id).setData(team.representation) { (error) in }
    }
}

class EditTeamAva {
    static let shared = EditTeamAva()
    
    // MARK: - Редактируем только аватарку команды
    func editPlayerInTeam(
        team: Team,
        avatarUIImage: UIImage?
    ) {
        var team = team
        
        if let avatarImage = avatarUIImage {
            StorageService.shared.uploadAvaTeam(photo: avatarImage, idTeam: team.id) { (result) in
                switch result {
                case .success(let url):
                    team.avatarStringURL = url.absoluteString
                    FirebaseReference(.teams).document(team.id).updateData(team.representation) { (error) in }
                case .failure(let error): print(error)
                }
            }
        }
    }
}

class EditTeamPlayTime {
    static let shared = EditTeamPlayTime()
    private let db = Firestore.firestore()
    
    // MARK: Обновляем даты игр у команды
    func editDate(date: Date, dayOfWeek: String, idTeam: String, gameNumber: Int, getPlayTime: [TeamTime]) {
        
        let refActionsPlayer = db.collection(["teams", idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))
        
        for playTime in getPlayTime {
            var playTime = playTime
            playTime.date = date
            playTime.dayOfWeek = dayOfWeek
            playTime.game = "game-\(gameNumber)"
            refActionsPlayer.document("game-\(gameNumber)").updateData(playTime.representation) { (error) in }
        }
    }
}

class DeletTeam {
    static let shared = DeletTeam()
    
    // MARK: - Удаляем команду
    func deletTeamInTeam(teamId: String) {
        FirebaseReference(.teams).whereField("id", isEqualTo: teamId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }
    }
}

class SaveTeamPlayTime {
    static let shared = SaveTeamPlayTime()
    private let db = Firestore.firestore()
    
    // MARK: Сохраняем дату игры в команде
    func saveDate(date: Date, dayOfWeek: String, idTeam: String, gameNumber: Int, gameInWeak: Int, getPlayTime: [TeamTime]) {
        let refActionsPlayer = db.collection(["teams", idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))
        let teamTime = TeamTime(date: date, dayOfWeek: dayOfWeek, game: "game-\(gameNumber)")
        let curreentPlayTime = getPlayTime.filter { $0.game == "game-\(gameNumber)" }
        
        if gameInWeak + 1 <= getPlayTime.count {
            EditTeamPlayTime.shared.editDate(date: date, dayOfWeek: dayOfWeek, idTeam: idTeam, gameNumber: gameNumber, getPlayTime: curreentPlayTime)
        } else if gameNumber > getPlayTime.count {
            refActionsPlayer.document("game-\(gameNumber)").setData(teamTime.representation) { (error) in }
        }
        RemoveExcessTime.shared.removeTime(gameInWeak: gameInWeak, ref: refActionsPlayer)
    }
}

class RemoveExcessTime {
    static let shared = RemoveExcessTime()
    
    // MARK: Удаляем что больше выбранного количества, например выбрал 3, значит 4,5,6,7 - будут удалены
    func removeTime(gameInWeak: Int, ref: CollectionReference) {
        switch gameInWeak {
        case 0:
            for i in 2...7 {
                ref.whereField("game", isEqualTo: "game-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 1:
            for i in 3...7 {
                ref.whereField("game", isEqualTo: "game-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 2:
            for i in 4...7 {
                ref.whereField("game", isEqualTo: "game-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 3:
            for i in 5...7 {
                ref.whereField("game", isEqualTo: "game-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 4:
            for i in 6...7 {
                ref.whereField("game", isEqualTo: "game-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 5:
            for i in 7...7 {
                ref.whereField("game", isEqualTo: "game-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        default:
            for i in 1...7 {
                ref.whereField("game", isEqualTo: "game-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        }
    }
}

class DefaultTeam {
    static let shared = DefaultTeam()
    
    // MARK: Значения по умолчанию
    let team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0,
        maxCountPlayersInTeam: 0,
        isHidden: false,
        currentCountPlayersInTeam: 0,
        country: "",
        totalMoney: "",
        gameСosts: "",
        fieldType: ""
    )
}

class GetDateStringFromDate {
    static let shared = GetDateStringFromDate()
    
    // MARK: Преобразуем дату в часы и минуты
    func GetDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)
        return time
    }
}

class GetDayOfWeekFromNumber {
    static let shared = GetDayOfWeekFromNumber()
    
    // MARK: Преобразуем день недели из числа String в правильную надпись
    func GetDayOfWeek(numberString: String) -> String {
        switch numberString {
        case "0":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayMonday",
                                     comment: "Monday")
        case "1":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayTuesday",
                                     comment: "Tuesday")
        case "2":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayWednesday",
                                     comment: "Wednesday")
        case "3":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayThursday",
                                     comment: "Thursday")
        case "4":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayFriday",
                                     comment: "Friday")
        case "5":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdaySaturday",
                                     comment: "Saturday")
        case "6":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdaySunday",
                                     comment: "Sunday")
        default:
            return ""
        }
    }
}

class DatePlayTeam: ObservableObject {
    @Published var teams: [TeamTime] = []
    private let db = Firestore.firestore()
    
    init() {
        getIfoAboutTeam()
    }
    
    // MARK: Текущая команда
    func getIfoAboutTeam() {
        let refActionsPlayer = db.collection(["teams", FirestoreService.shared.currentUser.idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))
        
        refActionsPlayer.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot?.documents else { return }
            self.teams = snapshot.map { TeamTime(document: $0)! }
        }
    }
}

class CurrentTeam: ObservableObject {
    @Published var team = DefaultTeam.shared.team
    
    init() { downloadTeam() }
    
    // MARK: Получаем текущую команду
    func downloadTeam() {
        if let currentUserId = FirestoreService.shared.currentUser {
            FirebaseReference(.teams).whereField("id", isEqualTo: currentUserId.idTeam).addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if let team = Team(document: document) {
                            self.team = team
                        }
                    }
                }
            }
        }
    }
}
