//
//  ViewController.swift
//  EkhoTest
//
//  Created by Charles Legrand on 19/02/2020.
//  Copyright © 2020 Charles Legrand. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    // MARK: IBOutlet
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: privates
    
    private func setupView() {
        clearTextView()
        loadingIndicator.isHidden = true
    }
    
    private func clearTextView() {
        textView.text = ""
    }
    
    // MARK: Actions
    
    @IBAction func onButtonTapped(_ sender: Any) {
        clearTextView()
        loadingIndicator.isHidden = false
        
        DataManager.shared.getProfile() { [weak self] response in
            self?.textView.text = response
            self?.loadingIndicator.isHidden = true
        }
    }
}
