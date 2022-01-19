//
//  SBUApiProvider.swift
//  SmashBrosUltimate
//
//  Created by Paulo Keller on 17/01/22.
//

import Foundation

protocol SBUApiProviderProtocol {
  func fetchUniverses() async -> Result<[SBUUniverseModel], SBUError>
  func fetchFighters(filter: String?) async -> Result<[SBUFighterModel], SBUError>
}

class SBUApiProvider : SBUBaseProvider {
  private static let sharedInstance = SBUApiProvider(baseURL: "https://593cdf8fb56f410011e7e7a9.mockapi.io")
  
  let baseURL: String
  
  private init(baseURL: String) {
    self.baseURL = baseURL
  }
  
  class func shared() -> SBUApiProvider {
    return sharedInstance
  }
}

extension SBUApiProvider: SBUApiProviderProtocol {
  func fetchUniverses() async -> Result<[SBUUniverseModel], SBUError> {
    let route = "\(baseURL)/universes"
    
    let result: Result<[SBUUniverseModel], SBUError>
    
    guard let response = try? await request([SBUUniverseModel].self, route: route) else {
      result = .failure(.failed)
      
      return result
    }
    
    switch response {
    case .success(let data):
      result = .success(data)
    case .failure(let error):
      result = .failure(error)
    }
    
    return result
  }
  
  func fetchFighters(filter: String?) async -> Result<[SBUFighterModel], SBUError> {
    var route = "\(baseURL)/fighters"
    
    if let filter = filter {
      route = "\(baseURL)/fighters?universe=\(filter)"
    }
    
    let result: Result<[SBUFighterModel], SBUError>
    
    guard let response = try? await request([SBUFighterModel].self, route: route) else {
      result = .failure(.failed)
      
      return result
    }
    
    switch response {
    case .success(let data):
      result = .success(data)
    case .failure(let error):
      result = .failure(error)
    }
    
    return result
  }
}
