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
            tableView.register(InspectionAudioTableViewCell.nib, forCellReuseIdentifier: InspectionAudioTableViewCell.identifier)
            
        }
    }
    
    var jobDetails: BookingHistoryModel?
    
    var inspections: [InspectionModel]?
    var images = [UIImage]()
    var audioPath: String?
    var audioURL: URL?

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
    
    @IBAction func submitDataButtonHandler(_ sender: UIButton) { // Mark as collected
        var params = [String:String]()
        params["job_id"] = self.jobDetails?.id?.description
        params["rider_note"] = "some rider note"
        
        var inspectionItems: String = ""
        self.inspections?.forEach({ inspectionModel in
            if inspectionModel.isSelected {
                if inspectionItems.count > 0 {
                    inspectionItems += "," + (inspectionModel.id?.description ?? "")
                } else {
                    inspectionItems += inspectionModel.id?.description ?? ""
                }
            }
        })
        params["inspection_items"] = inspectionItems
        print("Parameters - ", params)
        
        var imagesToUpload: [UIImage]? = nil
        if self.images.count > 0 {
            imagesToUpload = self.images
        }
        APIClient.uploadInspectData(api: .updateInspectionDetails, parameters: params, images: imagesToUpload, audioURL: self.audioURL, method: .post, view: self.view) { (dictionary) in
            print("==============================")
            print(dictionary)
            print("==============================")
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
            cell.selectImageCompletion = { [weak self] in
                self?.openActionSheet()
            }
            cell.set(data: self.images)
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: InspectionTableViewCell.identifier, for: indexPath) as! InspectionTableViewCell
            if let inspection = self.inspections?[indexPath.row] {
                cell.set(data: inspection)
            }
            return cell
            
        case 2:
                        
            let cell = tableView.dequeueReusableCell(withIdentifier: InspectionAudioTableViewCell.identifier, for: indexPath) as! InspectionAudioTableViewCell
            
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
        switch indexPath.section {
        case 0:
            print("open photo")
            
        case 1:
            self.inspections?[indexPath.row].isSelected.toggle()
            self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
            
        case 2:
            print("record audio")
            PermissionManager.shared.requestAccess(vc: self, .microphoneUsage) { [weak self] isAllowed in
                guard let self = self else { return }
                if isAllowed {
                    let audioPopup = AudioPlayerPopupViewController()
                    audioPopup.delegate = self
                    self.present(audioPopup, animated: true, completion: nil)
                }
            }
            
        default:
            break
        }
    }
    
}

extension InspectDetailsViewController: AudioPlayerPopupViewControllerDelegate {
    func didRecordAudio(path: String?, url: URL?) {
        print("received audio url in Controlleer to use - ", url)
        self.audioPath = path
        self.audioURL = url
    }
}

extension InspectDetailsViewController: UIImagePickerControllerDelegate {
    
    func openActionSheet() {
        let alert = UIAlertController(title: "Select Image", message: "Select Image", preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [weak self] action in
            alert.dismiss(animated: true, completion: nil)
            guard let self = self else { return }
            PermissionManager.shared.requestAccess(vc: self, .photoLibraryUsage) { isAllowed in
                if isAllowed {
                    self.openImagePicker(sourceType: .photoLibrary)
                }
            }
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] action in
            alert.dismiss(animated: true, completion: nil)
            guard let self = self else { return }
            PermissionManager.shared.requestAccess(vc: self, .cameraUsage) { isAllowed in
                if isAllowed {
                    self.openImagePicker(sourceType: .camera)
                }
            }
        }
        
        alert.addAction(galleryAction)
        alert.addAction(cameraAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in alert.dismiss(animated: true, completion: nil) }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.allowsEditing = true
            picker.delegate = self
            picker.modalPresentationStyle = .fullScreen
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            self.images.append(originalImage)
        } else if let editedImage = info[.editedImage] as? UIImage {
            self.images.append(editedImage)
        }
        self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        picker.dismiss(animated: true, completion: nil)
    }
    
}
