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
}

class PlayViewController: UIViewController {
    var interactor: PlayBusinessLogic?
    var router: (PlayRoutingLogic & PlayDataPassing)?
    var backgroundRGB: Theme.CardColors?
    var defaultLevel = 3
    var index = 0
    var score = 0
    
    var shownCards: [IndexPath] = [] 
    
    
    var theme: Theme? {
        didSet {
            createCardDeck( level: defaultLevel)
            collectionView.reloadData()
        }
    }
    var cardDeck: [Play.Card] = []
    
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
        interactor?.loadTheme(request: .init())
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func createCardDeck(level: Int) {
        guard let symbols = theme?.symbols else { return }
        var newDeckCard: [Play.Card] = []
        symbols.map {
            for _ in 0 ..< level*2 {
                newDeckCard.append(Play.Card(state: .back, frontSymbol: $0))
            }
        }
        cardDeck = newDeckCard.shuffled()
    }
    
    private func didSelectCard(indexPath: IndexPath) {
        shownCards.append(indexPath)
        
        if shownCards.count > 1 {
            if cardDeck[indexPath.row] == cardDeck[shownCards[index].row] {
                
            }
        }
        guard let cell = collectionView.cellForItem(at: shownCards[index]) as? PlayCollectionViewCell else { return }
        cell.showCard(true, animated: true)
    }
}

extension PlayViewController: PlayDisplayLogic {
    func displayLoadGame(viewModel: Play.LoadGame.ViewModel) {
        let theme = viewModel.theme
        navigationItem.title = theme.title
        self.theme = theme
    }
}

extension PlayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "playCell", for: indexPath) as? PlayCollectionViewCell, let theme = theme else { preconditionFailure("Unnable to deque the cell")}
        
        
        cell.backgroundColor = UIColor(red: theme.card_color.red, green: theme.card_color.green, blue: theme.card_color.blue, alpha: 1)
        cell.symbolOnTheBack.text = theme.card_symbol
        cell.symbolOnTheFront.text = cardDeck[indexPath.row].frontSymbol
        cell.showCard(false, animated: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardDeck.count
    }

  
}

extension PlayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCard(indexPath: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
        
//        if  cardDeck[indexPath.row].state == .back {
//            cardDeck[indexPath.row].state = .front
//            collectionView.reloadData()
//        }
//
//        if let checkItem = checkItem, checkItem != indexPath.row{
//            if cardDeck[indexPath.row] == cardDeck[checkItem] {
//                cardDeck[indexPath.row].state = .matched
//                cardDeck[checkItem].state = .matched
//                score += 1
//                print(score)
//
//            } else {
//                cardDeck[indexPath.row].state = .back
//                cardDeck[checkItem].state = .back
//
//            }
//            collectionView.reloadData()
//            self.checkItem = nil
//            return
//        }
//
//        self.checkItem = indexPath.row
        
        
    }

}
