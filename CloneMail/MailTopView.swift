//
//  MailTopView.swift
//  CloneMail
//
//  Created by Tsubasa on 2024/09/19.
//

import SwiftUI

struct MailViewItem: Identifiable {
    let id = UUID()
    let label: String
    let image: String
}

struct MailCategoryItem: Identifiable {
    let id = UUID()
    let label: String
    let mailViewItemList: [MailViewItem]
}

struct MailTopView: View {
//    let defaultList = [
//        MailViewItem(label: "受信", image: "tray"),
//        MailViewItem(label: "VIP", image: "star")
//    ]
//    let categoryList = [
//        MailCategoryItem(label: "Gmail", mailViewItemList: [
//            MailViewItem(label: "下書き", image: ""),
//            MailViewItem(label: "送信済み", image: "")
//        ])
//    ]
    
    
    @State var isExpandedGmail: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        DamyView()
                    } label: {
                        Label("受信", systemImage: "tray")
                    }
                }
                Section(isExpanded: $isExpandedGmail) {
                    NavigationLink {
                        DamyView()
                    } label: {
                        Label("受信", systemImage: "tray")
                    }
                } header: {
                    Text("Gmail")
                        .listRowInsets(.init())
                }
                .headerProminence(.increased)
            }
            .navigationTitle("メールボックス")
            .listStyle(.sidebar)
        }
    }
}

#Preview {
    MailTopView()
}
