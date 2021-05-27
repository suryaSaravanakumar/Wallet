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
    @IBOutlet weak var addHolderView: UIView!
    
    //MARK: Property Declaration
    static var CurrentBalanceCell_ID = "CurrentBalanceTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        addHolderView.layer.cornerRadius = 25
        addHolderView.layer.masksToBounds = false
        
        addHolderView.layer.shadowColor =  UIColor.label.cgColor
        addHolderView.layer.shadowOffset = CGSize(width: 0, height: 2)
        addHolderView.layer.shadowRadius = 4
        addHolderView.layer.shadowOpacity = 0.2
        
        
        
    }

    
    
    
}
