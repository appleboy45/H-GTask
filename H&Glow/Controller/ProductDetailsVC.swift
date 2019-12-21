//
//  ProductDetailsVC.swift
//  H&Glow
//
//  Created by Vineet Tomar on 20/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import UIKit
import Cosmos

class ProductDetailsVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    //DeliveryView
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var deliverBtn: UIButton!
    
    //Product Images
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //Product Details
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    //Reviews
    @IBOutlet weak var productRatingView: CosmosView!
    @IBOutlet weak var reviewRatingBtn: UIButton!
    
    //Volume View
    @IBOutlet weak var volumeCollectionView: UICollectionView!
    @IBOutlet weak var viewAllValuesLbl: UILabel!
    @IBOutlet weak var volumeHeight: NSLayoutConstraint!
    
    //Facets View
    @IBOutlet weak var facetsCollectionView: UICollectionView!
    @IBOutlet weak var facetsLbl: UILabel!
    
    //No Nasties
    @IBOutlet weak var noNastiesHeaderLbl: UILabel!
    @IBOutlet weak var noNastiesDescription: UILabel!
    @IBOutlet weak var noNastiesCollectionView: UICollectionView!
    
    //DeliveryOption
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    
    
    //Ask Our Expert
    @IBOutlet weak var askQuestionTF: UITextField!
    @IBOutlet weak var postQuestionBtn: UIButton!
        //Q1View
    @IBOutlet weak var q1Lbl: UILabel!
    @IBOutlet weak var q1DateLbl: UILabel!
    @IBOutlet weak var ans1Lbl: UILabel!
    @IBOutlet weak var ans1DateLbl: UILabel!
        //Q2View
    @IBOutlet weak var q2Lbl: UILabel!
    @IBOutlet weak var q2DateLbl: UILabel!
    @IBOutlet weak var ans2Lbl: UILabel!
    @IBOutlet weak var ans2DateLbl: UILabel!
        //Q3View
    @IBOutlet weak var q3Lbl: UILabel!
    @IBOutlet weak var q3DateLbl: UILabel!
    @IBOutlet weak var ans3Lbl: UILabel!
    @IBOutlet weak var ans3DateLbl: UILabel!
    
    @IBOutlet weak var showAllQnABtn: UIButton!
    
    //User rating and Reviews
    @IBOutlet weak var userRatingView: UIView!
    @IBOutlet weak var writeReviewBtn: UIButton!
        //review1
    @IBOutlet weak var review1Rating: CosmosView!
    @IBOutlet weak var review1Header: UILabel!
    @IBOutlet weak var review1By: UILabel!
    @IBOutlet weak var review1details: UILabel!
        //review2
    @IBOutlet weak var review2Rating: CosmosView!
    @IBOutlet weak var review2Header: UILabel!
    @IBOutlet weak var review2By: UILabel!
    @IBOutlet weak var review2details: UILabel!
        //review3
    @IBOutlet weak var review3Rating: CosmosView!
    @IBOutlet weak var review3Header: UILabel!
    @IBOutlet weak var review3By: UILabel!
    @IBOutlet weak var review3details: UILabel!
        //Combo
    @IBOutlet weak var comboCollectionView: UICollectionView!
    
    @IBOutlet weak var addToFavBtn: UIButton!
    @IBOutlet weak var addToBasketView: UIView!
    
    var dataModel: ResponseDataModel?
    
    //facetIndexValue
    
    var facetIndexValue = 0
    var addedToFav = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI(){
        
        productImagesCollectionView?.register(UINib.init(nibName: "ProductImageCVC", bundle: nil), forCellWithReuseIdentifier: "ProductImageCVC")
        
        volumeCollectionView?.register(UINib.init(nibName: "VolumeCVC", bundle: nil), forCellWithReuseIdentifier: "VolumeCVC")
        
        facetsCollectionView?.register(UINib.init(nibName: "FacetCVC", bundle: nil), forCellWithReuseIdentifier: "FacetCVC")
        
        noNastiesCollectionView?.register(UINib.init(nibName: "CleanBeautyCVC", bundle: nil), forCellWithReuseIdentifier: "CleanBeautyCVC")
        
        comboCollectionView?.register(UINib.init(nibName: "CombosCVC", bundle: nil), forCellWithReuseIdentifier: "CombosCVC")
        
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
        
        volumeCollectionView.delegate = self
        volumeCollectionView.dataSource = self
        
        facetsCollectionView.delegate = self
        facetsCollectionView.dataSource = self
        
        noNastiesCollectionView.delegate = self
        noNastiesCollectionView.dataSource = self
        
        comboCollectionView.delegate = self
        comboCollectionView.dataSource = self
        
        pageControl.hidesForSinglePage = true
        
        
        //PinCode Customsation
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 30 - 1, width: pincodeTF.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        pincodeTF.borderStyle = UITextField.BorderStyle.none
        pincodeTF.layer.addSublayer(bottomLine)
        
        pincodeTF.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
        askQuestionTF.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
        
        checkBtn.layer.borderWidth = 1
        checkBtn.layer.borderColor = UIColor.orange.cgColor
        
        postQuestionBtn.layer.borderWidth = 1
        postQuestionBtn.layer.borderColor = UIColor.gray.cgColor
        
        showAllQnABtn.layer.borderWidth = 1
        showAllQnABtn.layer.borderColor = UIColor.gray.cgColor
        
        writeReviewBtn.layer.borderWidth = 1
        writeReviewBtn.layer.borderColor = UIColor.gray.cgColor
        
        Utility.addShadow(view: addToBasketView)
    }
    
    func setupUIAfterResponse(){
        
        productImagesCollectionView.reloadData()
        volumeCollectionView.reloadData()
        facetsCollectionView.reloadData()
        noNastiesCollectionView.reloadData()
        comboCollectionView.reloadData()
        
        if let data = dataModel{
            
            if let brandName = data.brandName{
                productName.text = brandName
            }
            else{
                productName.text = "N/A"
            }
            if let prodDesc = data.skuName{
                productDesc.text = prodDesc
            }
            else{
                productDesc.text = "N/A"
            }
            
            if let prodPrice = data.defaultPrice{
                priceLbl.text = "₹\(prodPrice)"
            }
            else{
                priceLbl.text = "N/A"
            }
            
            if let rating = data.skuAverageRating{
                productRatingView.rating = rating
            }
            
            if let reviewCount = data.skuReviewCount{
                reviewRatingBtn.setTitle("\(reviewCount) Reviews", for: .normal)
            }
            else{
                reviewRatingBtn.setTitle("N/A", for: .normal)
            }
            
            if let facets = data.facets{
                if let content = facets[facetIndexValue].content{
                    facetsLbl.text = content
                }
            }
            
            if let cleanBeauty = data.cleanBeauty{
                if let title = cleanBeauty.title{
                    noNastiesHeaderLbl.text = title
                }
                if let subTitle = cleanBeauty.subTitle{
                    noNastiesDescription.text = subTitle
                }
            }
            
            if let qnas = data.qna{
                if qnas.count > 1{
                    for q in 0..<qnas.count{
                        
                        switch q{
                        case 0:
                            if let q1 = qnas[0].queryText{
                                q1Lbl.text = "Q: " + q1
                            }
                            if let qPosteddate = qnas[0].postedDate{
                                var name = ""
                                if let userName = qnas[0].userNickname{
                                    name = userName
                                }
                                let date = secsToDate(seconds: qPosteddate)
                                q1DateLbl.text = "By \(name), " + date
                            }
                            if let answerData = qnas[0].answer{
                                if let ans1 = answerData.answerText{
                                    ans1Lbl.text = "A: " + ans1
                                }
                                if let ans1PostedDate = answerData.postedDate{
                                    var name = ""
                                    if let userName = answerData.userNickname{
                                        name = userName
                                    }
                                    let date = secsToDate(seconds: ans1PostedDate)
                                    ans1DateLbl.text = "By \(name), " + date
                                }
                            }
                        
                        case 1:
                            if let q2 = qnas[1].queryText{
                                q2Lbl.text = "Q: " + q2
                            }
                            if let qPosteddate = qnas[1].postedDate{
                                var name = ""
                                if let userName = qnas[1].userNickname{
                                    name = userName
                                }
                                let date = secsToDate(seconds: qPosteddate)
                                q2DateLbl.text = "By \(name), " + date
                            }
                            if let answerData = qnas[1].answer{
                                if let ans2 = answerData.answerText{
                                    ans2Lbl.text = "A: " + ans2
                                }
                                if let ans2PostedDate = answerData.postedDate{
                                    var name = ""
                                    if let userName = answerData.userNickname{
                                        name = userName
                                    }
                                    let date = secsToDate(seconds: ans2PostedDate)
                                    ans2DateLbl.text = "By \(name), " + date
                                }
                            }
                            
                        case 2:
                            if let q3 = qnas[2].queryText{
                                q3Lbl.text = "Q: " + q3
                            }
                            if let qPosteddate = qnas[2].postedDate{
                                var name = ""
                                if let userName = qnas[2].userNickname{
                                    name = userName
                                }
                                let date = secsToDate(seconds: qPosteddate)
                                q3DateLbl.text = "By \(name), " + date
                            }
                            if let answerData = qnas[2].answer{
                                if let ans3 = answerData.answerText{
                                    ans3Lbl.text = "A: " + ans3
                                }
                                if let ans3PostedDate = answerData.postedDate{
                                    var name = ""
                                    if let userName = answerData.userNickname{
                                        name = userName
                                    }
                                    let date = secsToDate(seconds: ans3PostedDate)
                                    ans3DateLbl.text = "By \(name), " + date
                                }
                            }
                            
                        default:
                            print("nothing")
                        }
                    }
                }
            }
            
            if let reviews = data.reviews{
                if reviews.count > 1{
                    for reviewIndex in 0..<reviews.count{
                        
                        switch reviewIndex{
                            
                        case 0:
                            let review = reviews[reviewIndex]
                            if let rating = review.skuRating{
                                review1Rating.rating = rating
                            }
                            if let header = review.reviewTitle{
                                review1Header.text = header
                            }
                            var name = ""
                            var postedDate = ""
                            if let username = review.userNickname{
                                name = username
                            }
                            if let date = review.postedDate{
                                postedDate = secsToDate(seconds: date)
                            }
                            review1By.text = "By \(name), \(postedDate)"
                            
                            if let reviewDetails = review.reviewText{
                                review1details.text = reviewDetails
                            }
                        
                        case 1:
                            let review = reviews[reviewIndex]
                            if let rating = review.skuRating{
                                review2Rating.rating = rating
                            }
                            if let header = review.reviewTitle{
                                review2Header.text = header
                            }
                            var name = ""
                            var postedDate = ""
                            if let username = review.userNickname{
                                name = username
                            }
                            if let date = review.postedDate{
                                postedDate = secsToDate(seconds: date)
                            }
                            review2By.text = "By \(name), \(postedDate)"
                            
                            if let reviewDetails = review.reviewText{
                                review2details.text = reviewDetails
                            }
                        
                        case 2:
                            let review = reviews[reviewIndex]
                            if let rating = review.skuRating{
                                review3Rating.rating = rating
                            }
                            if let header = review.reviewTitle{
                                review3Header.text = header
                            }
                            var name = ""
                            var postedDate = ""
                            if let username = review.userNickname{
                                name = username
                            }
                            if let date = review.postedDate{
                                postedDate = secsToDate(seconds: date)
                            }
                            review3By.text = "By \(name), \(postedDate)"
                            
                            if let reviewDetails = review.reviewText{
                                review3details.text = reviewDetails
                            }
                        
                        default:
                            print("nothing")
                            
                        }
                        
                    }
                }
                
            }
            
        }
        
    }
    
    func secsToDate(seconds: Double) -> String{
        let date = Date(timeIntervalSince1970: seconds)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd MMMM"
        let localDate = dateFormatter.string(from: date)
        return localDate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        productApi()
        
    }
    
    func productApi(){
        
        LoadingIndicator.shared.show()
        
        NetworkManager.sharedInstance.loadData { (response,error)  in
            
            if let _ = error{
                LoadingIndicator.shared.hide()
                Utility.alertView(controller: self, title: "Lost Connection", message: "Please check your connection and try again!")
            }
            
            if let response = response{
                
                LoadingIndicator.shared.hide()
                
                self.dataModel = response
                
                DispatchQueue.main.async {
                    self.setupUIAfterResponse()
                }
            }
        }
        
    }
    
    @IBAction func addToFavouritesTapped(_ sender: Any) {
        if addedToFav{
            addedToFav = !addedToFav
            addToFavBtn.setImage(UIImage(named: "heartFilled"), for: .normal)
        }
        else
        {
            addedToFav = !addedToFav
            addToFavBtn.setImage(UIImage(named: "emptyHeart"), for: .normal)
        }
    }
    
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        
        guard let data = dataModel else{return}
        guard let urlToShare = data.deepLinkUrl else{return}
        
        let someText:String = "Hey, you've got to check out this product right away!"
        if let objectsToShare:URL = URL(string: urlToShare){
            let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
            let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.message, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
}

