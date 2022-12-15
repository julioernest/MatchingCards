//
//  PlayCollectionViewCell.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 15.12.2022.
//

import Foundation
import UIKit

class PlayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var symbolOnTheBack: UILabel!
    
    @IBOutlet var symbolOnTheFront: UILabel!
    
    func showCard(_ show: Bool, animated: Bool) {
        symbolOnTheFront.isHidden = false
        symbolOnTheBack.isHidden = false
           
           if animated {
               if show {
                   UIView.transition(
                       from: symbolOnTheBack,
                       to: symbolOnTheFront,
                       duration: 0.5,
                       options: [.transitionFlipFromRight, .showHideTransitionViews],
                       completion: { (finished: Bool) -> () in
                   })
               } else {
                   UIView.transition(
                       from: symbolOnTheFront,
                       to: symbolOnTheBack,
                       duration: 0.5,
                       options: [.transitionFlipFromRight, .showHideTransitionViews],
                       completion:  { (finished: Bool) -> () in
                   })
               }
           } else {
               if show {
                   bringSubviewToFront(symbolOnTheFront)
                   symbolOnTheBack.isHidden = true
               } else {
                   bringSubviewToFront(symbolOnTheBack)
                   symbolOnTheFront.isHidden = true
               }
           }
       }
}
