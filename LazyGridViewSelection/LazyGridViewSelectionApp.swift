//
//  LazyGridViewSelectionApp.swift
//  LazyGridViewSelection
//
//  Created by Ilia Kolo on 21.09.2023.
//

import SwiftUI

@main
struct LazyGridViewSelectionApp: App {
    var body: some Scene {
        WindowGroup {
            LocalGridView()
                .frame(minWidth: 300, minHeight: 200)
        }
    }
}
