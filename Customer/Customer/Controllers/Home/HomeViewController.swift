//
//  HomeViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 26/09/2021.
//

import UIKit
import SideMenu
import LGSideMenuController

class HomeViewController: SideMenuBaseController {
    
    @IBOutlet weak var btnFixMyVehicle: UIButton!
    @IBOutlet weak var lblAutoParts: InteractiveLinkLabel!
    @IBOutlet weak var txtSearch: UITextField!

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
            
            collectionView.register(AutoPartsAndAccessoriesCollectionViewCell.nib, forCellWithReuseIdentifier: AutoPartsAndAccessoriesCollectionViewCell.identifier)
            collectionView.register(AccessoriesCollectionViewCell.nib, forCellWithReuseIdentifier: AccessoriesCollectionViewCell.identifier)
            collectionView.register(BannerViewCollectionViewCell.nib, forCellWithReuseIdentifier: BannerViewCollectionViewCell.identifier)
            collectionView.register(TopPickCollectionViewCell.nib, forCellWithReuseIdentifier: TopPickCollectionViewCell.identifier)
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    let imageCacheManager: ImageCacheManager = ImageCacheManager()
    var products: [ProductModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupLeftBarButtons()
        setupRightBarButtons()
        setupAutoPartsLabel()
        getProducts()
        
        txtSearch.delegate = self
        
        if let glController = AppDelegate.instance.window?.rootViewController as? LGSideMenuController {
            if let leftMenuControllerr = glController.leftViewController as? LeftMenuViewController {
                leftMenuControllerr.leftMenuDelegate = self
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshProducts), name: .updateProducts, object: nil)
    }
    
    @objc func refreshProducts() {
        getProducts()
    }
    
