//
//  Gallery_SwiftUIApp.swift
//  Gallery SwiftUI
//
//  Created by Ravi Goswami on 31/07/22.
//

import SwiftUI

@main
struct Gallery_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
        }
    }
}
