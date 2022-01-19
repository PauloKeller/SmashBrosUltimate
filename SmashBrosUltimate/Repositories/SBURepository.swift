//
//  SBURepository.swift
//  SmashBrosUltimate
//
//  Created by Paulo Keller on 18/01/22.
//

import Foundation
import RealmSwift

protocol SBURepositoryProtocol {
  func getUniverses() async -> Result<[SBUUniverseModel], SBUError>
  func getFighters(filter: String?) async -> Result<[SBUFighterModel], SBUError>
}

class SBURepository {
  private let provider: SBUApiProviderProtocol
  private let realm: Realm
  
  public convenience init() throws {
    try self.init(realm: Realm())
  }
  
  init(provider: SBUApiProviderProtocol = SBUApiProvider.shared(), realm: Realm) {
    self.provider = provider
    self.realm = realm
  }
  
  private func fetchUniversesFromApi() async -> Result<[SBUUniverseModel], SBUError> {
    let response = await provider.fetchUniverses()
    let result: Result<[SBUUniverseModel], SBUError>
    
    switch response {
    case .success(let data):
      result = .success(data)
      
    case .failure(let error):
      result = .failure(error)
    }
    
    return result
  }
  
  private func fetchFightersFromApi(filter: String? = nil) async -> Result<[SBUFighterModel], SBUError> {
    let response = await provider.fetchFighters(filter: filter)
    let result: Result<[SBUFighterModel], SBUError>
    
    switch response {
    case .success(let data):
      result = .success(data)
      
    case .failure(let error):
      result = .failure(error)
    }
    
    return result
  }
  
  private func fetchUniversesFromCache() -> [SBUUniverseModel] {
    let data = realm.objects(SBUUniverseModel.self).map({$0})
    return Array(data)
  }
  
  private func fetchFightersFromCache(filter: String? = nil) -> [SBUFighterModel] {
    if let filter = filter {
      // TODO: Filter cache
    }
    
    let data = realm.objects(SBUFighterModel.self).map({$0})
    return Array(data)
  }
}

extension SBURepository: SBURepositoryProtocol {
  func getFighters(filter: String?) async -> Result<[SBUFighterModel], SBUError> {
    let fromCache = false
    
    if fromCache {
      let cache = fetchFightersFromCache()
    } else {
      return await fetchFightersFromApi(filter: filter)
    }
  }
  
  func getUniverses() async -> Result<[SBUUniverseModel], SBUError> {
    let fromCache = false
    
    if fromCache {
      let cache = fetchUniversesFromCache()
    } else {
      return await fetchUniversesFromApi()
    }
  }
}
