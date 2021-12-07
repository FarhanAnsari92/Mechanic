//
//  InspectDetailsViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 06/12/2021.
//

import UIKit

class InspectDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 50
            
            tableView.register(InspectionTableViewCell.nib, forCellReuseIdentifier: InspectionTableViewCell.identifier)
            tableView.register(InspectionImagesTableViewCell.nib, forCellReuseIdentifier: InspectionImagesTableViewCell.identifier)
            tableView.register(InspectionCommentTableViewCell.nib, forCellReuseIdentifier: InspectionCommentTableViewCell.identifier)
            
            
        }
    }
    
    var inspections: [InspectionModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Inspect Details"
        self.setupBackButton(color: .white)
        self.getInspectionList()
    }
    
    func getInspectionList() {
        APIClient.callApi(api: .inspectionTitles, method: .get, view: self.view) { data in
            if let dictionary = data {
                if let object = ObjectMapperManager<InspectionResponseModel>().map(dictionary: dictionary) {
                    self.inspections = object.data
                    self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
                } else {
                    print("Unable to parse")
                }
            } else {
                print("Unable to parse")
            }
        }
    }

}

extension InspectDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = TitleHeaderView.loadNib
        
        switch section {
        case 0:
            headerView.lblTitle.text = "Add Photo"
            
        case 1:
            headerView.lblTitle.text = "Inspection List"
            
        case 2:
            headerView.lblTitle.text = "Record Audio Message"
        default:
            headerView.lblTitle.text = "Add Comments"
        }
        
        return headerView
        
//        let vu = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 35))
//        vu.backgroundColor = .white
//        let lbl = UILabel(frame: CGRect(x: 20, y: 10, width: self.view.frame.width / 2, height: 25))
//        switch section {
//        case 0:
//            lbl.text = "Add Photo"
//
//        case 1:
//            lbl.text = "Inspection List"
//
//        case 2:
//            lbl.text = "Record Audio Message"
//        default:
//            lbl.text = "Add Comments"
//        }
//
//        lbl.font = UIFont.Poppins(.semiBold, size: 18)
//        vu.addSubview(lbl)
//        return vu
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 2, 3:
            return 1
        default:
            return self.inspections?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InspectionImagesTableViewCell.identifier, for: indexPath) as! InspectionImagesTableViewCell
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: InspectionTableViewCell.identifier, for: indexPath) as! InspectionTableViewCell
            if let inspection = self.inspections?[indexPath.row] {
                cell.set(data: inspection)
            }
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: InspectionCommentTableViewCell.identifier, for: indexPath) as! InspectionCommentTableViewCell
            
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.inspections?[indexPath.row].isSelected.toggle()
        self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
    }
    
}
