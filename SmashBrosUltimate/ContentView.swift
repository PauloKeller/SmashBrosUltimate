//
//  ContentView.swift
//  SmashBrosUltimate
//
//  Created by Paulo Keller on 17/01/22.
//

import SwiftUI

struct ContentView: View {
  
  
  var body: some View {
    Text("Hello, world!").padding()
    Button(action: test) {
      Text("Sign In")
    }
  }
  
  func test() {
    Task {
      let provider:SBUApiProviderProtocol = SBUApiProvider.shared()
      let fighter = await provider.fetchFighters(filter: "Mario")
      print(fighter)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
