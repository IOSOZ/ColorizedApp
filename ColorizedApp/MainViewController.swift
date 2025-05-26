//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Олег Зуев on 20.05.2025.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    func updateBackgroundCollor (to color: UIColor)
}

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as? SettingsViewController
        
        let CGcomonents = getCGFloat(form: view.backgroundColor ?? .red)
        settingsVC?.initinalRedValue = Float(CGcomonents[0])
        settingsVC?.initinalGreenValue = Float(CGcomonents[1])
        settingsVC?.initinalBlueValue = Float(CGcomonents[2])
        
        settingsVC?.delegate = self
    }
    
    private func getCGFloat (form UIColor: UIColor) -> [CGFloat] {
        var CGcomponents: [CGFloat] = []
        if let components = UIColor.cgColor.components {
            for component in components {
                CGcomponents.append(component)
            }
        }
        return CGcomponents
    }
}
// MARK: - SettingViewControllerDelegate
extension MainViewController: SettingViewControllerDelegate {
    func updateBackgroundCollor(to color: UIColor) {
        view.backgroundColor = color
    }
}



