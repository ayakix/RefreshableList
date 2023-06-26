//
//  RefreshableList.swift
//  RefreshableList
//
//  Created by Ryota Ayaki on 2023/06/26.
//

import SwiftUI

import SwiftUI

enum RefreshableListState {
    case initialize
    case refresh
    case append
    case displayList
}

struct RefreshableList<Content: View>: View {
    @Binding var state: RefreshableListState
    var content: () -> Content
    var onRefresh: () -> Void
    private var loadingView = LoadingAnimationView()

    init(state: Binding<RefreshableListState>, @ViewBuilder content: @escaping () -> Content, onRefersh: @escaping () -> Void) {
        _state = state
        self.content = content
        self.onRefresh = onRefersh
    }

    var body: some View {
        if state == .initialize {
            VStack {
                Spacer()
                loadingView
                    .frame(height: 40)
                Spacer()
            }
        } else {
            list
        }
    }

    @ViewBuilder
    private var list: some View {
        List {
            if state == .refresh {
                HStack {
                    Spacer()
                    loadingView
                        .frame(height: 32)
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }

            content()
                .contentShape(Rectangle())

            if state == .append {
                HStack {
                    Spacer()
                    loadingView
                        .frame(height: 32)
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            DispatchQueue.main.async {
                state = .refresh
            }
            onRefresh()
        }
        .onAppear {
            // 標準のProgressViewを隠す
            UIRefreshControl.appearance().tintColor = .clear
            UIRefreshControl.appearance().backgroundColor = .clear
        }
    }
}

struct RefreshableList_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableList(state: .constant(.refresh)) {
            ForEach(0 ..< 15) { num in
                Text("\(num)")
            }
        } onRefersh: {}
    }
}
