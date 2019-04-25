//
//  Persistence.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


class Persistence{
    
    
    
    private static let _main = Persistence()
    
    static var main:Persistence{
        return _main
    }
    
    func createDirectories(){
        do {
            try FileManager.default.createDirectory(at: FileManager.modelDir, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.createDirectory(at: FileManager.modelImagesDir, withIntermediateDirectories: true, attributes: nil)
        } catch let err {
            print("Error Creating Files: \(err)")
        }
    }
    
    func fetchAllModels(){
        var models:[StudioModel] = []
        do {
            var files = try FileManager.default.contentsOfDirectory(atPath: FileManager.homeDir.absoluteString)
            print("These are all the files: \(files)")
            files.removeAll{!$0.hasSuffix(FileManager.Extensions.json.rawValue)}
            print("The trimmed files: \(files)")
            
        } catch let err {
            print("Error Occurred gettting files: \(err)")
        }
        
    }
    
    func save(model:StudioModel){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(model)
            let url = URL(fileURLWithPath: model.id, relativeTo: FileManager.modelDir).addExtension(.json) //FileManager.modelDir.appendingPathComponent(model.id).addExtension(.json)
            try data.write(to: url)
            print("This is the url to file: \(url)")
        }catch let err{
            print("Error Occurred with sig: \(err.localizedDescription)")
        }
    
    }
    
}