    func getProducts(text: String = "") {
        var parameters = [String:String]()
        if text.count > 0 {
            parameters["keyword"] = text
        }
        APIClient.callApi(api: .products, parameters: parameters, method: .get, view: self.view) { [weak self] data in
            guard let self = self else { return }
            if let dictionary = data {
                if let productResponseModel = ObjectMapperManager<ProductResponseModel>().map(dictionary: dictionary) {
                    
                    if let products = productResponseModel.data?.products, products.count > 0 {
                        self.products = products
                        self.collectionView.reloadData()
                    } else {
                        Helper.showMessage(text: "No Products Found.")
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupFixMyVehicleButton()
    }
    
}

// MARK: View Setup

extension HomeViewController {
    
    func setupTitle() {
        let imageName = "ic_motor_service"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func setupLeftBarButtons() {
        let leftMenuBtn = UIBarButtonItem(image: UIImage(named: "ic_side_menu"), style: .plain, target: self, action: #selector(self.openLeftMenu))
        leftMenuBtn.tintColor = .black

        let leftChatBtn = UIBarButtonItem(image: UIImage(named: "ic_chat"), style: .plain, target: self, action: #selector(self.openChat))
        leftChatBtn.tintColor = .black
        navigationItem.leftBarButtonItems = [leftMenuBtn, leftChatBtn]
    }
    
    func setupRightBarButtons() {
        let rightNotificationBtn = UIBarButtonItem(image: UIImage(named: "ic_bell"), style: .plain, target: self, action: #selector(self.openNotifications))
        rightNotificationBtn.tintColor = .black

        let rightCartBtn = UIBarButtonItem(image: UIImage(named: "ic_cart"), style: .plain, target: self, action: #selector(self.openCart))
        rightCartBtn.tintColor = .black
        navigationItem.rightBarButtonItems = [rightCartBtn, rightNotificationBtn]
    }
    
    func setupFixMyVehicleButton() {
        let width: CGFloat = view.frame.width - 40
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: 55))
        let fixMyVehicleView = FixMyVehicleView().loadViewFromNib()
        fixMyVehicleView.isUserInteractionEnabled = false
        fixMyVehicleView.frame = frame
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 5.0, y: 0.0)
        gradient.colors = [
            UIColor.Theme.green.cgColor,
            UIColor.fill(red: 93, green: 197, blue: 123).cgColor
        ]
        gradient.locations = [0.0, 0.1]
        gradient.frame = frame
        fixMyVehicleView.layer.insertSublayer(gradient, at: 0)
        fixMyVehicleView.layer.masksToBounds = true
        fixMyVehicleView.layer.cornerRadius = 10
        btnFixMyVehicle.addSubview(fixMyVehicleView)
    }
    
    private func setupAutoPartsLabel() {
        
        let plainText = "1000+ Auto Parts & "
        let tappableText = "Accessories"
        
        let plainAttributedString = NSMutableAttributedString(string: plainText, attributes: [.foregroundColor: UIColor(hexString: "1F2937"), .font: UIFont.Poppins(.semiBold, size: 18)])
        
        let attributedLinkString = NSMutableAttributedString(
            string: tappableText,
            attributes:[
                .foregroundColor: UIColor(hexString: "1F2937"),
                .font: UIFont.Poppins(.regular, size: 18)
            ]
        )
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        lblAutoParts.isUserInteractionEnabled = false
        lblAutoParts.attributedText = fullAttributedString

    }
    
}

// MARK: Actions

extension HomeViewController {
    
    @objc func openLeftMenu() {
        if let glController = AppDelegate.instance.window?.rootViewController as? LGSideMenuController {
            if let leftMenuControllerr = glController.leftViewController as? LeftMenuViewController {
                leftMenuControllerr.leftMenuDelegate = self
            }
            glController.showLeftView(animated: true, completion: nil)
        }
    }
    
    @objc func openChat() {
        let sb = UIStoryboard(storyboard: .chat)
        let vc = sb.instantiateViewController(withIdentifier: ChatViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openNotifications() {
        let sb = UIStoryboard(storyboard: .notification)
        let vc = sb.instantiateViewController(withIdentifier: NotificationViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openCart() {
        guard ProductCart.shared.hasItem else {
            Helper.showMessage(text: "Your cart is empty.\nAdd items to cart first.")
            return
        }
        let sb = UIStoryboard(storyboard: .basket)
        let vc = sb.instantiateViewController(withIdentifier: BasketListViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filterButtonHandler(_ sender: UIButton) {
        print("filterButtonHandler")
    }
    
    @IBAction func searchGoButtonHandler(_ sender: UIButton) {
        guard (self.txtSearch.text ?? "").count > 0 else {
            return
        }
        self.view.endEditing(true)
        getProducts(text: self.txtSearch.text ?? "")
    }
    
    @IBAction func fixMyVehicleButtonHandler(_ sender: UIButton) {
        
        let sb = UIStoryboard(storyboard: .vehicle)
        let vc = sb.instantiateViewController(withIdentifier: MyVehicleViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            return updatedText.count <= 20
        }
        return false
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! SectionHeader
        sectionHeader.label.text = indexPath.section == 0 ? "Categories" : "Products"
        sectionHeader.configure()
        return sectionHeader
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40) // section == 0 ? 0 : 40
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { // || section == 2 {
            return 1
        }
        return self.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AutoPartsAndAccessoriesCollectionViewCell.identifier, for: indexPath) as! AutoPartsAndAccessoriesCollectionViewCell
            cell.accessoriesCompletion = { [weak self] in
                let sb = UIStoryboard(storyboard: .accessories)
                let vc = sb.instantiateViewController(withIdentifier: AccessoriesViewController.storyboardIdentifier)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        } /* else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerViewCollectionViewCell.identifier, for: indexPath)
            return cell
        } */ else if indexPath.section == 1 {
            // 2 liner item name will not work in iPhone 5s sized devices.
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccessoriesCollectionViewCell.identifier, for: indexPath) as! AccessoriesCollectionViewCell
            if let product = self.products?[indexPath.row] {
                cell.set(data: product, imageCacheManager: imageCacheManager)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopPickCollectionViewCell.identifier, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let sb = UIStoryboard(storyboard: .accessories)
            let vc = sb.instantiateViewController(withIdentifier: AccessoriesDetailsViewController.storyboardIdentifier) as! AccessoriesDetailsViewController
            if let product = self.products?[indexPath.row] {
                vc.product = product
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let itemsPerRow:CGFloat = 1
            let padding:CGFloat = 20
            let itemWidth = (collectionView.bounds.width / itemsPerRow) - padding
            return CGSize(width: itemWidth, height: 60)
        } /* else if indexPath.section == 1 {
            let itemWidth = collectionView.bounds.width
            return CGSize(width: itemWidth, height: itemWidth * 0.4)
        } */ else if indexPath.section == 1 {
            
            let numberOfItemsPerRow: CGFloat = 2
            let spacing: CGFloat = 20
            let totalSpace: CGFloat = (spacing * numberOfItemsPerRow) + 5
            let totalWidth = collectionView.frame.width - totalSpace
            let itemWidth = totalWidth / 2
            
            return CGSize(width: itemWidth, height: itemWidth * 1.3)
            
        } else {
            let itemWidth = collectionView.bounds.width
            return CGSize(width: itemWidth, height: (itemWidth / 2) * 1.3)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}

extension HomeViewController: LeftMenuContainerViewControllerDelegate {
    
    func didSelect(_ title: LeftMenuType) {
        switch title {
        case .home:
            print(title.rawValue)
        case .myProfile:
            let sb = UIStoryboard(storyboard: .profile)
            let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        case .address:
            let sb = UIStoryboard(storyboard: .address)            
            let vc = sb.instantiateViewController(withIdentifier: AddressListViewController.storyboardIdentifier)
            
            self.navigationController?.pushViewController(vc, animated: true)
        case .track:
            let sb = UIStoryboard(storyboard: .tracking)
            let vc = sb.instantiateViewController(withIdentifier: BookingHistoryViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        case .orderHistory:
            
            let sb = UIStoryboard(storyboard: .order)
            let vc = sb.instantiateViewController(withIdentifier: OrderHistoryViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .termAndConditions:
            print(title.rawValue)
        case .contact:
            
            let sb = UIStoryboard(storyboard: .contact)
            let vc = sb.instantiateViewController(withIdentifier: ContactUsViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .logout:
            Helper.logout()
            AppRoute.navigateUserToAuthente()
        }
    }
    
}
