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
    
    var settings:Settings{
        return Settings()
    }
    
    
    
    var recentCursor:CKQueryOperation.Cursor?
    var templateCursor:CKQueryOperation.Cursor?
    
    private var privateCloud = CKContainer.default().privateCloudDatabase
    private var publicCloud = CKContainer.default().publicCloudDatabase
    
    func saveToRecord(item:CloudItem){
        if !settings.icloudSupport {return}
       let record = CKRecord(recordType: Keys.entityStudioBlob)
        record[Keys.name] = item.name
        record[Keys.thumbNail] = CKAsset(fileURL: URL(fileURLWithPath: item.name, relativeTo: FileManager.previewthumbDir).addExtension(.png))
        record[Keys.blob] = CKAsset(fileURL: item.blobUrl)
//        let relatedImgsAssets = item.assetList.compactMap{CKAsset(fileURL: URL(fileURLWithPath: $0, relativeTo: FileManager.modelImagesDir))}
        record[Keys.relatedAssets] = item.assetList
        var recordsToSave = item.assetList.compactMap{ id -> CKRecord in
            let assetRec = CKRecord(recordType: Keys.entityBlobAsset)
            assetRec[Keys.id] = id
            assetRec[Keys.entityStudioBlob] = CKRecord.Reference(record: record, action: .deleteSelf)
            assetRec[Keys.type] = AssetType.image
            assetRec[Keys.asset] = CKAsset(fileURL: URL(fileURLWithPath: id, relativeTo: FileManager.modelImagesDir))
            return assetRec

        }
        recordsToSave.append(record)
        let operation = CKModifyRecordsOperation(recordsToSave: recordsToSave, recordIDsToDelete: nil)
        operation.perRecordCompletionBlock = {record, err in
            if err != nil{
                print("❌ ❌ ❌ Error occurred at operation: \(err!.localizedDescription)")
            }else{
                 print("✅ CLKIT ✅ Operation Per Record Completed Succesfully")
            }
        }
        operation.completionBlock = {
            print("✅ CLKIT ✅ Operation Completed Succesfully")
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
        if !settings.icloudSupport{
            return
        }
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Keys.entityStudioBlob, predicate: predicate)
        let operation = (recentCursor != nil) ? CKQueryOperation(cursor: recentCursor!) : CKQueryOperation(query: query)
        operation.resultsLimit = 20
        
        operation.recordFetchedBlock = {record in
            
            let assetQuery = CKQuery(recordType: Keys.entityBlobAsset, predicate: NSPredicate(format: "\(Keys.entityStudioBlob) = %@", record.recordID))
            self.privateCloud.perform(assetQuery, inZoneWith: nil, completionHandler: { (assets, er) in
                print(assets ?? "No Asset")
                if let assets = assets {
                    Persistence.main.persistFromCloud(record: record, assets: assets, dir: FileManager.modelDir, subscriptionName: .refreshRecent)
                }else{
                    Persistence.main.persistFromCloud(record: record, assets: [], dir: FileManager.modelDir, subscriptionName: .refreshRecent)
                }
            })
        }
        
        operation.queryCompletionBlock = {cursor, error in
            self.recentCursor = cursor
        }
        
        operation.completionBlock = {
            //Fire a block to refresh
            print("Query completed")
            Subscription.main.post(suscription: .refreshRecent, object: nil)
        }
        
        privateCloud.add(operation)
        
    }
    
    func  getTemplates(){
    
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Keys.entityStudioBlob, predicate: predicate)
        let operation = (templateCursor != nil) ? CKQueryOperation(cursor: templateCursor!) : CKQueryOperation(query: query)
        operation.resultsLimit = 20
        
        operation.recordFetchedBlock = {record in
            
            let assetQuery = CKQuery(recordType: Keys.entityBlobAsset, predicate: NSPredicate(format: "\(Keys.entityStudioBlob) = %@", record.recordID))
            self.publicCloud.perform(assetQuery, inZoneWith: nil, completionHandler: { (assets, er) in
                print(assets ?? "No Asset")
                if let assets = assets {
                    Persistence.main.persistFromCloud(record: record, assets: assets, dir: FileManager.templatesDir, subscriptionName: .refreshTemplates)
                }else{
                    Persistence.main.persistFromCloud(record: record, assets: [], dir: FileManager.templatesDir, subscriptionName: .refreshTemplates)
                }
            })
        }
        
        operation.queryCompletionBlock = {cursor, error in
            self.templateCursor = cursor
        }
        
        operation.completionBlock = {
            //Fire a block to refresh
            print("Query completed")
            Subscription.main.post(suscription: .refreshRecent, object: nil)
        }
        
        publicCloud.add(operation)
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
        static let relatedAssets = "relatedAssets"
        static let asset = "asset"
        static let parentModel = "parentModel"
    }
    
    public enum AssetType{
        static let image = 100
        static let video = 30
        static let json = 150
    }
}
