//
//  SBURepository.swift
//  SmashBrosUltimate
//
//  Created by Paulo Keller on 18/01/22.
//

import Foundation
import RealmSwift

protocol SBURepositoryProtocol {
  func fetchUniverses() async throws -> [SBUUniverseModel]
  func fetchFighters(filter: String?) async throws -> [SBUFighterModel]
  func getUniverses() -> [SBUUniverseModel]
  func getFigthers(filter: String?) -> [SBUFighterModel]
  func saveUniverses(data: [SBUUniverseModel])
  func saveFighters(data: [SBUFighterModel])
  func clearUniverses()
  func clearFighters()
}

class SBURepository {
  private let provider: SBUApiProviderProtocol
  private let realm: Realm
  
  init(provider: SBUApiProviderProtocol, realm: Realm) {
    self.provider = provider
    self.realm = realm
  }
}

extension SBURepository: SBURepositoryProtocol {
  func clearFighters() {
    try? realm.write {
      realm.delete(realm.objects(SBUFighterModel.self))
    }
  }
  
  func clearUniverses() {
    try? realm.write {
      realm.delete(realm.objects(SBUUniverseModel.self))
    }
  }
  
  func saveFighters(data: [SBUFighterModel]) {
    for value in data {
      try? realm.write {
        realm.add(value)
      }
    }
  }
  
  func saveUniverses(data: [SBUUniverseModel]) {
    for value in data {
      try? realm.write {
        realm.add(value)
      }
    }
  }
  
  func getUniverses() -> [SBUUniverseModel] {
    let data = realm.objects(SBUUniverseModel.self).map({$0})
    return Array(data)
  }
  
  func getFigthers(filter: String?) -> [SBUFighterModel] {
    if let filter = filter {
      // TODO: Filter cache
    }
    
    let data = realm.objects(SBUFighterModel.self).map({$0})
    return Array(data)
  }
  
  func fetchFighters(filter: String?) async throws -> [SBUFighterModel] {
    return try await provider.fetchFighters(filter: filter)
  }
  
  func fetchUniverses() async throws -> [SBUUniverseModel] {
    return try await provider.fetchUniverses()
  }
}
