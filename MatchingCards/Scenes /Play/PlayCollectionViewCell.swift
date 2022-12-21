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
    
    @IBOutlet var frontView: UIView!
    @IBOutlet var backView: UIView!
    

    var itIsShown: Bool = false
    func showCard(_ show: Bool, animated: Bool, completion: @escaping ((Bool) -> Void)) {
        frontView.isHidden = false
        backView.isHidden = false
        itIsShown = show 
           if animated {
               if show {
                   UIView.transition(
                       from: backView,
                       to: frontView,
                       duration: 0.5,
                       options: [.transitionFlipFromRight, .showHideTransitionViews],
                       completion: completion)
               } else {
                   UIView.transition(
                       from: frontView,
                       to: backView,
                       duration: 0.5,
                       options: [.transitionFlipFromRight, .showHideTransitionViews],
                       completion: completion )
               }
           } else {
               if show {
                   bringSubviewToFront(frontView)
                   backView.isHidden = true
               } else {
                   bringSubviewToFront(backView)
                   frontView.isHidden = true
               }
           }
       }
}
