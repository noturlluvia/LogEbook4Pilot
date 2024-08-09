//
//  SummaryView.swift
//  AviLog
//
//  Created by Lluvia Jing on 8/8/24.
//

import SwiftUI

struct SummaryView: View {
    var logEntries: [LogEntry]
    
    // Set default start date to 30 days before today
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
    // Set default end date to today
    @State private var endDate: Date = Date()
    @State private var showFilteredResults = false

    var filteredEntries: [LogEntry] {
        if showFilteredResults {
            return logEntries.filter { $0.date >= startDate && $0.date <= endDate }
        } else {
            return logEntries
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Date Range Picker
                    GroupBox(label: Text("Select Date Range")) {
                        VStack(spacing: 10) {
                            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                            
                            HStack {
                                Button(action: {
                                    showFilteredResults = true
                                }) {
                                    Text("Apply Filter")
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                                
                                Button(action: {
                                    // Reset to show all entries
                                    showFilteredResults = false
                                    // Optionally, reset dates to defaults
                                    startDate = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
                                    endDate = Date()
                                }) {
                                    Text("Reset Filter")
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.red)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
                    }
                    
                    // Total Landings
                    GroupBox(label: Text("Total Landings")) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Day: \(calculateTotalLandings())")
                            Text("Night: \(calculateTotalNightLandings())")
                        }
                        .padding()
                    }

                    // Instrument Approaches
                    GroupBox(label: Text("Instrument Approaches")) {
                        Text("Total Instrument Approaches: \(calculateTotalInstrumentApproaches())")
                            .padding()
                    }

                    // Aircraft Category and Class
                    GroupBox(label: Text("Aircraft Category and Class")) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Single-Engine: \(calculateTotalSingleEngine(), specifier: "%.2f") hours")
                            Text("Multi-Engine: \(calculateTotalMultiEngine(), specifier: "%.2f") hours")
                            Text("Other Category 1: \(calculateTotalBlank1(), specifier: "%.2f") hours")
                            Text("Other Category 2: \(calculateTotalBlank2(), specifier: "%.2f") hours")
                        }
                        .padding()
                    }

                    // Instrument Time
                    GroupBox(label: Text("Instrument Time")) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Actual: \(calculateTotalInstrumentActual(), specifier: "%.2f") hours")
                            Text("Hooded: \(calculateTotalInstrumentHooded(), specifier: "%.2f") hours")
                            Text("Simulator: \(calculateTotalInstrumentSimulator(), specifier: "%.2f") hours")
                        }
                        .padding()
                    }

                    // Flight Time
                    GroupBox(label: Text("Flight Time")) {
                        VStack(alignment: .leading, spacing: 5) {
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
                        .padding()
                    }
                }
                .padding()
            }
            .navigationBarTitle("Flight Summary", displayMode: .inline)
            .background(Color(UIColor.systemGroupedBackground))
        }
    }

    // Helper functions to calculate totals for each category
    func calculateTotalLandings() -> Int {
        return filteredEntries.reduce(0) { $0 + $1.dayLandings }
    }

    func calculateTotalNightLandings() -> Int {
        return filteredEntries.reduce(0) { $0 + $1.nightLandings }
    }

    func calculateTotalInstrumentApproaches() -> Int {
        return filteredEntries.reduce(0) { $0 + $1.instrumentApproachesNo }
    }

    func calculateTotalSingleEngine() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.aircraftCategorySingleEngine }
    }

    func calculateTotalMultiEngine() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.aircraftCategoryMultiEngine }
    }

    func calculateTotalBlank1() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.aircraftCategoryBlank1 }
    }

    func calculateTotalBlank2() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.aircraftCategoryBlank2 }
    }

    func calculateTotalInstrumentActual() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.instrumentActual }
    }

    func calculateTotalInstrumentHooded() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.instrumentHooded }
    }

    func calculateTotalInstrumentSimulator() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.instrumentSimulator }
    }

    func calculateTotalNightTime() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.nightTimeAll }
    }

    func calculateTotalCrossCountryAll() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.crossCountryAll }
    }

    func calculateTotalCrossCountryOver50nm() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.crossCountryOver50nm }
    }

    func calculateTotalPIC() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.picTime }
    }

    func calculateTotalSolo() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.soloTime }
    }

    func calculateTotalFlightSimulator() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.flightSimulator }
    }

    func calculateTotalDualReceived() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.dualReceivedTime }
    }

    func calculateTotalAsFlightInstructor() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.asFlightInstructorTime }
    }

    func calculateTotalFlightTime() -> Double {
        return filteredEntries.reduce(0.0) { $0 + $1.totalFlightTime }
    }
}
