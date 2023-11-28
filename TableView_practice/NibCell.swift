//
//  NibCell.swift
//  TableView_practice
//
//  Created by dhui on 11/28/23.
//

import Foundation
import UIKit

class NibCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#fileID, #function, #line, "- ")
    }
    
}
