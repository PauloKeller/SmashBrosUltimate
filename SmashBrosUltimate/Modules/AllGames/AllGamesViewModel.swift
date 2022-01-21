//
//  AllGamesViewModel.swift
//  SmashBrosUltimate
//
//  Created by Paulo Keller on 19/01/22.
//

import Foundation
import RealmSwift

enum AllGamesViewModelState {
  case loading
  case na
  case success(universes: [SBUUniverseModel], fighters: [SBUFighterModel])
  case failed(error: Error)
}

@MainActor
class AllGamesViewModel: ObservableObject {
  private let repository: SBURepositoryProtocol
  
  @Published var state: AllGamesViewModelState = .na
  
  init(repository: SBURepositoryProtocol) {
    self.repository = repository
  }

  public func fetchData() async {
    state = .loading
    
    do {
      let universes = try await repository.fetchUniverses()
      let fighters = try await repository.fetchFighters(filter: nil)
      print(fighters)
      state = .success(universes: universes, fighters: fighters)
    } catch {
      state = .failed(error: error)
    }
  }
}


