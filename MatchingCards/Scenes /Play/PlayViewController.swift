//
//  PlayViewController.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 14.12.2022.
//
import UIKit
import Foundation


protocol PlayDisplayLogic: AnyObject {
    func displayLoadGame(viewModel: Play.LoadGame.ViewModel)
    func displayShowCard(viewModel: Play.TouchCard.ViewModel)
    func displayHideCard(viewModel: Play.HideCards.ViewModel)
    func displayScore(viewModel: Play.Score.ViewModel)
}

class PlayViewController: UIViewController {
    var interactor: PlayBusinessLogic?
    var router: (PlayRoutingLogic & PlayDataPassing)?
    
    var backgroundRGB: Theme.CardColors?
    var defaultLevel: Int?
    var index = 0
    var score = 0
    var counter = 0
    
    var isInTransition: Bool = false
    
    var theme: Theme? {
        didSet {
            createCardDeck( level: defaultLevel)
            collectionView.reloadData()
        }
    }
    var cardDeck: [String] = []
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        let viewController = self
        let interactor = PlayInteractor()
        let presenter = PlayPresenter()
        let router = PlayRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        interactor?.loadTheme(request: .init())
        startTimer()
        
        scoreLabel.text = "play.score.label.start".localized()
    }
    
    // MARK: - Create the deck of cards
    private func startTimer() {
        timeLabel.text = "play.time.label.start".localized()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.counter += 1
            guard let counter = self?.counter else { return }
            switch counter {
            case 0 ..< 10:
                self?.timeLabel.text = "play.time.under10seconds".localized(counter)
            case 10 ... 60:
                self?.timeLabel.text = "play.time.over10seconds".localized(counter)
            default:
                break
            }
        }
    }
    private func createCardDeck(level: Int? ) {
        guard let symbols = theme?.symbols, let level = level else { return }
        var newDeckCard: [String] = []
        
        symbols.map {
            for _ in 0 ..< level*2 {
                newDeckCard.append($0)
            }
        }
        cardDeck = newDeckCard.shuffled()
    }
    
}
 
    // MARK: - UICollectionViewDataSource

extension PlayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "playCell", for: indexPath) as? PlayCollectionViewCell, let theme = theme else { preconditionFailure("Unnable to deque the cell")}
        let backgroundColor =  UIColor(red: theme.card_color.red, green: theme.card_color.green, blue: theme.card_color.blue, alpha: 1)
        
        cell.symbolOnTheBack.text = theme.card_symbol
        cell.symbolOnTheFront.text = cardDeck[indexPath.item]
        cell.frontView.backgroundColor = backgroundColor
        cell.backView.backgroundColor = backgroundColor
     
        cell.showCard(false, animated: false) { _ in }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardDeck.count
    }

  
}
    // MARK: - UICollectionViewDelegate

extension PlayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PlayCollectionViewCell else {
            preconditionFailure()
        }
        if cell.itIsShown || isInTransition { return }
            
        interactor?.didTouchCard(request: .init(card: Play.Card(id: indexPath, frontSymbol: cardDeck[indexPath.item])))
        collectionView.deselectItem(at: indexPath, animated: true)
        
//
        
        
    }

}
