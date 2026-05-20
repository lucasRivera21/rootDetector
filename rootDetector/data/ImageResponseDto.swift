//
//  ImageResponseDto.swift
//  rootDetector
//
//  Created by Lucas Rivera on 19/05/26.
//

import Foundation
struct ImageResponseDto: Codable {
    let primary: Int
    let secondary: Int
    let tertiary: Int
    let quaternary: Int
    let rootPercent: Double
    let imgBase64: String
    
    enum CodingKeys: String, CodingKey {
        case rootPercent = "root_percent"
        case imgBase64 = "img_base64"
        case primary, secondary, tertiary, quaternary
    }
}
