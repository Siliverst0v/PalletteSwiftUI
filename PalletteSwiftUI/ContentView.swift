//
//  ContentView.swift
//  PalletteSwiftUI
//
//  Created by Анатолий Силиверстов on 03.04.2022.
//

import SwiftUI

class SliderValues: ObservableObject {
@Published var ewrw = ""
}

struct ContentView: View {
    
    @ObservedObject var model = SliderValues()

    @State private var inputRedSliderValue = "100"
    @State private var inputGreenSliderValue = "100"
    @State private var inputBlueSliderValue = "100"

    @State private var redSelectedSliderValue = Double.random(in: 0...255)
    @State private var greenSelectedSliderValue = Double.random(in: 0...255)
    @State private var blueSelectedSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Color.init(red: 0/255, green: 0/255, blue: 240/255)
                .ignoresSafeArea()
            VStack {
                PalletteView(redColor: $redSelectedSliderValue, greenColor: $greenSelectedSliderValue, blueColor: $blueSelectedSliderValue)
                    .padding()
                ColorSlider(textValue: $redSelectedSliderValue, inputValue: $inputRedSliderValue)
                    .tint(Color.red)
                ColorSlider(textValue: $greenSelectedSliderValue, inputValue: $inputGreenSliderValue)
                    .tint(Color.green)
                ColorSlider(textValue: $blueSelectedSliderValue, inputValue: $inputBlueSliderValue)
                    .tint(Color.blue)
                Spacer()
            }
        }
    }
}


struct ColorSlider: View {
    @Binding var textValue: Double
    @Binding var inputValue: String
    var body: some View {
        HStack {
            Text("\(lround(textValue))")
                .foregroundColor(.white)
            Slider(value: $textValue, in: 0...255, step: 1)
            TextField("0-255", text: $inputValue)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(5)
        }
        .padding(.horizontal)
    }
}

struct PalletteView: View {
    @Binding var redColor: Double
    @Binding var greenColor: Double
    @Binding var blueColor: Double
    
    var body: some View {
                
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 350, height: 140)
            .foregroundColor(.init(red: redColor/255, green: greenColor/255, blue: blueColor/255))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 4)
                    .foregroundColor(.white)
            )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
