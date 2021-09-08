//
//  FavouriteListViewController.swift
//  SpaceX Fan
//
//  Created by Kavin Soni on 25/06/21.
//

import UIKit
import LocalAuthentication
import CoreData

@available(iOS 13.0, *)
class FavouriteListViewController: BaseViewController {
    
    //VARIABLE
    var context = LAContext()
    private var viewModel:RocketsListViewModel!

    //OUTLETS
    @IBOutlet weak var tblFavouriteList: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        //Login With Face ID
        loginAuthWithFaceId()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup UI
        self.setupUI()

        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        self.viewModel = RocketsListViewModel(output: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.fetchFavouriteRockets()
    }
    

//MARK: Setup UI 
    func setupUI() -> Void {
        
        self.setTitleNavigationController(text: "Favourite List")
        self.tblFavouriteList.delegate = self
        self.tblFavouriteList.dataSource = self
        self.tblFavouriteList.register(UINib.init(nibName: "RocketListingTableCell", bundle: nil), forCellReuseIdentifier: "RocketListingTableCell")
        self.tblFavouriteList.separatorStyle = .none
    }
   
    
    //MARK: Login auth with faceId
    func loginAuthWithFaceId() -> Void {

                context = LAContext()
                context.localizedCancelTitle = "Cancel"

                // First check if we have the needed hardware support.
                var error: NSError?
                if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {

                    let reason = "Log in to your account"
                    context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in

                        if success {


                        } else {
                            print(error?.localizedDescription ?? "Failed to authenticate")

                            DispatchQueue.main.async {
                                if let tabBarController = self.navigationController?.tabBarController{
                                       tabBarController.selectedIndex = 0
                                   }
                            }
                        }
                    }
                } else {
                    print(error?.localizedDescription ?? "Can't evaluate policy")
                }
    }
    
    
    
    //MARK: Favourite Button Clicked
    
   @objc func btnFavouriteClicked(_ sender:UIButton) -> Void {
        let index = sender.tag
        let objRocket =  self.viewModel.rockets[index]
        self.viewModel.toggleFavouriteStatus(rocketId: objRocket.id)
    self.viewModel.fetchFavouriteRockets()
    }
}



extension FavouriteListViewController: RocketListViewModelOutputProtocol {
    func didReceive(rocketsInfo: [RocketInfo]) {
        print(rocketsInfo)
        DispatchQueue.main.async {
            self.tblFavouriteList.reloadData()
        }
    }
    
    func didFailToReceiveRocketsInfo(withError error: Error) {
        print(error)
    }
}


extension FavouriteListViewController:UITableViewDataSource{
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

extension FavouriteListViewController:UITableViewDelegate{
    //MARK: Tableview Delegate Method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView:DetailsViewController = UIStoryboard(storyboard: .Main).instantiateViewController()
           detailsView.hidesBottomBarWhenPushed = true
        detailsView.rocketModel = self.viewModel.rockets[indexPath.row]
           self.navigationController?.pushViewController(detailsView, animated: true)
    }
//
}
