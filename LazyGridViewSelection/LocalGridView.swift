//
//  LocalGridView.swift
//  LazyGridViewSelection
//
//  Created by Ilia Kolo on 21.09.2023.
//

import SwiftUI

struct LocalGridView: View {

    private let columns = [GridItem(.adaptive(minimum: 100))]

    let items = (0..<99).map { "item \($0)" }

    @State private var selectedItem: String? = nil
    @State private var someText: String = ""
    @State private var logLine: String = ""

    private enum FocusableView: String, Hashable {

        case textField
        case grid
    }

    @FocusState private var focusOn: FocusableView?

    var body: some View {
        Self._printChanges()
        return VStack {
            TextField("", text: $someText)
                .padding()
                .focused($focusOn, equals: .textField)

            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(items, id: \.self) { item in
                        LocalGridViewItem(
                            text: item,
                            isSelected: item == selectedItem
                        )
                        .onTapGesture {
                            focusOn = .grid
                            selectedItem = item
                        }
                    }
                }
                // On macOS 14 focus effect appears, which could be removed with `focusEffectDisabled()`
                // On macOS 13 this modifier enables focus move from and to the text field above,
                // but it never lands up on the grid view.
                .focusable()
                .focused($focusOn, equals: .grid)
            }
            // This works only with a view, which has current focus
//            .onMoveCommand(perform: { direction in
//                switch direction {
//                case .up: onMoveUp()
//                case .down: onMoveDown()
//                case .left: onMoveUp()
//                case .right: onMoveDown()
//                @unknown default: break
//                }
//            })
            .padding(.horizontal)

            Divider()

            Text(logLine)
                .padding()

            // As I cannot use right now .onMoveCommand, I can create invisible buttons which would react on
            // movement shortcuts.
            // But in this case it is not guarded by the focused state and they intercept text field navigation,
            // so I need to set up keyboard shortcuts conditionally, which rises question:
            // how to track focused view on macOS 13 (and preferably on macOS 12 as well).
            HStack {
                Button("") { onMoveUp() }.keyboardShortcut(.upArrow, modifiers: [])
                Button("") { onMoveDown() }.keyboardShortcut(.downArrow, modifiers: [])
                Button("") { onMoveUp() }.keyboardShortcut(.leftArrow, modifiers: [])
                Button("") { onMoveDown() }.keyboardShortcut(.rightArrow, modifiers: [])
            }
            .opacity(0)
            .frame(width: 0, height: 0)
        }
        .onAppear {
            focusOn = .grid
        }
        .onChange(of: focusOn) { value in
            logLine = "onChange: \(value?.rawValue ?? "no focus")"
        }
    }

    private func onMoveUp() {
        guard let item = selectedItem else {
            selectedItem = items.last
            return
        }

        guard let index = items.firstIndex(of: item)?.advanced(by: -1), items.indices.contains(index) else {
            return
        }

        self.selectedItem = items[index]
    }

    private func onMoveDown() {
        guard let item = selectedItem else {
            selectedItem = items.first
            return
        }

        guard let index = items.firstIndex(of: item)?.advanced(by: 1), items.indices.contains(index) else {
            return
        }

        selectedItem = items[index]
    }
}
