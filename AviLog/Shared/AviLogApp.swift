//
//  AviLogApp.swift
//  Shared
//
//  Created by Lluvia Jing on 8/8/24.

import SwiftUI

@main
struct AviLogApp: App {
    @StateObject private var logData = LogData() // Shared log data

    var body: some Scene {
        WindowGroup {
            SummaryView() // Set SummaryView as the main page
                .environmentObject(logData)
        }
    }
}
