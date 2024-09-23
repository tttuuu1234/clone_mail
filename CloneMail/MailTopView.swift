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
    var imageColor: Color = .blue
    
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
            MailViewItem(id: UUID(), label: "VIP", image: "star", imageColor: .yellow)
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
                            // swiftではnilが入る可能性のある変数はoptional型になる。
                            // optional型の変数を使用するには、値がnilでないことを明示的にする必要がある。
                            // 変数にoptional型を適用することを、optional型でラップするという。→ var hoge: String?
                            // optional型の変数の値がnilでない保証をすることを、アンラップするという。→ if let hoge = hoge {}
                            // firstIndexメソッドの戻り値はint?でoptionalなint型なので、if let文でindexはnilでないことを保証した上でクロージャ内でindexを使用している。
                            // indexがnilならelseの方に入る。
                            if let index = categoryList.firstIndex(where: {$0.id == item.id}) {
                                print(index)
                                categoryList[index] = newItem
                            } else {
                                print("存在しないindex")
                            }
                        }
                    )
                ){
                    ForEach(item.mailViewItemList) { mailItem in
                        NavigationLink {
                            DamyView()
                        } label: {
                            // 文字と画像で別々にスタイルを適用したいため。
                            Label(title: {
                                Text(mailItem.label)
                            }, icon: {
                                Image(systemName: mailItem.image)
                                    .foregroundStyle(mailItem.imageColor)
                            })
                                
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
            .toolbar(content: {
                Button(action: {}, label: {
                    Text("編集")
                })
            })
            .listStyle(.sidebar)
        }
    }
}

#Preview {
    MailTopView()
}
