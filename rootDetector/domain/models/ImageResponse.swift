//
//  ImageResponse.swift
//  rootDetector
//
//  Created by Lucas Rivera on 19/05/26.
//

import Foundation
indirect enum ImageResponse<T> {
    case success(ImageResponseDto)
    case arucoDontFound
    case serverError
}
