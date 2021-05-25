//
//  MySpendsTableViewCell.swift
//  wallet
//
//  Created by Surya on 21/05/21.
//

import UIKit

class MySpendsTableViewCell: UITableViewCell {

    @IBOutlet weak var addImageHolderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Property Declaration
    static var MySpendsTableViewCell_ID = "MySpendsTableViewCell"
    private var collectionViewdataSource: UICollectionViewDiffableDataSource<String,MySpend>!
    var mySpendDetails: [MySpend]?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        addImageHolderView.layer.cornerRadius = 25
        addImageHolderView.layer.masksToBounds = false
        
        addImageHolderView.layer.shadowColor = UIColor.label.cgColor
        addImageHolderView.layer.shadowOffset = CGSize(width: 0, height: 2)
        addImageHolderView.layer.shadowRadius = 4
        addImageHolderView.layer.shadowOpacity = 0.2
    }
    
    //MARK: Custom Methods
    func collectionViewSetup(){
        
        collectionView.delegate = self
        //Register cell
        collectionView.register(UINib(nibName: FriendsListCollectionViewCell.FriendsListCollectionViewCell_ID, bundle: nil), forCellWithReuseIdentifier: FriendsListCollectionViewCell.FriendsListCollectionViewCell_ID)
        
        //Setup data source
        self.configureCollectionViewDataSource(collectionView: collectionView)
        self.applyCollectionViewSnapshot()
    }
    
    func configureCollectionViewDataSource(collectionView: UICollectionView){
        collectionViewdataSource = UICollectionViewDiffableDataSource<String,MySpend>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, mySpend) -> UICollectionViewCell? in
            let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsListCollectionViewCell.FriendsListCollectionViewCell_ID, for: indexpath) as? FriendsListCollectionViewCell
            return collectionView
           
        })
    }
    
    func applyCollectionViewSnapshot(){
        var snapShot = NSDiffableDataSourceSnapshot<String,MySpend>()
        snapShot.appendSections(["0"])
        snapShot.appendItems(mySpendDetails!, toSection: "0")
        collectionViewdataSource.apply(snapShot, animatingDifferences: true)
            
    }
    
}

extension MySpendsTableViewCell: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