extension ProductDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == productImagesCollectionView{
            guard let response = self.dataModel else{return 0}
            guard let imageArray = response.skuImageUrls else{return 0}
            self.pageControl.numberOfPages = imageArray.count
            return imageArray.count
        }
        else if collectionView == volumeCollectionView{
            guard let response = self.dataModel else{return 0}
            guard let variants = response.variants else{return 0}
            guard let volumes = variants.volume else{return 0}
            return volumes.count
        }else if collectionView == facetsCollectionView{
            guard let response = self.dataModel else{return 0}
            guard let facets = response.facets else{return 0}
            return facets.count
            
        }else if collectionView == noNastiesCollectionView{
            guard let response = self.dataModel else{return 0}
            guard let cleanBeauty = response.cleanBeauty else{return 0}
            guard let images = cleanBeauty.imageUrls else{return 0}
            return images.count
        }else if collectionView == comboCollectionView{
            guard let response = self.dataModel else{return 0}
            guard let combos = response.productCombo else{return 0}
            return combos.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let response = self.dataModel{
            if collectionView == productImagesCollectionView{
                
                if let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCVC", for: indexPath) as? ProductImageCVC{
                    
                    
                    if let imageArray = response.skuImageUrls{
                        let imageUrl = imageArray[indexPath.row]
                        
                        cell.imageUrl = imageUrl
                        cell.setupCell()
                    }
                    
                    return cell
                }
                
                return UICollectionViewCell()
                
            }
            else if collectionView == volumeCollectionView{
                
                if let volumeCell = volumeCollectionView.dequeueReusableCell(withReuseIdentifier: "VolumeCVC", for: indexPath) as? VolumeCVC{
                    
                    guard let response = self.dataModel else{return volumeCell}
                    guard let variants = response.variants else{return volumeCell}
                    guard let volumes = variants.volume else{return volumeCell}
                    
                    let volume = volumes[indexPath.row]
                    
                    volumeCell.volumeData =  volume
                    volumeCell.setupCell()
                    
                    return volumeCell
                    
                }
                
                return UICollectionViewCell()
                
            } else if collectionView == facetsCollectionView{
                
                if let facetCell = facetsCollectionView.dequeueReusableCell(withReuseIdentifier: "FacetCVC", for: indexPath) as? FacetCVC{
                    
                    guard let response = self.dataModel else{return facetCell}
                    guard let facets = response.facets else{return facetCell}
                    
                    let facet = facets[indexPath.row]
                    facetCell.facet = facet
                    if facetIndexValue == indexPath.row{
                        facetCell.facetIsSelected = true
                    }
                    else
                    {
                        facetCell.facetIsSelected = false
                    }
                    
                    facetCell.setupCell()
                    
                    return facetCell
                    
                }
            } else if collectionView == noNastiesCollectionView{
                
                if let cleanBeautyCell = noNastiesCollectionView.dequeueReusableCell(withReuseIdentifier: "CleanBeautyCVC", for: indexPath) as? CleanBeautyCVC{
                    
                    guard let response = self.dataModel else{return cleanBeautyCell}
                    guard let cleanBeauty = response.cleanBeauty else{return cleanBeautyCell}
                    guard let images = cleanBeauty.imageUrls else {return cleanBeautyCell}
                    
                    let imageUrl = images[indexPath.row]
                    cleanBeautyCell.imageUrl = imageUrl
                    cleanBeautyCell.setupCell()
                    
                    return cleanBeautyCell
                }
            } else if collectionView == comboCollectionView{
                
                if let comboCell = comboCollectionView.dequeueReusableCell(withReuseIdentifier: "CombosCVC", for: indexPath) as? CombosCVC{
                    
                    guard let response = self.dataModel else{return comboCell}
                    guard let combos = response.productCombo else{return comboCell}
                    
                    let combo = combos[indexPath.row]
                    comboCell.combo = combo
                    comboCell.setupCell()
                    
                    return comboCell
                }
                
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == productImagesCollectionView{
            let height = productImagesCollectionView.frame.height
            let width = productImagesCollectionView.frame.width
            
            return CGSize(width: width, height: height)
        }
        else if collectionView == volumeCollectionView{
            
            return CGSize(width: 60, height: 60)
        }
        else if collectionView == facetsCollectionView{
            return CGSize(width: 100, height: 30)
        }
        else if collectionView == noNastiesCollectionView{
            return CGSize(width: 80, height: 80)
        }
        else if collectionView == comboCollectionView{
            
            let width = CGFloat(UIScreen.main.bounds.width * 0.8)
            let height = CGFloat(400)
            
            return CGSize(width: width, height: height)
        }
        
        return CGSize(width: 0, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == volumeCollectionView || collectionView == noNastiesCollectionView || collectionView == comboCollectionView{
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == volumeCollectionView || collectionView == noNastiesCollectionView || collectionView == comboCollectionView{
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == facetsCollectionView{
            self.facetIndexValue = indexPath.row
            
            if let data = self.dataModel{
                if let facets = data.facets{
                    if let content = facets[facetIndexValue].content{
                        facetsLbl.text = content
                    }
                }
            }
            
            facetsCollectionView.reloadData()
            
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == productImagesCollectionView{
            self.pageControl.currentPage = indexPath.item
        }
        
    }
    
}
