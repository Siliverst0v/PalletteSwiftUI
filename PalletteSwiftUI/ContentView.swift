//
//  ContentView.swift
//  PalletteSwiftUI
//
//  Created by Анатолий Силиверстов on 03.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputRedSliderValue = ""
    @State private var inputGreenSliderValue = ""
    @State private var inputBlueSliderValue = ""

    @State private var redSelectedSliderValue = Double.random(in: 0...255)
    @State private var greenSelectedSliderValue = Double.random(in: 0...255)
    @State private var blueSelectedSliderValue = Double.random(in: 0...255)
        
    var body: some View {
        ZStack {
            Color.init(red: 0/255, green: 0/255, blue: 250/255, opacity: 0.8)
                .ignoresSafeArea()
            VStack {
                PalletteView(redColor: redSelectedSliderValue, greenColor: greenSelectedSliderValue, blueColor: blueSelectedSliderValue)
                    .padding()
                ColorSlider(sliderValue: $redSelectedSliderValue, inputValue: $inputRedSliderValue)
                    .tint(Color.red)
                ColorSlider(sliderValue: $greenSelectedSliderValue, inputValue: $inputGreenSliderValue)
                    .tint(Color.green)
                ColorSlider(sliderValue: $blueSelectedSliderValue, inputValue: $inputBlueSliderValue)
                    .tint(Color.blue)
                Spacer()
            }
        }
    }
}


struct ColorSlider: View {
    @Binding var sliderValue: Double
    @Binding var inputValue: String
    
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            Text("\(lround(sliderValue))")
                .foregroundColor(.white)
                .frame(width: 40)
            Slider(value: $sliderValue, in: 0...255, step: 1)
                .onChange(of: sliderValue) { _ in
                    inputValue = "\(lround(sliderValue))"
                }
                .onAppear {
                    inputValue = "\(lround(sliderValue))"
                }
            TextField("", text: $inputValue, onCommit: checkInputValue)
                .textFieldStyle(.roundedBorder)
                .frame(width: 55.0, alignment: .trailing)
                .multilineTextAlignment(.trailing)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Wrong Format"), message: Text("Please enter value from 0 to 255"))
                }
        }
        .padding(.horizontal)
    }
    
    private func checkInputValue() {
        if let value = Int(inputValue), (0...255).contains(value) {
            self.sliderValue = Double(value)
            return
        }
        showAlert.toggle()
        inputValue = ""
    }
}

struct PalletteView: View {
    
    let redColor: Double
    let greenColor: Double
    let blueColor: Double
    
    var body: some View {
                
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 350, height: 140)
            .foregroundColor(.init(red: redColor/255, green: greenColor/255, blue: blueColor/255))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 4)
            )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
