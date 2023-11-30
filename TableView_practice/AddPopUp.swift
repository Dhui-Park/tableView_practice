//
//  AddPopUp.swift
//  TableView_practice
//
//  Created by dhui on 11/29/23.
//

import Foundation
import UIKit

class AddPopUp: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var todoTextField: UITextField!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    var newTodo: String? = nil
    
    weak var delegate: AddPopUpDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        self.todoTextField.delegate = self
        contentView.layer.cornerRadius = 8
        submitBtn.addTarget(self, action: #selector(onSubmitBtnClicked(sender:)), for: .touchUpInside)
    }
    
    @objc fileprivate func onSubmitBtnClicked(sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        newTodo = self.todoTextField.text
        delegate?.onSubmitBtnClicked(newTodo: newTodo ?? "")
        self.dismiss(animated: true)
    }
    
    
    @IBAction func onCancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
}



extension AddPopUp: UITextFieldDelegate {
    
}

