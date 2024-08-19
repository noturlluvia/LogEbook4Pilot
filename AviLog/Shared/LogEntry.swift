//
//  LogEntry.swift
//  AviLog
//
//  Created by Lluvia Jing on 8/8/24.

import Foundation

struct LogEntry: Identifiable {
    let id = UUID()  // Unique identifier for each log entry
    let date: Date
    let makeModel: String
    let idNumber: String
    let from: String
    let stops: String
    let to: String
    let dayLandings: Int
    let nightLandings: Int
    let instrumentApproachesNo: Int
    let instrumentApproachesTypeLocation1: String
    let instrumentApproachesTypeLocation2: String
    let instrumentApproachesTypeLocation3: String
    let aircraftCategorySingleEngine: Double
    let aircraftCategoryMultiEngine: Double
    let aircraftCategoryBlank1: Double
    let aircraftCategoryBlank2: Double
    let instrumentActual: Double
    let instrumentHooded: Double
    let instrumentSimulator: Double
    let nightTimeAll: Double
    let crossCountryAll: Double
    let crossCountryOver50nm: Double
    let picTime: Double
    let soloTime: Double
    let flightSimulator: Double
    let dualReceivedTime: Double
    let asFlightInstructorTime: Double
    let totalFlightTime: Double
    let remarks: String
}

class LogData: ObservableObject {
    @Published var entries: [LogEntry] = []
}
