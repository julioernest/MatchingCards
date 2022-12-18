//
//  ViewController.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 12.12.2022.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet var playButton: UIButton!
    @IBOutlet var scoreButton: UIButton!
    @IBOutlet var levelSegmentedControll: UISegmentedControl!
    @IBOutlet var themeSegmentedControll: UISegmentedControl!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    var interactor: MainBusinessLogic?
    var router: (MainRoutingLogic & MainDataPassing)?
    var data: [Theme]?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        activityIndicator.isHidden = true
        setup()
        loadData()
        
        
        // Do any additional setup after loading the view.
    }
    // MARK: - Set UP
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    func loadData() {
        interactor?.loadData(request: .init())
    }
    

    // MARK: - IBAction functions
    
    @IBAction func didTapLevel(_ sender: UISegmentedControl) {
        let selectedIndex  = sender.selectedSegmentIndex
        interactor?.setLevel(request: .init(index: selectedIndex))
    }
    
    @IBAction func didTapTheme(_ sender: UISegmentedControl) {
        let selectedIndex  = sender.selectedSegmentIndex
        interactor?.setTheme(request: .init(index: selectedIndex))
    }
    @IBAction func didTapPlayButton(_ sender: Any) {
        router?.showPlayScene()
    }
}

