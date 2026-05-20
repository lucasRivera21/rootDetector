//
//  ApiNetwork.swift
//  rootDetector
//
//  Created by Lucas Rivera on 18/05/26.
//

import Foundation
import UIKit
class ApiNetwork {
    func postImage(_ imageData: Data) async throws -> ImageResponse<Any> {
        let url = URL(string: "https://lucasrivera21-root-detector-v2.hf.space/predict")
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"img_uploaded\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: body)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return ImageResponse.serverError
        }
        
        let statusCode = httpResponse.statusCode
        if(statusCode == 200){
            let imageResponseDto = try JSONDecoder().decode(ImageResponseDto.self, from: data)
            return ImageResponse.success(imageResponseDto)
        }
        
        if(statusCode == 400){
            return ImageResponse.arucoDontFound
        }
        
        return ImageResponse.serverError
    }
}
