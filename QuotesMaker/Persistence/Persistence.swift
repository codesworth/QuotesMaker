//
//  Persistence.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation
import CloudKit


class Persistence{
    
    
    
    private static let _main = Persistence()
    
    static var main:Persistence{
        return _main
    }
    
    private var _imageSrcHolder:[String] = []
    
    func getImageSrcs()->[String]{
        return _imageSrcHolder
    }
    
    func updateImage(src:String){
        if !_imageSrcHolder.contains(src){
            _imageSrcHolder.append(src)
        }
    }
    
    func invalidateHeldImages(){
        _imageSrcHolder.removeAll()
    }
    
    func createDirectories(){
        do {
            try FileManager.default.createDirectory(at: FileManager.modelDir, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.createDirectory(at: FileManager.modelImagesDir, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.createDirectory(at: FileManager.previewthumbDir, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.createDirectory(at: FileManager.exportedDir, withIntermediateDirectories: true, attributes: nil)
        } catch let err {
            print("Error Creating Files: \(err)")
        
        }
    }
    
    func getThumbImageFor(name:String)->UIImage?{
        let  expectedName = name.appending(".").appending(FileManager.Extensions.jpg.rawValue)
        do{
            let files = try FileManager.default.contentsOfDirectory(atPath: FileManager.previewthumbDir.path)
            print(files)
            print(expectedName)
            let file = files.first{$0 == expectedName}
            guard let exFile = file else {throw NSError(domain: "Persistence", code: 0, userInfo: ["message":"Cannot Locate file"])}
            let url = URL(fileURLWithPath: exFile, relativeTo: FileManager.previewthumbDir)
            let image = UIImage(contentsOfFile: url.path)
            return image
        }catch let err{
            print("Error Occurred gettting files: \(err)")
        }
        return nil
    }
    
    func fetchAllModels()->[StudioModel]{

        do {
            var files = try FileManager.default.contentsOfDirectory(atPath: FileManager.modelDir.path)
            //print("These are all the files: \(files)")
            files.removeAll{!$0.hasSuffix(FileManager.Extensions.json.rawValue)}
            //print("The trimmed files: \(files)")
            var models:[StudioModel] = []
            files.forEach{
                do{
                    let decoder = JSONDecoder()
                    let url = URL(fileURLWithPath: $0, relativeTo: FileManager.modelDir)
                    let data = try Data(contentsOf: url)
                    let model = try decoder.decode(StudioModel.self, from: data)
                    models.append(model)
                }catch let err{
                    print("Error Occurred gettting files: \(err)")
                    //continue
                }
            }
//            let models = try files.compactMap{ file -> StudioModel in
//                let decoder = JSONDecoder()
//                let url = URL(fileURLWithPath: file, relativeTo: FileManager.modelDir)
//                let data = try Data(contentsOf: url)
//                let model = try decoder.decode(StudioModel.self, from: data)
//                return model
//            }
            return models
            
        } catch let err {
            print("Error Occurred gettting files: \(err)")
        }
        return []
    }
    
    func save(model:StudioModel){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(model)
            let url = URL(fileURLWithPath: model.name, relativeTo: FileManager.modelDir).addExtension(.json) //FileManager.modelDir.appendingPathComponent(model.id).addExtension(.json)
            try data.write(to: url)
            let item = Cloudstore.CloudItem(name: model.name, blobUrl: url,asseturls:getImageSrcs())
            Cloudstore.store.saveToRecord(item: item)
            invalidateHeldImages()
            print("This is the url to file: \(url)")
        }catch let err{
            print("Error Occurred with sig: \(err.localizedDescription)")
        }
    
    }
    
    func deleteFile(src: URL,in directory:FileManager.Directories? = nil){
        do {
            try FileManager.default.removeItem(at: src)
        } catch let err {
            print("Error Occurred with sig: \(err.localizedDescription)")
        }
    }
    
    func fileExists(name:String, with extension:FileManager.Extensions, in directory:FileManager.Directories)->Bool{
        let directory = FileManager.homeDir.appendingPathComponent(directory.rawValue, isDirectory: true)
        let file = URL(fileURLWithPath: name, relativeTo: directory).addExtension(`extension`)
        return FileManager.default.fileExists(atPath: file.path)
        
    }
    
    func persistFromCloud(record:CKRecord, assets:[CKRecord]){
        guard let name = record[Cloudstore.Keys.name] as? String else {return}
        let thumbImageAsset = record[Cloudstore.Keys.thumbNail]
            as? CKAsset
        let blobAsset = record[Cloudstore.Keys.blob] as? CKAsset
        //let imageAssests = record[Cloudstore.Keys.blobAssets] as? [CKAsset] ?? []
        if let blobUrl = blobAsset?.fileURL{
            do{
                let data = try Data(contentsOf: blobUrl)
                try data.write(to: URL(fileURLWithPath: name, relativeTo: FileManager.modelDir).addExtension(.json))
                if let thumburl = thumbImageAsset?.fileURL{
                    let data = try Data(contentsOf: thumburl)
                    try data.write(to: .path(name: name, in: .previewThumbnails, extension:.png))
                }
                try assets.forEach{
                    if let id = $0[Cloudstore.Keys.id] as? String,
                        let asset = $0[Cloudstore.Keys.asset] as? CKAsset{
                        let data = try Data(contentsOf: asset.fileURL)
                        try data.write(to: .path(name:id, in: .modelImages))
                    }
                }

            }catch let err {
                print("Error Persisting Cloud Item : \(err.localizedDescription)")
            }
        }else{
            return
        }
        print("Persistent to local storage")
    }
    
}
