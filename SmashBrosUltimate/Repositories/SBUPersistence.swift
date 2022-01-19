//
//  SBUPersistable.swift
//  SmashBrosUltimate
//
//  Created by Paulo Keller on 18/01/22.
//

import Foundation
import RealmSwift

public protocol SBUPersistable {
  associatedtype ManagedObject: RealmSwift.Object
  init(managedObject: ManagedObject)
  func managedObject() -> ManagedObject
}
