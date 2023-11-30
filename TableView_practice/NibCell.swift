//
//  NibCell.swift
//  TableView_practice
//
//  Created by dhui on 11/28/23.
//

import Foundation
import UIKit



class NibCell: UITableViewCell {
    
    var onDeleteBtnClickedClosure: (() -> Void)? = nil
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    var indexPath: IndexPath? = nil
    
    var cellData: String? = nil
    
//    weak var delegate: NibCellDelegate? = nil
    // retain
    //
    weak var viewController: NibCellDelegate? = nil
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#fileID, #function, #line, "- cellData: \(cellData)")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#fileID, #function, #line, "- ")
//        mySwitch.isOn = false
        mySwitch.addTarget(self, action: #selector(onSwitchChanged(sender:)), for: .valueChanged)
    }
    
    func configureCell(isSelected: Bool) {
        self.mySwitch.setOn(isSelected, animated: false)
    }
    
    @objc fileprivate func onSwitchChanged(sender: UISwitch) {
        print(#fileID, #function, #line, "- switch's value changed!")
        
        if let cellData = cellData {
            viewController?.nibCellSwitchChangedEvent(id: cellData, isOn: sender.isOn)
        }
        
    }
    
    @IBAction func onDeleteBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- sender: \(sender.tag)")
        if let cellData = cellData {
            let test = viewController
            
//            viewController?.
            viewController?.onDeleteItemClicked(id: cellData)
        }
    }
    
}


