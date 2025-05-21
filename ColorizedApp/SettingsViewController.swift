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
    
    var initinalRedValue: Float!
    var initinalBlueValue: Float!
    var initinalGreenValue: Float!
    
    weak var delegate: SettingViewControllerDelegate?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentColorView.layer.cornerRadius = 20
        
        redSlider.value = initinalRedValue
        blueSlider.value = initinalBlueValue
        greenSlider.value = initinalGreenValue
        
        updateBackgroundColor()
        setupColorLabels()
    }

    // MARK: IB Actions
    @IBAction func redSliderAction() {
        redComponentLabel.text = String(format: "%.2f", redSlider.value)
        updateBackgroundColor()
    }
    
    @IBAction func greenSliderAction() {
        greenComponentLabel.text = String(format: "%.2f", greenSlider.value)
        updateBackgroundColor()
    }
    
    @IBAction func blueSliderAction() {
        blueComponentLabel.text = String(format: "%.2f", blueSlider.value)
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
}

