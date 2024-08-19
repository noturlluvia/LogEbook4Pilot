//
//  ContentView.swift
//  Shared
//
//  Created by Lluvia Jing on 8/8/24.

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var logData: LogData
    @Environment(\.presentationMode) var presentationMode

    // State variables for storing input values
    @State private var date = Date()
    @State private var makeModel = ""
    @State private var idNumber = ""
    @State private var from = ""
    @State private var stops = ""
    @State private var to = ""
    @State private var dayLandings = ""
    @State private var nightLandings = ""
    @State private var instrumentApproachesNo = ""
    @State private var instrumentApproachesTypeLocation1 = ""
    @State private var instrumentApproachesTypeLocation2 = ""
    @State private var instrumentApproachesTypeLocation3 = ""
    @State private var aircraftCategorySingleEngine = ""
    @State private var aircraftCategoryMultiEngine = ""
    @State private var aircraftCategoryBlank1 = ""
    @State private var aircraftCategoryBlank2 = ""
    @State private var instrumentActual = ""
    @State private var instrumentHooded = ""
    @State private var instrumentSimulator = ""
    @State private var nightTimeAll = ""
    @State private var crossCountryAll = ""
    @State private var crossCountryOver50nm = ""
    @State private var picTime = ""
    @State private var soloTime = ""
    @State private var flightSimulator = ""
    @State private var dualReceivedTime = ""
    @State private var asFlightInstructorTime = ""
    @State private var remarks = ""

    // Computed property for total flight time
    private var totalFlightTime: Double {
        let total = [
            Double(aircraftCategorySingleEngine) ?? 0.0,
            Double(aircraftCategoryMultiEngine) ?? 0.0,
            Double(aircraftCategoryBlank1) ?? 0.0,
            Double(aircraftCategoryBlank2) ?? 0.0
        ].reduce(0, +)
        return total
    }

    var body: some View {
        Form {
            Section(header: Text("Flight Information")) {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Make and Model", text: $makeModel)
                TextField("ID Number", text: $idNumber)
                TextField("From", text: $from)
                TextField("Stops", text: $stops)
                TextField("To", text: $to)
            }

            Section(header: Text("Landings")) {
                HStack {
                    TextField("Day", text: $dayLandings)
                        .keyboardType(.numberPad)
                    TextField("Night", text: $nightLandings)
                        .keyboardType(.numberPad)
                }
            }

            Section(header: Text("Instrument Approaches")) {
                TextField("No. of Approaches", text: $instrumentApproachesNo)
                    .keyboardType(.numberPad)
                TextField("Type & Location 1", text: $instrumentApproachesTypeLocation1)
                TextField("Type & Location 2", text: $instrumentApproachesTypeLocation2)
                TextField("Type & Location 3", text: $instrumentApproachesTypeLocation3)
            }

            Section(header: Text("Aircraft Category and Class")) {
                TextField("Single-Engine (Hours)", text: $aircraftCategorySingleEngine)
                    .keyboardType(.decimalPad)
                TextField("Multi-Engine (Hours)", text: $aircraftCategoryMultiEngine)
                    .keyboardType(.decimalPad)
                TextField("Other Category 1 (Hours)", text: $aircraftCategoryBlank1)
                    .keyboardType(.decimalPad)
                TextField("Other Category 2 (Hours)", text: $aircraftCategoryBlank2)
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("Instrument Time")) {
                TextField("Actual Time (Hours)", text: $instrumentActual)
                    .keyboardType(.decimalPad)
                TextField("Hooded Time (Hours)", text: $instrumentHooded)
                    .keyboardType(.decimalPad)
                TextField("Simulator Time (Hours)", text: $instrumentSimulator)
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("Flight Time")) {
                TextField("Night Time (Hours)", text: $nightTimeAll)
                    .keyboardType(.decimalPad)
                TextField("Cross Country Time (Hours)", text: $crossCountryAll)
                    .keyboardType(.decimalPad)
                TextField("Cross Country Over 50nm (Hours)", text: $crossCountryOver50nm)
                    .keyboardType(.decimalPad)
                TextField("PIC Time (Hours)", text: $picTime)
                    .keyboardType(.decimalPad)
                TextField("Solo Time (Hours)", text: $soloTime)
                    .keyboardType(.decimalPad)
                TextField("Flight Simulator (Hours)", text: $flightSimulator)
                    .keyboardType(.decimalPad)
                TextField("Dual Received (Hours)", text: $dualReceivedTime)
                    .keyboardType(.decimalPad)
                TextField("As Flight Instructor (Hours)", text: $asFlightInstructorTime)
                    .keyboardType(.decimalPad)
                Text("Total Flight Time: \(totalFlightTime, specifier: "%.2f")")
            }

            Section(header: Text("Remarks")) {
                TextEditor(text: $remarks)
                    .frame(height: 100)
            }

            Button(action: saveLogEntry) {
                Text("Save Log Entry")
            }
        }
        .navigationTitle("Logbook Entry")
    }

    // Save log entry action
    func saveLogEntry() {
        // Handle empty numeric fields by defaulting them to 0
        let dayLandingsInt = Int(dayLandings) ?? 0
        let nightLandingsInt = Int(nightLandings) ?? 0
        let instrumentApproachesNoInt = Int(instrumentApproachesNo) ?? 0

        let newEntry = LogEntry(
            date: date,
            makeModel: makeModel,
            idNumber: idNumber,
            from: from,
            stops: stops,
            to: to,
            dayLandings: dayLandingsInt,
            nightLandings: nightLandingsInt,
            instrumentApproachesNo: instrumentApproachesNoInt,
            instrumentApproachesTypeLocation1: instrumentApproachesTypeLocation1,
            instrumentApproachesTypeLocation2: instrumentApproachesTypeLocation2,
            instrumentApproachesTypeLocation3: instrumentApproachesTypeLocation3,
            aircraftCategorySingleEngine: Double(aircraftCategorySingleEngine) ?? 0.0,
            aircraftCategoryMultiEngine: Double(aircraftCategoryMultiEngine) ?? 0.0,
            aircraftCategoryBlank1: Double(aircraftCategoryBlank1) ?? 0.0,
            aircraftCategoryBlank2: Double(aircraftCategoryBlank2) ?? 0.0,
            instrumentActual: Double(instrumentActual) ?? 0.0,
            instrumentHooded: Double(instrumentHooded) ?? 0.0,
            instrumentSimulator: Double(instrumentSimulator) ?? 0.0,
            nightTimeAll: Double(nightTimeAll) ?? 0.0,
            crossCountryAll: Double(crossCountryAll) ?? 0.0,
            crossCountryOver50nm: Double(crossCountryOver50nm) ?? 0.0,
            picTime: Double(picTime) ?? 0.0,
            soloTime: Double(soloTime) ?? 0.0,
            flightSimulator: Double(flightSimulator) ?? 0.0,
            dualReceivedTime: Double(dualReceivedTime) ?? 0.0,
            asFlightInstructorTime: Double(asFlightInstructorTime) ?? 0.0,
            totalFlightTime: totalFlightTime,
            remarks: remarks
        )

        logData.entries.append(newEntry)
        presentationMode.wrappedValue.dismiss() // Navigate back to the summary view
    }
}

