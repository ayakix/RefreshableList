//
//  ContentView.swift
//  RefreshableList
//
//  Created by Ryota Ayaki on 2023/06/26.
//

import SwiftUI

struct User: Identifiable {
    var id = UUID().uuidString
}

class ViewModel: ObservableObject {
    @Published var state: RefreshableListState = .initialize
    @Published var users: [User] = []

    func initUsers() {
       DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           self.users.removeAll()
           for _ in (0 ..< 20) {
               self.users.append(User())
           }
           self.state = .displayList
       }
    }

    func appendUsers() {
        state = .append
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            for _ in (0 ..< 10) {
                self.users.append(User())
            }
            self.state = .displayList
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel: ViewModel = .init()

    var body: some View {
        RefreshableList(state: $viewModel.state) {
            ForEach(viewModel.users, id: \.id) { user in
                Text(user.id.prefix(13))
                    .onAppear {
                        // 追加ロード
                        if viewModel.users.last?.id == user.id {
                            viewModel.appendUsers()
                        }
                    }
            }
        } onRefersh: {
            viewModel.initUsers()
        }
        .onAppear {
            viewModel.initUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
