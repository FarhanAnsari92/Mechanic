//
//  SelectWorkshopViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/10/21.
//

import UIKit

class SelectWorkshopViewController: HomeBaseViewController {
    
    @IBOutlet weak var btn_done: UIButton!
    @IBOutlet weak var tableview: UITableView!{
        
        didSet{
            tableview.delegate = self
            tableview.dataSource = self
            tableview.register(SelectWorkshopTableViewCell.nib, forCellReuseIdentifier: SelectWorkshopTableViewCell.identifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Select Workshop"
        setupBackButton(color: .white)
    }
    
    @IBAction func btn_done(_ sender: UIButton) {
                 
                 let sb = UIStoryboard(storyboard: .vehicle)
                 let vc = sb.instantiateViewController(withIdentifier: ConfirmBookingViewController.storyboardIdentifier)
                 self.navigationController?.pushViewController(vc, animated: true)
             }
    

}

extension SelectWorkshopViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectWorkshopTableViewCell.identifier, for: indexPath) as!
            SelectWorkshopTableViewCell
            if indexPath.row == 1 {
                       cell.isSelected = false
                
                   } else {
                       cell.isSelected = true
                   }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vu = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 35))
        vu.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.width / 2, height: 35))
        lbl.text = "Near By"
        lbl.font = UIFont.Poppins(.semiBold, size: 18)
        vu.addSubview(lbl)
        return vu
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
}
