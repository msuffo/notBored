import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    func setupViewControllers() {
        let firstTabTitle = ""
        let firstTabImage =  UIImage(systemName: "tray.full")
        let firstTab = CategoriesViewController(nibName: "CategoriesViewController", bundle: nil)
        firstTab.title = firstTabTitle
        let firstNavigationViewcontroller = UINavigationController(rootViewController: firstTab)
        firstNavigationViewcontroller.tabBarItem = UITabBarItem(title: firstTabTitle, image: firstTabImage, selectedImage: firstTabImage)
        
        let secondTabTitle = ""
        let secondTabImage =  UIImage(systemName: "lasso.and.sparkles")
        let secondTab = SuggestionViewController(nibName: "SuggestionViewController", bundle: nil)
        secondTab.title = secondTabTitle
        let secondNavigationViewcontroller = UINavigationController(rootViewController: secondTab)
        secondNavigationViewcontroller.tabBarItem = UITabBarItem(title: secondTabTitle, image: secondTabImage, selectedImage: secondTabImage)

        viewControllers = [firstNavigationViewcontroller, secondNavigationViewcontroller]
    }
}
