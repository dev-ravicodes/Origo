//
//  UploadFileModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 28/02/24.
//

import UIKit

struct UploadImageRequestModel:Codable {
    var url: String?
    var file : UIImage?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
    
    var json: [String: String] {
        let dictionary: [String: String] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    var multipartModel: MultipartModel {
        let image = MultipartModel(key: "file", data: self.file?.jpegData(compressionQuality: 0.5), url: nil, mimeType: .image, fileName: "image.png")
        return image
    }
    
}

struct UploadImageArrRequestModel:Codable {
    var url: String?
    var arrImages = [UIImage]()
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
    
    var json: [String: String] {
        let dictionary: [String: String] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    var multipartModel: [MultipartModel] {
        var arrMultipartModel = [MultipartModel]()
        for image in arrImages{
            let imageMultipart = MultipartModel(key: "files", data: image.jpegData(compressionQuality: 0.5), url: nil, mimeType: .image, fileName: "image.png")
            arrMultipartModel.append(imageMultipart)
        }
        return arrMultipartModel
    }
 
}
