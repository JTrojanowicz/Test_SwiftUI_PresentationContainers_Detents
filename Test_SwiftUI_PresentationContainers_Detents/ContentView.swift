//
//  ContentView.swift
//  Test_SwiftUI_PresentationContainers_Detents
//
//  Created by Jaroslaw Trojanowicz on 27/07/2022.
//

import SwiftUI

struct MyDetent: CustomPresentationDetent {
    // 1
    static func height(in context: Context) -> CGFloat? {
        // 2
        return max(50, context.maxDetentValue * 0.1)
    }
}

struct ContentView: View {
    
    @State private var isShowingSheet = false
    let heights = stride(from: 0.1, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) }

    @State private var isShowingAnotherSheet = false
    @State var selectedDetent: PresentationDetent = .medium
    private let availableDetents: [PresentationDetent] = [.medium, .large]

    @State private var isShowingCustomPD = false
    
    var body: some View {
        VStack {
            Button("Show a sheet") {
                isShowingSheet.toggle()
            }
            
            Button("Show another sheet") {
                isShowingAnotherSheet.toggle()
            }
            
            Button("Show a sheet with custom presentation detent") {
                isShowingCustomPD.toggle()
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            VStack {
                Text("This is a sheet")
                    .padding()
                Button("Dismiss") {
                    isShowingSheet.toggle()
                }
            }
            // NOTICE: for the landscape orientation of an iPhone (small size) no matter what detent you select, the sheep will appear as a full screen --> make sure that you have a way to dismiss it.
            //                .presentationDetents([.medium])
            //                .presentationDetents([.medium, .large])
            //                .presentationDetents([.fraction(0.15)])
            .presentationDetents([.height(200)])
            //                .presentationDetents(Set(heights))
            
            .presentationDragIndicator(.hidden)
        }
        .sheet(isPresented: $isShowingAnotherSheet) {
            VStack {
                Text("This is another sheet")
                    .bold()
                    .padding()
                Picker("Selected Detent", selection: $selectedDetent) {
                    ForEach(availableDetents, id: \.self) {
                        Text($0.description.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                Spacer()
            }
            .presentationDetents([.medium, .large], selection: $selectedDetent)
        }
        .sheet(isPresented: $isShowingCustomPD) {
            Text("Detail")
                .presentationDetents([.custom(MyDetent.self)]) // NOTICE: Custom (.custom) detent lets you define your own logic for the height.
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("Default preview")
//                .previewInterfaceOrientation(.landscapeLeft) // can still be useful because enabling this modifier allow us to make clicks etc (whereas "Orientation variants allow us only to view the screen)
            //                .previewLayout(PreviewLayout.sizeThatFits) // sometimes it may be better to see only a single view, not the entire device
            
            ContentView()
                .previewDisplayName("iPad preview")
                .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)")) // list of devices --> run in Terminal: xcrun simctl list devicetypes
//            NOTICE: WHEN SHOWING ON IPAD, THE SHEETS ARE ALWAYS IN LARGE DETENT...
        }
    }
}
