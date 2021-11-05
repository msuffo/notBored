//
//  SuggestionViewController.swift
//  NotBored
//
//  Created by Mathias Ruiz Hernandez on 3/11/21.
//

import UIKit

class SuggestionViewController: UIViewController {
    
    @IBOutlet weak var suggestionTitle: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryPicture: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var suggestionLabel: UILabel!
    
    var myTitle: String!
    var activity: Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCategory()
        getSuggestion()
    }
    
    func setCategory(){
        if myTitle == nil {
            categoryPicture.isHidden = false
            categoryLabel.isHidden = false
            suggestionTitle.text = "Random"
        } else {
            categoryPicture.isHidden = true
            categoryLabel.isHidden = true
            suggestionTitle.text = myTitle
        }
    }
    
    private func getSuggestion(){
        getSuggestionForActivity()
    }
    
    private func getSuggestionForActivity(){
        var participants: Int?
        
        if DataService.shared.getNumberOfParticipants() != 0 {
            participants = DataService.shared.getNumberOfParticipants()
        }
        
        suggestionLabel.text = "Obteniendo sugerencia..."
        participantsLabel.text = participants == 0 || participants == nil ? "..." : String( participants! )
        priceLabel.text = "..."
        categoryLabel.text = "..."
        
        let selectedMinPrice = DataService.shared.getUserSelectedMinPrice()
        let selectedMaxPrice = DataService.shared.getUserSelectedMaxPrice()
        let actType = myTitle != nil ? myTitle.lowercased() : nil
        print( selectedMinPrice )
        let minPrice = selectedMinPrice == 0 ? 0.0 : selectedMinPrice
        let maxPrice = selectedMinPrice == 0 ? 1.0 : selectedMaxPrice
        
        ActivitiesService.shared.getActivity( type: actType, participants: participants, minPrice: minPrice, maxPrice: maxPrice, completion: { data in
                self.activity = data
                self.setActivityInfo()
            }, onError: {
                self.showErrorAlert()
            }
        )
    }
    
    private func setActivityInfo() {
        suggestionLabel.text = activity.activity
        participantsLabel.text = String( activity.participants )
        priceLabel.text = calcPrice()
        
        if myTitle == nil {
            categoryLabel.text = activity.type
        }
    }
    
    private func calcPrice()-> String {
        switch activity.price {
            case 0:
                return "Free"
            case 0...0.3:
                return "Low"
            case 0.3...0.6:
                return "Medium"
            case 0.6...:
                return "High"
            default:
                return ""
        }
    }
    
    @IBAction func tryAnotherSuggestion(_ sender: Any) {
        getSuggestion()
    }
    
    private func showErrorAlert() {
        let message = "No se pudo obtener una sugerencia"
        
        let alert = UIAlertController( title: "Error", message: message, preferredStyle: .alert )
        alert.addAction( UIAlertAction( title: "OK", style: .default, handler: nil ) )
        
        self.present( alert, animated: true )
    }
}
    
