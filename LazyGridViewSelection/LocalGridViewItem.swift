//
//  LocalGridViewItem.swift
//  LazyGridViewSelection
//
//  Created by Ilia Kolo on 21.09.2023.
//

import SwiftUI

struct LocalGridViewItem: View {

    @Environment(\.isFocused) var isFocused

    var text: String
    var isSelected: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(selectionColor)

            Text(text)
        }
        .frame(height: 50)
    }

    private var selectionColor: Color {
        if !isSelected {
            return .clear
        }
        return isFocused ? Color(.selectedContentBackgroundColor) : Color(.unemphasizedSelectedContentBackgroundColor)
    }
}
