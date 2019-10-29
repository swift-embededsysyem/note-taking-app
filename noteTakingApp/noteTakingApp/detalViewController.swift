//
//  detalViewController.swift
//  noteTakingApp
//
//  Created by akbar  Rizvi on 1/20/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//

import UIKit

class detalViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var text:String = ""
    var masterView:ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = text
    }
    
    func setText(t:String) {
        text = t
        if isViewLoaded {
            textView.text = t
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = textView.text
        textView.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    

}
