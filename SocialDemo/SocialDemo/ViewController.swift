//
//  ViewController.swift
//  SocialDemo
//
//  Created by Parikshit Hedau on 29/07/18.
//  Copyright © 2018 parikshit.hedau. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
}

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let fb = FacebookManager()
        
        fb.getPhotos { (arr) in
            
            print(arr)
            
            self.savePhotos(arrayPhotos: arr)
        }
    }
    
    func savePhotos(arrayPhotos: [[String:Any]]?) {
        
        if let arr = arrayPhotos {
            
            let db = DatabaseManager()
            db.savePhotos(arrayPhotos: arr, type: "fb") { (success) in
                
                
            }
        }
    }
    
    private func viewConfigrations() {
        
        collectionViewPhotos.contentInset = UIEdgeInsetsMake(0, 30, 0, 30)
        collectionViewPhotos.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateCellsLayout()
    }
    
    func updateCellsLayout()  {
        
        let centerX = collectionViewPhotos.contentOffset.x + (collectionViewPhotos.frame.size.width)/2
        for cell in collectionViewPhotos.visibleCells {
            
            var offsetX = centerX - cell.center.x
            if offsetX < 0 {
                offsetX *= -1
            }
            cell.transform = CGAffineTransform.identity
            let offsetPercentage = offsetX / (view.bounds.width * 2.7)
            let scaleX = 1-offsetPercentage
            cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
        }
    }
    
    //MARK :-
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize: CGSize = collectionView.bounds.size
        
        cellSize.width -= collectionView.contentInset.left * 2
        cellSize.width -= collectionView.contentInset.right * 2
        cellSize.height = cellSize.width
        
        return cellSize
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCellsLayout()
    }
}
