//
//  ViewController.swift
//  ReplayExample
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
    @IBOutlet private weak var callModeLabel: UILabel!
    
    // MARK: Properties
    
    private let modes = ["None", "Record", "Replay"]
    private var replayMode: ReplayMode = .none
    
    // MARK: Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: privates
    
    private func setupView() {
        clearTextView()
        loadingIndicator.isHidden = true
        callModeLabel.text = "None"
    }
    
    private func clearTextView() {
        textView.text = ""
    }
    
    private func displayActionSheet(handler: ((Int) -> Void)?) {
        let alertViewController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        for (index, item) in modes.enumerated() {
            let action = UIAlertAction(title: item, style: .default) { _ in
                handler?(index)
            }
            alertViewController.addAction(action)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        })
        alertViewController.addAction(cancel)
        
        // Handle iPad display
        if let popoverController = alertViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(alertViewController, animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func onButtonTapped(_ sender: Any) {
        clearTextView()
        loadingIndicator.isHidden = false
        
        DataManager.shared.getProfile(replayMode: replayMode) { [weak self] response in
            self?.textView.text = response
            self?.loadingIndicator.isHidden = true
        }
    }
    
    @IBAction private func onSelectModeTapped(_ sender: Any) {
        displayActionSheet(handler: { [weak self] index in
            switch index {
            case 0:
                self?.replayMode = .none
                self?.callModeLabel.text = "Call mode : Normal"
            case 1:
                self?.replayMode = .record
                self?.callModeLabel.text = "Call mode : Record"
            case 2:
                self?.replayMode = .replay
                self?.callModeLabel.text = "Call mode : Replay"
            default:
                return
            }
        })
    }
}
