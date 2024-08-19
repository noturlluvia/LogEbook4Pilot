//
//  LogEntriesView.swift
//  com.noturlluvia.AviLog
//
//  Created by Lluvia Jing on 8/18/24.

import SwiftUI

struct LogEntriesView: View {
    @EnvironmentObject var logData: LogData
    @State private var showingShareSheet = false
    @State private var csvURL: URL?

    var body: some View {
        ScrollView(.horizontal) {
            VStack(alignment: .leading) {
                Text("All Log Entries")
                    .font(.largeTitle)
                    .padding()

                // Export to CSV button
                Button(action: exportToCSV) {
                    Text("Export to CSV")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.orange.opacity(0.8))
                        .cornerRadius(8)
                }
                .sheet(isPresented: $showingShareSheet) {
                    if let url = csvURL {
                        ShareSheet(activityItems: [url])
                    }
                }
                .padding(.bottom, 10)

                if logData.entries.isEmpty {
                    Text("No entries logged yet. Please add a new entry.")
                        .foregroundColor(.gray)
                        .italic()
                        .padding()
                } else {
                    // Create a table-like view with selected columns
                    VStack {
                        // Header row
                        HStack {
                            Text("Date").bold().frame(maxWidth: .infinity, alignment: .leading)
                            Text("Total Flight Time").bold().frame(maxWidth: .infinity, alignment: .leading)
                            Text("Make & Model").bold().frame(maxWidth: .infinity, alignment: .leading)
                            Text("ID Number").bold().frame(maxWidth: .infinity, alignment: .leading)
                            Text("From").bold().frame(maxWidth: .infinity, alignment: .leading)
                            Text("To").bold().frame(maxWidth: .infinity, alignment: .leading)
                            // Add more headers as needed
                        }
                        .padding(.bottom, 10)

                        // Data rows
                        ForEach(logData.entries, id: \.id) { entry in
                            HStack {
                                Text(formattedDate(entry.date)).frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(entry.totalFlightTime, specifier: "%.2f") hours").frame(maxWidth: .infinity, alignment: .leading)
                                Text(entry.makeModel).frame(maxWidth: .infinity, alignment: .leading)
                                Text(entry.idNumber).frame(maxWidth: .infinity, alignment: .leading)
                                Text(entry.from).frame(maxWidth: .infinity, alignment: .leading)
                                Text(entry.to).frame(maxWidth: .infinity, alignment: .leading)
                                // Add more data as needed
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }

    // Function to generate CSV and save the file
    func exportToCSV() {
        let csvString = generateCSV(from: logData.entries)
        if let url = saveCSVFile(csvString) {
            csvURL = url
            showingShareSheet = true
        }
    }
}

// CSV generation and saving functions
func generateCSV(from entries: [LogEntry]) -> String {
    var csvString = "Date,Make & Model,ID Number,From,Stops,To,Day Landings,Night Landings,Instrument Approaches No.,Instrument Type Location 1,Instrument Type Location 2,Instrument Type Location 3,Single-Engine Time,Multi-Engine Time,Other Category 1 Time,Other Category 2 Time,Instrument Actual,Instrument Hooded,Instrument Simulator,Night Time,Cross Country Time,Cross Country Over 50nm,PIC Time,Solo Time,Flight Simulator,Dual Received Time,As Flight Instructor Time,Total Flight Time,Remarks\n"
    
    for entry in entries {
        let formattedDate = DateFormatter.localizedString(from: entry.date, dateStyle: .short, timeStyle: .none)
        csvString.append("\(formattedDate),\(entry.makeModel),\(entry.idNumber),\(entry.from),\(entry.stops),\(entry.to),\(entry.dayLandings),\(entry.nightLandings),\(entry.instrumentApproachesNo),\(entry.instrumentApproachesTypeLocation1),\(entry.instrumentApproachesTypeLocation2),\(entry.instrumentApproachesTypeLocation3),\(entry.aircraftCategorySingleEngine),\(entry.aircraftCategoryMultiEngine),\(entry.aircraftCategoryBlank1),\(entry.aircraftCategoryBlank2),\(entry.instrumentActual),\(entry.instrumentHooded),\(entry.instrumentSimulator),\(entry.nightTimeAll),\(entry.crossCountryAll),\(entry.crossCountryOver50nm),\(entry.picTime),\(entry.soloTime),\(entry.flightSimulator),\(entry.dualReceivedTime),\(entry.asFlightInstructorTime),\(entry.totalFlightTime),\(entry.remarks)\n")
    }
    
    return csvString
}

func saveCSVFile(_ csvString: String) -> URL? {
    let fileName = "LogEntries.csv"
    let path = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
    
    do {
        try csvString.write(to: path, atomically: true, encoding: .utf8)
        return path
    } catch {
        print("Error saving file: \(error)")
        return nil
    }
}

// ShareSheet for sharing the CSV file
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
