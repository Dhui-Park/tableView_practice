//
//  DeletePopUp.swift
//  TableView_practice
//
//  Created by dhui on 11/29/23.
//

import Foundation
import UIKit

class DeletePopUp: UIViewController {
    
   
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        contentView.layer.cornerRadius = 8
        
    }
    
    
    @IBAction func onCancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onSubmitBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
    }
    
}
