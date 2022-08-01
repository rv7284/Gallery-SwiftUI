//
//  FilterView.swift
//  Gallery SwiftUI
//
//  Created by Ravi Goswami on 31/07/22.
//

import SwiftUI

//struct ContentMode: Identifiable, Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    var id = UUID()
//    let title: String
//    let value: UIView.ContentMode
//
//    static let list = [ContentMode(title: "Fill", value: UIView.ContentMode.scaleAspectFill),
//                       ContentMode(title: "Fit", value: UIView.ContentMode.scaleAspectFit)]
//}

struct FilterView: View {
    
    
    @EnvironmentObject var viewModel: ViewModel
    @State private var contentMode: [ContentMode] = ContentMode.allCases
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Mode", selection: $viewModel.photoContentMode) {
                        ForEach(contentMode, id: \.self) {
                            Text(String(describing: $0).capitalized)
                        }
                    }
                    
                    Toggle("Border", isOn: $viewModel.showBorder)
                    Slider(value: $viewModel.cellSize, in: 100...300) {
                        Text("Size")
                    }
                }
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
            .environmentObject(ViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
}
