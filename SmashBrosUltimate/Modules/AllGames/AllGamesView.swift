//
//  AllGamesView.swift
//  SmashBrosUltimate
//
//  Created by Paulo Keller on 17/01/22.
//

import SwiftUI
import RealmSwift

struct UniverseFilterSelector: View {
  var data: [SBUUniverseModel]
  private let rowsGrid = [GridItem(.flexible())]
  
  var body: some View{
    ScrollView(.horizontal) {
      LazyHGrid(rows: rowsGrid, spacing: 20) {
        ForEach(data, id: \.self) { item in
          Text(item.name ?? "")
        }
      }
    }
  }
}

struct AllGamesView: View {
  @StateObject private var viewModel: AllGamesViewModel
  
  init(realm: Realm) {
    _viewModel = StateObject(wrappedValue: AllGamesViewModel(repository: SBURepository(provider: SBUApiProvider.shared(), realm: realm)))
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        switch viewModel.state {
        case .success(let universes, let fighters):
          HStack {
            Text("Figthers (\(fighters.count))")
              .font(.system(size: 18))
              .fontWeight(.bold)
              .multilineTextAlignment(.leading)
            line
          }
          UniverseFilterSelector(data: universes)
          FightersScrollView(data: fighters)
        default:
          EmptyView()
        }
      }
      .navigationBarBackButtonHidden(true)
      .navigationBarTitle(Text("Fighters"), displayMode: .inline)
      
      .toolbar {
        Button("Filter") {
          print("Help tapped!")
        }
      }
      .padding(.leading, 14)
      .padding(.trailing, 14)
    }.task {
      await viewModel.fetchData()
    }
  }
  
  var line: some View {
    VStack { Divider() }.padding(.leading, 64)
  }
}

struct AllGamesView_Previews: PreviewProvider {
  static var previews: some View {
    let realm = try! Realm()
    
    AllGamesView(realm: realm)
  }
}
