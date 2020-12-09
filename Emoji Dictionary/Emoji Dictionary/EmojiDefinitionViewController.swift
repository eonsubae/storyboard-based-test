//
//  EmojiDefinitionViewController.swift
//  Emoji Dictionary
//
//  Created by ma-esb on 2020/12/09.
//

import UIKit

class EmojiDefinitionViewController: UIViewController {

    @IBOutlet weak var emojiDefinitionLabel: UILabel!
    @IBOutlet weak var blownUpEmojiLabel: UILabel!
    
    var emoji = "💺"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blownUpEmojiLabel.text = emoji
    }
    
}
