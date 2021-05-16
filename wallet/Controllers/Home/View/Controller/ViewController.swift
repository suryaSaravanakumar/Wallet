//
//  ViewController.swift
//  wallet
//
//  Created by Surya on 16/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- Property  Declaration
    //Step - 1
    private var dataSource: UITableViewDiffableDataSource<String,sendMoney>!
    private var sendMoneyList = [sendMoney(userName: "Surya"),
                                 sendMoney(userName: "Ram"),
                                 sendMoney(userName: "Tamil"),
                                 sendMoney(userName: "Miruthu")]
 
    //MARK:- IBOutlet Declaration
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       initalSetup()
    }

    override func viewDidAppear(_ animated: Bool) {
        applySnapShot()
    }
    
    //MARK:- Custom Methods
    private func initalSetup(){
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: CurrentBalanceTableViewCell.CurrentBalanceCell_ID, bundle: nil), forCellReuseIdentifier: CurrentBalanceTableViewCell.CurrentBalanceCell_ID)
        configuareTableViewDataSource()
    }
    
    //Step - 2
    private func configuareTableViewDataSource(){
        dataSource = UITableViewDiffableDataSource<String,sendMoney>(tableView: tableView, cellProvider: { (tableView, indexpath, sendMoney) -> CurrentBalanceTableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentBalanceTableViewCell.CurrentBalanceCell_ID, for: indexpath) as? CurrentBalanceTableViewCell
            cell?.userName.text = sendMoney.userName
            return cell
        })
    }
    
    //Step - 3
    private func applySnapShot(){
        var snapShot = NSDiffableDataSourceSnapshot<String,sendMoney>()
        
        snapShot.appendSections(["Friends"])
        snapShot.appendItems(sendMoneyList)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
}

extension HomeViewController: UITableViewDelegate{
    
}

