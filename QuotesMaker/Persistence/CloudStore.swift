//
//  CloudStore.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/07/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import CloudKit


public class Cloudstore:NSObject{
    
    private static let _store = Cloudstore()
    
    static var store:Cloudstore{
        return _store
    }
    
    var cursor:CKQueryOperation.Cursor?
    
    private var privateCloud = CKContainer.default().privateCloudDatabase
    private var publicCloud = CKContainer.default().publicCloudDatabase
    
    func saveToRecord(item:CloudItem){
       let record = CKRecord(recordType: Keys.entityStudioBlob)
        record[Keys.name] = item.name
        record[Keys.thumbNail] = CKAsset(fileURL: URL(fileURLWithPath: item.name, relativeTo: FileManager.previewthumbDir).addExtension(.png))
        record[Keys.blob] = CKAsset(fileURL: item.blobUrl)
        var recordsToSave = item.assetList.compactMap{ id -> CKRecord in
            let assetRec = CKRecord(recordType: Keys.entityBlobAsset)
            assetRec[Keys.id] = id
            assetRec[Keys.parentModel] = CKRecord.Reference(record: record, action: .deleteSelf)
            assetRec[Keys.type] = AssetType.image
            assetRec[Keys.asset] = CKAsset(fileURL: URL(fileURLWithPath: id, relativeTo: FileManager.modelImagesDir))
            return assetRec
            
        }
        recordsToSave.append(record)
        let operation = CKModifyRecordsOperation(recordsToSave: recordsToSave, recordIDsToDelete: nil)
        operation.perRecordCompletionBlock = {record, err in
            if err != nil{
                print("Error occurred: \(err!.localizedDescription)")
            }
        }
        operation.completionBlock = {
            print("Operation Completed Succesfully")
        }
        privateCloud.add(operation)
//        privateCloud.save(record) { (record, err) in
//            if let err = err{
//                print("Error occurred with iCloud: \(err.localizedDescription)")
//
//            }else{
//                print("The record is: \(record)")
//            }
//        }
    }
    
    func fetAvailableModel(cursor:CKQueryOperation.Cursor? = nil){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Keys.entityStudioBlob, predicate: predicate)
        let operation = (cursor != nil) ? CKQueryOperation(cursor: cursor!) : CKQueryOperation(query: query)
        operation.resultsLimit = 20
        
        operation.recordFetchedBlock = {record in
            guard let name = record[Keys.name] as? String else {return}
            let assetQuery = CKQuery(recordType: Keys.entityBlobAsset, predicate: NSPredicate(format: "parentModel = %@", name))
            self.privateCloud.perform(assetQuery, inZoneWith: nil, completionHandler: { (assets, er) in
                if let assets = assets {
                  Persistence.main.persistFromCloud(record: record, assets: assets)
                }else{
                    Persistence.main.persistFromCloud(record: record, assets: [])
                }
            })
        }
        
        operation.queryCompletionBlock = {cursor, error in
            self.cursor = cursor
        }
        
        operation.completionBlock = {
            //Fire a block to refresh
            print("Query completed")
        }
        
        privateCloud.add(operation)
        
    }
}





extension Cloudstore{
    
    public struct CloudItem{
        let name:String
        let blobUrl:URL
        let assetList:[String]
        let thumbNail:String = ""
    }
    
    public struct ItemAsset{
        let id:String
        let url:URL
        let type:AssetType
    }
}

extension Cloudstore{
    
    public enum Keys{
        static let entityStudioBlob = "StudioBlob"
        static let entityBlobAsset = "StudioAsset"
        static let id = "id"
        static let blob = "blobData"
        static let name = "name"
        static let type = "type"
        static let thumbNail = "thumbNail"
        static let asset = "asset"
        static let parentModel = "parentModel"
    }
    
    public enum AssetType{
        static let image = 100
        static let video = 30
        static let json = 150
    }
}
