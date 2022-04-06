//
//  ViewController.swift
//  Palette
//
//  Created by Анатолий Силиверстов on 19.11.2021.
//

import SwiftUI

class ViewController: UIViewController {

    @IBOutlet var palette: UIView!
    
    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenValue: UILabel!
    @IBOutlet var blueValue: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueText: UITextField!
    @IBOutlet var greenValueText: UITextField!
    @IBOutlet var blueValueText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        palette.layer.cornerRadius = 10
        
        setColor()
        setValueForLabel()
        setValueForTextField()
        
//        addDoneButtonTo(redValueText)
//        addDoneButtonTo(greenValueText)
//        addDoneButtonTo(blueValueText)
        
    }
    
    // Изменение цветов слайдерами
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redValue.text = String(format: "%.2f",sender.value)
            redValueText.text = String(format: "%.2f",sender.value)
        case 1:
            greenValue.text = String(format: "%.2f",sender.value)
            greenValueText.text = String(format: "%.2f",sender.value)
        case 2:
            blueValue.text = String(format: "%.2f",sender.value)
            blueValueText.text = String(format: "%.2f",sender.value)
        default: break
        }
        
        setColor()
        
    }
    
    // Цвет палитры из 3х цветов
    private func setColor() {
        palette.backgroundColor = UIColor.init(red: CGFloat(redSlider.value),
                                               green: CGFloat(greenSlider.value),
                                               blue: CGFloat(blueSlider.value),
                                               alpha: 1)
    }

    private func setValueForLabel() {
        redValue.text = String(format: "%.2f",redSlider.value)
        greenValue.text = String(format: "%.2f",greenSlider.value)
        blueValue.text = String(format: "%.2f",blueSlider.value)
    }
    
    private func setValueForTextField() {
        redValueText.text = String(format: "%.2f",redSlider.value)
        greenValueText.text = String(format: "%.2f",greenSlider.value)
        blueValueText.text = String(format: "%.2f",blueSlider.value)
    }
}

extension ViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру нажатием на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Скрытие клавиатуры по тапу за пределами Text View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true) // Скрывает клавиатуру, вызванную для любого обьекта
    }
    
    // Не работает хз почему
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            
            switch textField.tag {
            case 0: redSlider.value = currentValue
            case 1: greenSlider.value = currentValue
            case 2: blueSlider.value = currentValue
            default: break
            }
            
            setColor()
            setValueForLabel()
     }
            else {
            showAlert(title: "Wrong format", message: "Please enter correct value")
        }
    }
}

extension ViewController {
//
//    // Метод для отображения кнопки Done на цифровой клавиатуре
//    private func addDoneButtonTo(_ textField: UITextField) {
//
//        let keyboardToolbar = UIToolbar()
//        textField.inputAccessoryView = keyboardToolbar
//        keyboardToolbar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(title: "Done",
//                                         style: .done,
//                                         target: self,
//                                         action: #selector(didTapDone))
//
//        // Создаем невидимую и неактивную кнопку с гибким размером
//        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//                                            target: nil,
//                                            action: nil)
//
//        // Создаем массив кнопок на тулбаре и добавляем в него flexbarabutton, для того чтобы сместить кнопку Done  в правый край
//        keyboardToolbar.items = [flexBarButton, doneButton]
//    }
//
//    @objc private func didTapDone() {
//        view.endEditing(true)
//    }
//
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

struct ViewControllerRepresentation: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentation()
            .ignoresSafeArea()
    }
    
}


