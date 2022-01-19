//
//  SBUFighterModel.swift
//  SmashBrosUltimate
//
//  Created by Paulo Keller on 18/01/22.
//

import Foundation
import RealmSwift

class SBUFighterModel: Object, Codable {
  @Persisted var objectID: String?
  @Persisted var name: String?
  @Persisted var universe: String?
  @Persisted var price: String?
  @Persisted var popular: Bool?
  @Persisted var rate: Int?
  @Persisted var downloads: String?
  @Persisted var fighterDescription: String?
  
  enum CodingKeys: String, CodingKey {
    case fighterDescription = "description"
  }
}
