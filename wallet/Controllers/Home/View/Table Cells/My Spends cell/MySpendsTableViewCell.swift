//
//  MySpendsTableViewCell.swift
//  wallet
//
//  Created by Surya on 29/05/21.
//

import UIKit

class MySpendsTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var spendTitle: UILabel!
    @IBOutlet weak var spendAmount: UILabel!
    @IBOutlet weak var spendDateAndTime: UILabel!
    @IBOutlet weak var spendIcon: UIImageView!
    @IBOutlet weak var spendIconHolderView: UIView!
    
    //MARK: - View Lifecycle
    static let MySpendsTableViewCell_ID = "MySpendsTableViewCell"

    //MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        spendIconHolderView.layer.cornerRadius = 20
        spendIconHolderView.layer.masksToBounds = false
        
        spendIconHolderView.layer.shadowColor = UIColor.label.cgColor
        spendIconHolderView.layer.shadowRadius = 4
        spendIconHolderView.layer.shadowOpacity = 0.2
        spendIconHolderView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
    }

    //MARK: - Cuatom Methods
    
}
