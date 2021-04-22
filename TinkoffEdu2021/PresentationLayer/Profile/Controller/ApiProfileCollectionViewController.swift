//
//  CollectionViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation
import UIKit

class ApiProfileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var imageList: [ImageListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PixabayAPIService.getImageList(completionHandler: { (imageList: [ImageListItem]?, errorString: String?) in
            if let error = errorString {
                print(error)
                return
            }
            self.imageList = imageList ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApiProfileCell", for: indexPath) as? ApiProfileCell else { return UICollectionViewCell() }
        cell.configure()
        
        let url = self.imageList[indexPath.row].previewURL
        PixabayAPIService.downloadImage(urlString: url, completionHandler: {(image: UIImage?, errorString: String?) in
            if let error = errorString {
                print(error)
                return
            }
            if let img = image {
                DispatchQueue.main.async {
                    cell.setImage(image: img)
                }
            }
            
        })
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40) / 3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = self.imageList[indexPath.row].largeImageURL
        PixabayAPIService.downloadImage(urlString: url, completionHandler: {(image: UIImage?, errorString: String?) in
            if let error = errorString {
                print(error)
                return
            }
            GDCStorage.saveProfileGDC(profile: nil, img: image, onComplete: {_ in
                let profileViewController = self.presentingViewController as? ProfileViewController
                profileViewController?.profileImg.image = image
                self.dismiss(animated: true, completion: nil)
            })
        })
    }
}
