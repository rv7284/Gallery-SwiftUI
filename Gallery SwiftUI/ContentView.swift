//
//  ContentView.swift
//  Gallery SwiftUI
//
//  Created by Ravi Goswami on 31/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var showFilter = false
    @State private var contentMode: [ContentMode] = ContentMode.allCases
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: viewModel.cellSize))], spacing: 20) {
                    ForEach(viewModel.images, id: \.self) { item in
                        Image(uiImage: item)
                            .resizable()
                            .aspectRatio(contentMode: viewModel.photoContentMode)
                            .frame(width: viewModel.cellSize, height: viewModel.cellSize)
                            .overlay {
                                if viewModel.showBorder {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.gray, lineWidth: 1)
                                        .clipped()
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: viewModel.showBorder ? 8 : 0))
                    }
                }
                .animation(.default, value: viewModel.photoContentMode)
                .animation(.default, value: viewModel.showBorder)
                .animation(.default, value: viewModel.cellSize)
                .padding(.horizontal)
            }
            .onAppear {
                viewModel.checkPhotosPermission()
            }
            .navigationTitle("Photos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Menu {
                        Picker("Mode", selection: $viewModel.photoContentMode) {
                            ForEach(contentMode, id: \.self) {
                                Text(String(describing: $0).capitalized)
                            }
                        }
                        Toggle("Border", isOn: $viewModel.showBorder)
                        Slider(value: $viewModel.cellSize, in: 100...300) {
                            Text("Size")
                        }
                        Button {
                            viewModel.cellSize += 20
                        } label: {
                            Label("Zoom In", systemImage: "plus.magnifyingglass")
                        }
                        .disabled(viewModel.cellSize >= 300)
                        
                        
                        Button {
                            viewModel.cellSize -= 20
                        } label: {
                            Label("Zoom Out", systemImage: "minus.magnifyingglass")
                        }
                        .disabled(viewModel.cellSize <= 100)

                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
