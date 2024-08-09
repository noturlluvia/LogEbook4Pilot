//
//  LogEntry.swift
//  AviLog
//
//  Created by Lluvia Jing on 8/8/24.
//

import Foundation
import SwiftUI

struct LogEntry: Identifiable {
    let id = UUID()  // Unique identifier for each log entry
    let date: Date  // The date of the flight
    let makeModel: String  // The aircraft make and model
    let idNumber: String  // The aircraft identification number
    let from: String  // Departure location
    let stops: String  // Optional stops between origin and destination
    let to: String  // Arrival location
    let dayLandings: Int  // Number of landings during the day
    let nightLandings: Int  // Number of landings during the night
    let instrumentApproachesNo: Int  // Number of instrument approaches
    let instrumentApproachesTypeLocation1: String  // Type and location of the first instrument approach
    let instrumentApproachesTypeLocation2: String  // Type and location of the second instrument approach
    let instrumentApproachesTypeLocation3: String  // Type and location of the third instrument approach
    let aircraftCategorySingleEngine: Double  // Time logged in an Airplane Single-Engine Land
    let aircraftCategoryMultiEngine: Double  // Time logged in an Airplane Multi-Engine Land
    let aircraftCategoryBlank1: Double  // Blank column for user-defined or special classification
    let aircraftCategoryBlank2: Double  // Another blank column for user-defined or special classification
    let instrumentActual: Double  // Time spent flying under actual instrument conditions
    let instrumentHooded: Double  // Time spent flying under hooded (simulated instrument) conditions
    let instrumentSimulator: Double  // Time spent in a simulator under instrument conditions
    let nightTimeAll: Double  // Total night flying time (Page 2)
    let crossCountryAll: Double  // Total cross-country flying time (Page 2)
    let crossCountryOver50nm: Double  // Cross-country time over 50 nautical miles (Page 2)
    let picTime: Double  // Time spent as Pilot In Command (Page 2)
    let soloTime: Double  // Time spent flying solo (Page 2)
    let flightSimulator: Double  // Time spent using a flight simulator (FTD/ATD) (Page 2)
    let dualReceivedTime: Double  // Time spent with dual instruction received (Page 2)
    let asFlightInstructorTime: Double  // Time spent as a flight instructor (Page 2)
    let totalFlightTime: Double  // Total flight time for the entry (Page 2)
    let remarks: String  // Additional notes or comments about the flight (Page 2)
}
