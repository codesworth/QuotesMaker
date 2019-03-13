//
//  CustomAlbum.swift
//  Floq
//
//  Created by Mensah Shadrach on 28/12/2018.
//  Copyright © 2018 Arun Nagarajan. All rights reserved.
//

import Foundation
import Photos


class CustomPhotoAlbum: NSObject {
    
    private var albumName:String = "Quote Studio"
    
    var assetCollection: PHAssetCollection!
    
    
    override init() {
        super.init()
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                ()
            })
        }
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {} else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
            return
        }
        
    }
    
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            // ideally this ensures the creation of the photo album even if authorization wasn't prompted till after init was done
            
        } else {
            print("should really prompt the user to let them know it's failed")
        }
    }
    
    func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject {
            return collection.firstObject
        }
        return nil
    }
    
    func save(image: UIImage,handler:@escaping (Bool)->()) {
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: self.albumName)   // create an asset collection with the album name
        }) { success, error in
            if success {
                self.assetCollection = self.fetchAssetCollectionForAlbum()
                PHPhotoLibrary.shared().performChanges({
                    let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
                    let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
                    let enumeration: NSArray = [assetPlaceHolder!]
                    albumChangeRequest!.addAssets(enumeration)
                }) { (success, err) in
                    handler(success)
                }
                
            } else {
                print("PHAsset error \(String(describing: error))")
            }
        }
    }
}
