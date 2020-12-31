//
//  LoginController.swift
//  UberTutorial
//
//  Created by ma-esb on 2020/12/31.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Uber"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: 0).isActive = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
