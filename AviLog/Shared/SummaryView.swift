//
//  SummaryView.swift
//  AviLog
//
//  Created by Lluvia Jing on 8/8/24.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var logData: LogData

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    // Button to add a new log entry
                    HStack {
                        NavigationLink(destination: ContentView()) {
                            Text("Add New Log")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red.opacity(0.6))
                                .cornerRadius(8)
                        }

                        NavigationLink(destination: LogEntriesView()) {
                            Text("View All Logs")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue.opacity(0.6))
                                .cornerRadius(8)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    // Summary content here
                    GroupBox(label: Text("Total Landings")) {
                        Text("Day: \(calculateTotalLandings())")
                        Text("Night: \(calculateTotalNightLandings())")
                    }

                    GroupBox(label: Text("Instrument Approaches")) {
                        Text("Total Instrument Approaches: \(calculateTotalInstrumentApproaches())")
                    }

                    GroupBox(label: Text("Aircraft Category and Class")) {
                        Text("Single-Engine: \(calculateTotalSingleEngine(), specifier: "%.2f") hours")
                        Text("Multi-Engine: \(calculateTotalMultiEngine(), specifier: "%.2f") hours")
                        Text("Other Category 1: \(calculateTotalBlank1(), specifier: "%.2f") hours")
                        Text("Other Category 2: \(calculateTotalBlank2(), specifier: "%.2f") hours")
                    }

                    GroupBox(label: Text("Instrument Time")) {
                        Text("Actual: \(calculateTotalInstrumentActual(), specifier: "%.2f") hours")
                        Text("Hooded: \(calculateTotalInstrumentHooded(), specifier: "%.2f") hours")
                        Text("Simulator: \(calculateTotalInstrumentSimulator(), specifier: "%.2f") hours")
                    }

                    GroupBox(label: Text("Flight Time")) {
                        Text("Night Time: \(calculateTotalNightTime(), specifier: "%.2f") hours")
                        Text("Cross Country Time: \(calculateTotalCrossCountryAll(), specifier: "%.2f") hours")
                        Text("Cross Country Over 50nm: \(calculateTotalCrossCountryOver50nm(), specifier: "%.2f") hours")
                        Text("PIC Time: \(calculateTotalPIC(), specifier: "%.2f") hours")
                        Text("Solo Time: \(calculateTotalSolo(), specifier: "%.2f") hours")
                        Text("Flight Simulator: \(calculateTotalFlightSimulator(), specifier: "%.2f") hours")
                        Text("Dual Received: \(calculateTotalDualReceived(), specifier: "%.2f") hours")
                        Text("As Flight Instructor: \(calculateTotalAsFlightInstructor(), specifier: "%.2f") hours")
                        Text("Total Flight Time: \(calculateTotalFlightTime(), specifier: "%.2f") hours")
                    }
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Flight Summary")
        }
    }

    // Helper functions to calculate totals for each category
    func calculateTotalLandings() -> Int {
        return logData.entries.reduce(0) { $0 + $1.dayLandings }
    }

    func calculateTotalNightLandings() -> Int {
        return logData.entries.reduce(0) { $0 + $1.nightLandings }
    }

    func calculateTotalInstrumentApproaches() -> Int {
        return logData.entries.reduce(0) { $0 + $1.instrumentApproachesNo }
    }

    func calculateTotalSingleEngine() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.aircraftCategorySingleEngine }
    }

    func calculateTotalMultiEngine() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.aircraftCategoryMultiEngine }
    }

    func calculateTotalBlank1() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.aircraftCategoryBlank1 }
    }

    func calculateTotalBlank2() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.aircraftCategoryBlank2 }
    }

    func calculateTotalInstrumentActual() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.instrumentActual }
    }

    func calculateTotalInstrumentHooded() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.instrumentHooded }
    }

    func calculateTotalInstrumentSimulator() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.instrumentSimulator }
    }

    func calculateTotalNightTime() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.nightTimeAll }
    }

    func calculateTotalCrossCountryAll() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.crossCountryAll }
    }

    func calculateTotalCrossCountryOver50nm() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.crossCountryOver50nm }
    }

    func calculateTotalPIC() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.picTime }
    }

    func calculateTotalSolo() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.soloTime }
    }

    func calculateTotalFlightSimulator() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.flightSimulator }
    }

    func calculateTotalDualReceived() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.dualReceivedTime }
    }

    func calculateTotalAsFlightInstructor() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.asFlightInstructorTime }
    }

    func calculateTotalFlightTime() -> Double {
        return logData.entries.reduce(0.0) { $0 + $1.totalFlightTime }
    }
}


