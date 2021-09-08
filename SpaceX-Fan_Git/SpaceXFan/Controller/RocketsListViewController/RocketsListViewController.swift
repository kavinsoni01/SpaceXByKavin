//
//  RocketsListViewController.swift
//  SpaceXFan
//
//  Created by Kavin Soni on 02/09/21.
//

import UIKit

class RocketsListViewController: BaseViewController {
     
    private var viewModel:RocketsListViewModel!
    var refreshControl = UIRefreshControl()

    
    @IBOutlet weak var tblRocketList: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup UI 
        self.setupUI()
        self.viewModel = RocketsListViewModel(output: self)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.fetchRockets()
    }
    
    //MARK: Setup UI methods
    
    func setupUI() -> Void {
        
        self.setTitleNavigationController(text: "Rocket List")
        self.setRightBarButton(img: UIImage.init(named: "Logout"))
        self.tblRocketList.delegate = self
        self.tblRocketList.dataSource = self
        self.tblRocketList.register(UINib.init(nibName: "RocketListingTableCell", bundle: nil), forCellReuseIdentifier: "RocketListingTableCell")
        self.tblRocketList.separatorStyle = .none
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tblRocketList.addSubview(refreshControl)
    }
    
    //MARK: Right Navigation bar button Action
    
    override func RightBarBtnAction() {
        let alert = UIAlertController(title: "SpaceX fan", message: "Are you sure, you want to logout?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))

        alert.addAction(UIAlertAction(title: "Log out", style: UIAlertAction.Style.default, handler: { (logout) in
            
            UserDefaults.standard.removeObject(forKey: "isLogin")
            appDelegate.navigateToLoginScreen()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    
    //MARK: Refresh tableview
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        self.viewModel.fetchRockets()
    }
    
    
    @objc func btnFavouriteClicked(_ sender:UIButton) -> Void {
         let index = sender.tag
         let objRocket =  self.viewModel.rockets[index]
        self.viewModel.toggleFavouriteStatus(rocketId: objRocket.id)
        self.viewModel.fetchRockets()
     }
}

extension RocketsListViewController: RocketListViewModelOutputProtocol {
    func didReceive(rocketsInfo: [RocketInfo]) {
        OperationQueue.main.addOperation {
            self.refreshControl.endRefreshing()
            self.tblRocketList.reloadData()
        }
    }
    
    func didFailToReceiveRocketsInfo(withError error: Error) {
        print(error)
    }
}


extension RocketsListViewController:UITableViewDataSource{
    //MARK: Tableview Datasource
    //set how many cell in section

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.viewModel.rockets.count > 0{
            tableView.backgroundView = nil
            return self.viewModel.rockets.count
        } else {
            // Display a message when the table is empty
            self.createEmptyTableView(tblView: tableView)
            return self.viewModel.rockets.count
        }
    }
    //set table cell UI

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RocketListingTableCell = tableView.dequeueReusableCell(withIdentifier: "RocketListingTableCell") as! RocketListingTableCell
        cell.selectionStyle = .none
        cell.btnFav.tag = indexPath.row
        cell.btnFav.addTarget(self, action: #selector(self.btnFavouriteClicked(_:)), for: .touchUpInside)
        
        //setup table cell
        if self.viewModel.rockets.count > indexPath.row {
            cell.setupCell(objModel: self.viewModel.rockets[indexPath.row])
        }
        
        return cell
    }
}

extension RocketsListViewController:UITableViewDelegate{
    //MARK: Tableview Delegate Method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView:DetailsViewController = UIStoryboard(storyboard: .Main).instantiateViewController()
           detailsView.hidesBottomBarWhenPushed = true
        detailsView.rocketModel = self.viewModel.rockets[indexPath.row]
           self.navigationController?.pushViewController(detailsView, animated: true)
    }
//
}
