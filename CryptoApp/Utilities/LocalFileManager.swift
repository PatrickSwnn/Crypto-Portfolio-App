//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 10/05/2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init(){ }
    
    
    //Reuseable Folder URL
    private func getURLForFolder(folderName:String)->URL?{
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
        else { return nil }
        return path
    }
    
    // Reusable ImageURL
    private func getURLForImage(imageName:String,folderName:String)->URL?{
        guard let path = getURLForFolder(folderName: folderName) else { return nil }
        return path.appendingPathComponent(imageName + ".png")
            
    }

    
    //Creating Folder
    private func createFolderIfNeeded(folderName:String){
        guard let path = getURLForFolder(folderName: folderName), !FileManager.default.fileExists(atPath: path.path)
        else { return }
        do {
            try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
        } catch let error {
            print("Error creating \(folderName) due to \(error.localizedDescription)")
        }
    }
    
    
  // saveImage
    func saveImage(desiredImage:UIImage,imageName:String,folderName:String){
        //making a new folder if there is none
        createFolderIfNeeded(folderName: folderName)
        
        guard let path = getURLForImage(imageName: imageName, folderName: folderName) else { return }
        if let imageData = desiredImage.pngData() {
            do {
                try imageData.write(to: path)
            } catch let error {
                print("Error saving image \(imageName) at \(path) due to \(error)")
            }
        }
    }
    
    // getImage
    func getImage(imageName:String,folderName:String)->UIImage?{
        guard let path = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: path.path) else { return nil }
        return UIImage(contentsOfFile: path.path)
              
    }
    
 
}
