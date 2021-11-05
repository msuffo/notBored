//
//  InitialViewController.swift
//  NotBored
//
//  Created by Mathias Ruiz Hernandez on 3/11/21.
//

import UIKit

class InitialViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var userSlider: UISlider!
    @IBOutlet weak var userSliderMax: UISlider!
    @IBOutlet weak var selectPriceButton: UIButton!
    
    var userSelectedPrice: Float!
    var numberOfParticipants: String!
    
    override func viewDidLoad() {
        userInput.delegate = self
        checkPriceButton()
        super.viewDidLoad()
        titleAnimation()
    }
    
    
    @IBAction func startButtonTapped(_ sender: Any) {
        
        let aceptedTC = DataService.shared.getAceptedTC()
        
        if aceptedTC {
           
            if userInput.hasText{
                DataService.shared.setNumberOfParticipants( Int( userInput.text! )! )
            }
            let setMinPrice = round(Float(userSlider.value) * 10) / 10.0
            let setMaxPrice = round(Float(userSliderMax.value) * 10) / 10.0
            DataService.shared.setUserSelectedMinPrice(setMinPrice)
            DataService.shared.setUserSelectedMaxPrice(setMaxPrice)
            presentTabBarController()
        }else{
            tcAlert()
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let vc = InformationViewController(
            nibName: "InformationViewController",
            bundle: nil)
        self.present(vc, animated: true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
             if let x = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {
                return true
             } else {
                 userCharAlert()
             return false
          }
    }
    
    private func presentTabBarController(){
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .overFullScreen
        self.present(tabBarController, animated: true)
    }
    
    func userCharAlert() {
        let alert = UIAlertController(title: "Alert", message: "Por favor ingrese solo números", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tcAlert() {
        let alert = UIAlertController(title: "Alert", message: "Debe aceptar los terminos y condiciones", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func titleAnimation(){
        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.fromValue = 0.0
        fadeAnim.toValue = 1.0
        fadeAnim.duration = 3.0
        titleLabel.layer.add(fadeAnim, forKey: "fadeAnim")
        titleLabel.layer.opacity = 1.0
    }
    
    @IBAction func selecPriceButtonTapped(_ sender: Any) {
        let aceptedTC = DataService.shared.getSelectedPrice()
        
        if aceptedTC {
            
            if let image = UIImage(systemName: "square.dashed") {
                selectPriceButton.setImage(image, for: .normal)
            }
            DataService.shared.setSelectedPrice(false)
        }else{
            if let image = UIImage(systemName: "checkmark.square") {
                selectPriceButton.setImage(image, for: .normal)
            }
            DataService.shared.setSelectedPrice(true)
        }
    }
    
    func checkPriceButton(){
        let aceptedTC = DataService.shared.getAceptedTC()
        if aceptedTC {
            if let image = UIImage(systemName: "checkmark.square") {
                selectPriceButton.setImage(image, for: .normal)
            }
        }
        
    }
}

