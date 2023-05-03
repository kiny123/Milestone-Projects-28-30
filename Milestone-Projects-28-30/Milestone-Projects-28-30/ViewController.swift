//
//  ViewController.swift
//  Milestone-Projects-28-30
//
//  Created by nikita on 01.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Game(numberOfPairsOfCards: (buttonCollection.count + 1) / 2)
    
    @IBOutlet var buttonCollection: [UIButton]!
    var emojiCollection = ["🦊", "🐨", "🐯", "🐵", "🐷", "🐻‍❄️", "🐶", "🐹"]
    var emojiDictionary = [Int: String]()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        title = "Pairs"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(rules))
    }
    
    @objc func rules() {
        let ac = UIAlertController(title: "Rules", message: "You need to pair one of two cards and others", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
            
        }
    }
    
    func flipButton(emoji: String, button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
    
    func win() {
        let ac = UIAlertController(title: "Win", message: "You win!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Nice", style: .cancel))
        present(ac, animated: true)
        
        
        
    }
    
    
    
}

