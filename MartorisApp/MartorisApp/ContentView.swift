//
//  ContentView.swift
//  MartorisApp
//
//  Created by Nawazish Abbas on 31/08/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = UsersViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    List {
                        ForEach(vm.users, id: \.id) { user in
                            UserView(user: user)
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Users")
                }
            }
            .onAppear(perform: vm.fetchUsers)
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button(action: vm.fetchUsers) {
                    Text("Retry")
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
