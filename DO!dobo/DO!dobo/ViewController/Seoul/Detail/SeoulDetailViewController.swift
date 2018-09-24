//
//  SeoulDetailViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 17..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher
import SilentScrolly

class SeoulDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, SilentScrollable {
    
    //imageslideshow
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //silentscrolly
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle(showStyle: .default, hideStyle: .default)
    }
    
    var silentScrolly: SilentScrolly?
    
    @IBOutlet weak var placeImageSlide: ImageSlideshow!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var reservationButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeCollectionView: UICollectionView!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    
    
    //    let localSource = [ImageSource(imageString: "sad_cloud_dark.png")!, ImageSource(imageString: "sad_cloud.png")!, ImageSource(imageString: "powered-by-google-light.png")!, ImageSource(imageString: "powered-by-google-dark.png")!]
    //    let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    
    let kingfisherSource = [KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn(color: .white)
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self

        //navigation bar
        tableView.contentInset = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        setNavigationBar()
    
        //ImageSlideShow
        placeImageSlide.slideshowInterval = 5.0
        placeImageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        placeImageSlide.contentScaleMode = UIViewContentMode.scaleToFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.4705882353, green: 0.7843137255, blue: 0.7764705882, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        placeImageSlide.pageIndicator = pageControl
        placeImageSlide.pageIndicatorPosition = PageIndicatorPosition(horizontal: .right(padding: 20), vertical: .bottom)
        
        placeImageSlide.currentPageChanged = { page in
            print("current page:", page)
        }
        
        placeImageSlide.setImageInputs(kingfisherSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SeoulightDetailViewController.didTap))
        placeImageSlide.addGestureRecognizer(recognizer)
        
        //collectionView
        placeCollectionView.delegate = self
        placeCollectionView.dataSource = self
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
        
    }
    
    //MARK: silentscrolly
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        silentDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSilentScrolly(tableView, followBottomView: tabBarController?.tabBar)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        silentWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        silentDidDisappear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        silentWillTranstion()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        silentDidScroll()
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        showNavigationBar()
        return true
    }
    
    //MARK: 네비게이션 바 투명하게 하는 함수
    func setNavigationBar() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
        
    }
    
    //MARK: ImageSlideShow
    @objc func didTap() {
        let fullScreenController = placeImageSlide.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    //MARK: TableView method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeoulDetailReviewTableViewCell") as! SeoulDetailReviewTableViewCell
        
        cell.nameLabel.text = "김예은"
        cell.dateLabel.text = "2018.09.20"
        cell.contentTextView.text = "정말 좋은 경험이었습니다."
        
        return cell
    }
    
    //MARK: 리뷰 댓글 삭제
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            
            // remove the item from the data model
            //            self.model.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        deleteAction.backgroundColor = #colorLiteral(red: 0.4705882353, green: 0.7843137255, blue: 0.7764705882, alpha: 1)
        
        return [deleteAction]
    }
    
    //MARK: CollectionView method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == placeCollectionView {
                return 5
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == placeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulPlaceCollectionViewCell", for: indexPath) as! SeoulPlaceCollectionViewCell
            
            cell.placeImageView.image = #imageLiteral(resourceName: "group16.png")
            cell.nameLabel.text = "오설록"
            cell.categoryLabel.text = "음식점"
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulCourseCollectionViewCell", for: indexPath) as! SeoulCourseCollectionViewCell
            
            cell.courseImageView.image = #imageLiteral(resourceName: "group16.png")
            cell.nameTextView.text = "오설록"
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //TODO: 예약 상태 활성화 / 비활성화
    //MARK: 예약하기
    @IBAction func reservationAction(_ sender: UIButton) {
    }
 
    
    //TODO: 모달로 띄워서 리뷰 등록
    //MARK: 리뷰 등록하기
    @IBAction func reviewAction(_ sender: UIButton) {
        let reviewPopUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulReviewPopUpViewController") as! SeoulReviewPopUpViewController
        
        self.addChildViewController(reviewPopUp)
        reviewPopUp.view.frame = self.view.frame
        self.view.addSubview(reviewPopUp.view)
        
        reviewPopUp.didMove(toParentViewController: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//extension UIViewController {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        silentDidScroll()
//    }
//
//    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
//        showNavigationBar()
//        return true
//    }
//}

