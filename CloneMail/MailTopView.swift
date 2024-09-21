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
    var isExpanded: Bool = false
    let mailViewItemList: [MailViewItem]
}

struct MailTopView: View {
    @State var categoryList = [
        MailCategoryItem(label: "", mailViewItemList: [
            MailViewItem(label: "受信", image: "tray"),
        ]),
        MailCategoryItem(label: "Gmail", mailViewItemList: [
            MailViewItem(label: "下書き", image: "tray"),
            MailViewItem(label: "送信済み", image: "tray")
        ])
    ]

    var body: some View {
        NavigationStack {
            List(categoryList) { item in
                Section(){
                    ForEach(item.mailViewItemList) { mailItem in
                        NavigationLink {
                            DamyView()
                        } label: {
                            Label(mailItem.label, systemImage: mailItem.image)
                        }
                        
                    }
                } header: {
                    if !item.label.isEmpty {
                        Text(item.label)
                            .listRowInsets(.init())
                    }
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
