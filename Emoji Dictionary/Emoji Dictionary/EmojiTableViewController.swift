//
//  EmojiTableViewController.swift
//  Emoji Dictionary
//
//  Created by ma-esb on 2020/12/09.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    let emojis = ["🚗", "⛪️", "🙃", "🥖", "🚑"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // How many rows?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }

    // What goes in each row?
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.text = emojis[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedEmoji = emojis[indexPath.row]
        performSegue(withIdentifier: "Definition", sender: selectedEmoji)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let definitionVC = segue.destination as! EmojiDefinitionViewController
        let selectedEmoji = sender as! String
        definitionVC.emoji = selectedEmoji
    }
}
