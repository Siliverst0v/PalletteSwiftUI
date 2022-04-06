//
//  StarterView.swift
//  PalletteSwiftUI
//
//  Created by Анатолий Силиверстов on 06.04.2022.
//

import SwiftUI

struct StarterView: View {
    
    @State private var swiftUIViewIsPresented = false
    @State private var uiViewIsPresented = false
    
    var body: some View {
        VStack{
            Button("Show SwiftUI View") {
                swiftUIViewIsPresented.toggle()
            }
            .sheet(isPresented: $swiftUIViewIsPresented) {
                ContentView()
            }
            Button("Show UIKit View") {
                uiViewIsPresented.toggle()
            }
            .sheet(isPresented: $uiViewIsPresented) {
                ViewControllerRepresentation()
                    .ignoresSafeArea()
            }
        }
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
    }
}
