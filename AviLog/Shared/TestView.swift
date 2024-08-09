//
//  TestView.swift
//  AviLog
//
//  Created by Lluvia Jing on 8/8/24.
//

//import Foundation
import SwiftUI

struct TestView: View {
    @State private var input = ""

    var body: some View {
        VStack {
            TextField("Enter text", text: $input)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("You entered: \(input)")
                .padding()
        }
        .padding()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
