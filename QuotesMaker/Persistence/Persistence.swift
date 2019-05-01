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
            try FileManager.default.createDirectory(at: FileManager.previewthumbDir, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.createDirectory(at: FileManager.exportedDir, withIntermediateDirectories: true, attributes: nil)
        } catch let err {
            print("Error Creating Files: \(err)")
        
        }
    }
    
    func getThumbImageFor(name:String)->UIImage?{
        do{
            var files = try FileManager.default.contentsOfDirectory(atPath: FileManager.previewthumbDir.path)
            print(files)
            let file = files.first{$0 == name.append(FileManager.Extensions.png)}
        }catch let err{
            print("Error Occurred gettting files: \(err)")
        }
    }
    
    func fetchAllModels()->[StudioModel]{

        do {
            var files = try FileManager.default.contentsOfDirectory(atPath: FileManager.modelDir.path)
            //print("These are all the files: \(files)")
            files.removeAll{!$0.hasSuffix(FileManager.Extensions.json.rawValue)}
            //print("The trimmed files: \(files)")
            let models = try files.compactMap{ file -> StudioModel in
                let decoder = JSONDecoder()
                let url = URL(fileURLWithPath: file, relativeTo: FileManager.modelDir)
                let data = try Data(contentsOf: url)
                let model = try decoder.decode(StudioModel.self, from: data)
                return model
            }
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
    
}
