//
//  SpeakProgressStyle.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 11/1/24.
//

import SwiftUI

struct SpeakProgressStyle: ProgressViewStyle {
//    var tag: Tag

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)

                .frame(height: 20.0)
            if #available(iOS 15.0, *) {
                ProgressView(configuration)

                    .frame(height: 12.0)
                    .padding(.horizontal)
            } else {
                ProgressView(configuration)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            }
        }
    }
}

struct SpeakProgresswStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 0.4)
            .progressViewStyle(SpeakProgressStyle())
            .previewLayout(.sizeThatFits)
    }
}
