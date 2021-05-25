//
//  MySpendsViewController.swift
//  wallet
//
//  Created by Surya on 23/05/21.
//

import UIKit

class MySpendsViewController: UIViewController {

    //MARK: - IBOutlet Declaration
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Property Declaration
    static let storyBoardID = "MySpendsViewController"
    private var collectionViewdataSource: UICollectionViewDiffableDataSource<String,MySpend>!
    var mySpendDetails: [MySpend]?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuarecollectionViewDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        applyCollectionViewSnapshot()
    }

    //MARK: - custom Methods
    private func initalSetup(){
        self.collectionView.delegate = self
        collectionView.register(UINib(nibName: AddFriendCollectionViewCell.AddFriendCollectionViewCell_ID, bundle: nil), forCellWithReuseIdentifier: AddFriendCollectionViewCell.AddFriendCollectionViewCell_ID)
        configuarecollectionViewDataSource()
    }
    
    func configuarecollectionViewDataSource(){
        collectionViewdataSource = UICollectionViewDiffableDataSource<String,MySpend>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, mySpend) -> UICollectionViewCell? in
            switch indexpath.row {
            case 0:
                let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: AddFriendCollectionViewCell.AddFriendCollectionViewCell_ID, for: indexpath) as? AddFriendCollectionViewCell
                return collectionView
            default:
                let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: AddFriendCollectionViewCell.AddFriendCollectionViewCell_ID, for: indexpath) as? AddFriendCollectionViewCell
                return collectionView
            }
           
        })
    }
    
    func applyCollectionViewSnapshot(){
        var snapShot = NSDiffableDataSourceSnapshot<String,MySpend>()
        snapShot.appendSections(["0"])
        snapShot.appendItems(mySpendDetails!, toSection: "0")
        collectionViewdataSource.apply(snapShot, animatingDifferences: true)
            
    }
}

extension MySpendsViewController : UICollectionViewDelegate{
    
}
