//
//  ContentView.swift
//  Shared
//
//  Created by Lluvia Jing on 8/8/24.
//

import SwiftUI

struct ContentView: View {
    // State variables for storing input values
    @State private var date = Date()
    @State private var makeModel = ""
    @State private var idNumber = ""
    @State private var from = ""
    @State private var stops = ""  // Optional stops field
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

    @State private var logEntries: [LogEntry] = []

    var totalFlightTime: Double {
        let singleEngine = Double(aircraftCategorySingleEngine) ?? 0
        let multiEngine = Double(aircraftCategoryMultiEngine) ?? 0
        let blank1 = Double(aircraftCategoryBlank1) ?? 0
        let blank2 = Double(aircraftCategoryBlank2) ?? 0
        return singleEngine + multiEngine + blank1 + blank2
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Flight Information")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Make and Model", text: $makeModel)
                    TextField("ID Number", text: $idNumber)
                    TextField("From", text: $from)
                    TextField("Stops", text: $stops)  // New stops field
                    TextField("To", text: $to)
                }

                Section(header: Text("Landings")) {
                    HStack {
                        TextField("Day", text: $dayLandings)
                        TextField("Night", text: $nightLandings)
                    }
                }

                Section(header: Text("Instrument Approaches")) {
                    TextField("No. of Approaches", text: $instrumentApproachesNo)
                    TextField("Type & Location 1", text: $instrumentApproachesTypeLocation1)
                    TextField("Type & Location 2", text: $instrumentApproachesTypeLocation2)
                    TextField("Type & Location 3", text: $instrumentApproachesTypeLocation3)
                }

                Section(header: Text("Aircraft Category and Class")) {
                    TextField("Single-Engine (Hours)", text: $aircraftCategorySingleEngine)
                    TextField("Multi-Engine (Hours)", text: $aircraftCategoryMultiEngine)
                    TextField("Other Category 1 (Hours)", text: $aircraftCategoryBlank1)
                    TextField("Other Category 2 (Hours)", text: $aircraftCategoryBlank2)
                }

                Section(header: Text("Instrument Time")) {
                    TextField("Actual Time (Hours)", text: $instrumentActual)
                    TextField("Hooded Time (Hours)", text: $instrumentHooded)
                    TextField("Simulator Time (Hours)", text: $instrumentSimulator)
                }

                Section(header: Text("Flight Time")) {
                    TextField("Night Time (Hours)", text: $nightTimeAll)
                    TextField("Cross Country Time (Hours)", text: $crossCountryAll)
                    TextField("Cross Country Over 50nm (Hours)", text: $crossCountryOver50nm)
                    TextField("PIC Time (Hours)", text: $picTime)
                    TextField("Solo Time (Hours)", text: $soloTime)
                    TextField("Flight Simulator (Hours)", text: $flightSimulator)
                    TextField("Dual Received (Hours)", text: $dualReceivedTime)
                    TextField("As Flight Instructor (Hours)", text: $asFlightInstructorTime)
                    Text("Total Flight Time (Hours): \(totalFlightTime, specifier: "%.2f")")
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
            .toolbar {
                NavigationLink(destination: SummaryView(logEntries: logEntries)) {
                    Text("View Summary")
                }
            }
        }
    }

    func saveLogEntry() {
        guard let dayLandingsInt = Int(dayLandings),
              let nightLandingsInt = Int(nightLandings),
              let instrumentApproachesNoInt = Int(instrumentApproachesNo),
              let singleEngineDouble = Double(aircraftCategorySingleEngine),
              let multiEngineDouble = Double(aircraftCategoryMultiEngine),
              let blank1Double = Double(aircraftCategoryBlank1),
              let blank2Double = Double(aircraftCategoryBlank2),
              let actualInstrumentDouble = Double(instrumentActual),
              let hoodedInstrumentDouble = Double(instrumentHooded),
              let simulatorInstrumentDouble = Double(instrumentSimulator),
              let nightTimeAllDouble = Double(nightTimeAll),
              let crossCountryAllDouble = Double(crossCountryAll),
              let crossCountryOver50nmDouble = Double(crossCountryOver50nm),
              let picTimeDouble = Double(picTime),
              let soloTimeDouble = Double(soloTime),
              let flightSimulatorDouble = Double(flightSimulator),
              let dualReceivedDouble = Double(dualReceivedTime),
              let asFlightInstructorDouble = Double(asFlightInstructorTime) else {
            return
        }

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
            aircraftCategorySingleEngine: singleEngineDouble,
            aircraftCategoryMultiEngine: multiEngineDouble,
            aircraftCategoryBlank1: blank1Double,
            aircraftCategoryBlank2: blank2Double,
            instrumentActual: actualInstrumentDouble,
            instrumentHooded: hoodedInstrumentDouble,
            instrumentSimulator: simulatorInstrumentDouble,
            nightTimeAll: nightTimeAllDouble,
            crossCountryAll: crossCountryAllDouble,
            crossCountryOver50nm: crossCountryOver50nmDouble,
            picTime: picTimeDouble,
            soloTime: soloTimeDouble,
            flightSimulator: flightSimulatorDouble,
            dualReceivedTime: dualReceivedDouble,
            asFlightInstructorTime: asFlightInstructorDouble,
            totalFlightTime: totalFlightTime,
            remarks: remarks
        )

        logEntries.append(newEntry)
    }
}
