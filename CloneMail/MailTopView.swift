//
//  MailTopView.swift
//  CloneMail
//
//  Created by Tsubasa on 2024/09/19.
//

import SwiftUI

struct MailViewItem: Identifiable {
    let id: UUID
    let label: String
    let image: String
    
    func copyWith(label: String?, image: String?) -> MailViewItem {
        MailViewItem(id: self.id, label: label ?? self.label, image: image ?? self.image)
    }
}

struct MailCategoryItem: Identifiable {
    let id: UUID
    let label: String
    var isExpanded: Bool = false
    var mailViewItemList: [MailViewItem]
    
    func copyWith(label: String? = nil, isExpanded: Bool?, mailViewItemList: [MailViewItem]? = nil) -> MailCategoryItem {
        MailCategoryItem(id: self.id, label: label ?? self.label, isExpanded: isExpanded ?? self.isExpanded, mailViewItemList: mailViewItemList ?? self.mailViewItemList)
    }
}

struct MailTopView: View {
    @State var categoryList = [
        MailCategoryItem(id: UUID(), label: "", isExpanded: true, mailViewItemList: [
            MailViewItem(id: UUID(), label: "受信", image: "tray"),
        ]),
        MailCategoryItem(id: UUID(), label: "Gmail", mailViewItemList: [
            MailViewItem(id: UUID(), label: "下書き", image: "tray"),
            MailViewItem(id: UUID(), label: "送信済み", image: "tray")
        ])
    ]
    
    var body: some View {
        NavigationStack {
            List(categoryList) { item in
                Section(
                    isExpanded: Binding(
                        get: { item.isExpanded },
                        set: {newValue in
                            let newItem = item.copyWith(isExpanded: newValue)
                            if let index = categoryList.firstIndex(where: {$0.id == item.id}) {
                                print(index)
                                categoryList[index] = newItem
                            }
                        }
                    )
                ){
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
