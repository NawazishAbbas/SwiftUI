//
//  UserView.swift
//  MartorisApp
//
//  Created by Nawazish Abbas on 01/09/2025.
//
import SwiftUI

struct UserView: View {
    let user: User
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(user.name)")
            Text("Email: \(user.email)")
            Divider()
            Text("Company Details: \(user.company.name)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

#Preview {
    UserView(user: User(id: 0, name: "", email: "", company: .init(name: "")))
}
