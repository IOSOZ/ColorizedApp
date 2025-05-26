//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Олег Зуев on 11.04.2025.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: IB Outlets
    @IBOutlet var currentColorView: UIView!
    
    @IBOutlet var redComponentLabel: UILabel!
    @IBOutlet var greenComponentLabel: UILabel!
    @IBOutlet var blueComponentLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var initinalRedValue: Float!
    var initinalBlueValue: Float!
    var initinalGreenValue: Float!
    
    weak var delegate: SettingViewControllerDelegate?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        currentColorView.layer.cornerRadius = 20
        
        redSlider.value = initinalRedValue
        blueSlider.value = initinalBlueValue
        greenSlider.value = initinalGreenValue
        
        setupColorTextField()
        updateBackgroundColor()
        setupColorLabels()
    }
    
    // MARK: - Override Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: IB Actions
    @IBAction func sliderAction() {
        setupColorLabels()
        setupColorTextField()
        updateBackgroundColor()
    }
    
    @IBAction func doneButtonAction() {
        delegate?.updateBackgroundCollor(to: currentColorView.backgroundColor ?? .red)
        dismiss(animated: true)
    }
    
    // MARK: Private Methods
    private func setupColorLabels() {
        redComponentLabel.text = String(format: "%.2f", redSlider.value)
        greenComponentLabel.text = String(format: "%.2f", greenSlider.value)
        blueComponentLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setupColorTextField() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
        
        addDoneButtonToKeyborad(for: redTextField)
        addDoneButtonToKeyborad(for: greenTextField)
        addDoneButtonToKeyborad(for: blueTextField)
    }
    
    private func updateBackgroundColor() {
        let redColor = CGFloat(redSlider.value)
        let greenColor = CGFloat(greenSlider.value)
        let blueColor = CGFloat(blueSlider.value)
        
        currentColorView.backgroundColor = UIColor(
            red: redColor,
            green: greenColor,
            blue: blueColor,
            alpha: 1.0
        )
    }
    
    private func showAlert(withTitle title: String, andMessage message: String, completion: (() -> Void)? = nil){
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let value = Float(text), (0...1).contains(value) {
            switch textField {
            case redTextField:
                redSlider.setValue(value, animated: true)
            case greenTextField:
                greenSlider.setValue(value, animated: true)
            case blueTextField:
                blueSlider.setValue(value, animated: true)
            default:
                return
            }
            updateBackgroundColor()
            setupColorLabels()
            textField.text = String(format: "%.2f", value)
        } else {
            showAlert(withTitle: "Wrong format", andMessage: "Please use the value from 0 to 1")
            {switch textField {
            case self.redTextField:
                textField.text = self.redComponentLabel.text
            case self.greenTextField:
                textField.text = self.greenComponentLabel.text
            case self.blueTextField:
                textField.text = self.blueComponentLabel.text
            default:
                return
            }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func addDoneButtonToKeyborad( for textField: UITextField) {
        textField.keyboardType = .decimalPad
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceArea = UIBarButtonItem(systemItem: .flexibleSpace)
        let doneButton = UIBarButtonItem (
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
        toolbar.setItems([spaceArea,doneButton], animated: true)
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}

