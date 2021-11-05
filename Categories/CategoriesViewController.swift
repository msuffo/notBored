import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var randomButton: UIButton!
    
    var data = [  "Education",
                  "Recreational",
                  "Social",
                  "Diy",
                  "Charity",
                  "Cooking",
                  "Relaxation",
                  "Music",
                  "Busywork"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        getActivities()
    }
    
    private func getActivities(){
        tableView.reloadData()
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        
        let suggestionViewController = SuggestionViewController(nibName: "SuggestionViewController", bundle: nil)
        suggestionViewController.myTitle = "Random"
        
        navigationController?.pushViewController(suggestionViewController,animated: true)
    }
    
    private func showActivities(for activity:String){
        
        let suggestionViewController = SuggestionViewController(nibName: "SuggestionViewController", bundle: nil)
        suggestionViewController.myTitle = activity
      
        navigationController?.pushViewController(suggestionViewController,animated: true)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil )
    }
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       showActivities(for: data[indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}
