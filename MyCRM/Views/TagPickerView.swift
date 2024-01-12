//
//  TagPickerView.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 10/1/24.
//

import SwiftUI

enum ContactTag: String, CaseIterable {
    case professional = "Professional"
    case personal = "Personal"
}
struct TagPicker: View {
    @Binding var selection: String

    var body: some View {
        HStack {
            Text("Tag")
                .font(.caption)
                .foregroundColor(.primary)
                .padding(4)
                .frame(width: 40, alignment: .leading)
            
            Picker("Tag", selection: $selection) {
                ForEach(ContactTag.allCases, id: \.self) { tag in
                    Text(tag.rawValue).tag(tag.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct TagPicker_Previews: PreviewProvider {
    @State static var previewSelection: String = ContactTag.personal.rawValue

    static var previews: some View {
        TagPicker(selection: $previewSelection)
    }
}
