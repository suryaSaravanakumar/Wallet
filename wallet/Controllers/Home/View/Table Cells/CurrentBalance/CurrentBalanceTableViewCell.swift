//
//  CurrentBalanceTableViewCell.swift
//  wallet
//
//  Created by Surya on 16/05/21.
//

import UIKit

class CurrentBalanceTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet Declaration
    @IBOutlet weak var currentBalance: UILabel!
    
    //MARK: Property Declaration
    static var CurrentBalanceCell_ID = "CurrentBalanceTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    
    
    
}
