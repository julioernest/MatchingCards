//
//  ViewController.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 12.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var playButton: UIButton!
    @IBOutlet var scoreButton: UIButton!
    @IBOutlet var levelSegmentedControll: UISegmentedControl!
    @IBOutlet var themeSegmentedControll: UISegmentedControl!
    
    let service = PlayService()
    var data: [Theme]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpButtons()
        loadData()
        
        // Do any additional setup after loading the view.
    }

    func setUpButtons() {
        playButton.layer.cornerRadius = 0.1
    }
    func loadData() {
        service.getConcentrationGameThemes(url: WebService.firebaseLink) { [weak self] response in
            switch response {
            case let .success(theme):
                self?.data = theme
            case let .failure(error):
                print(error)
            }
        }
    }

    @IBAction func didTapPlayButton(_ sender: Any) {
        guard let data = data,
        let nextViewController = UIStoryboard(name: "Play", bundle: nil).instantiateInitialViewController() as? PlayViewController else { return }
        
        var dataStore = nextViewController.router?.dataStore
        dataStore?.theme = data.first
        
        navigationController?.pushViewController(nextViewController, animated: true)
        
       
    }
}

