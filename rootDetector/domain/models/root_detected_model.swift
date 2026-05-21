//
//  root_detected_model.swift
//  rootDetector
//
//  Created by Lucas Rivera on 20/05/26.
//

import Foundation
import UIKit

struct RootDetectedModel {
    let primary: Int
    let secondary: Int
    let tertiary: Int
    let quaternary: Int
    let percentage: Double
    let image: UIImage
}

extension RootDetectedModel {
    init?(from dto: ImageResponseDto){
        let base64Limpio = dto.imgBase64.contains(",") ?
        dto.imgBase64.components(separatedBy: ",").last ?? dto.imgBase64 : dto.imgBase64
        
        guard let imageData = Data(base64Encoded: base64Limpio),
              let uiImageSegura = UIImage(data: imageData) else {
            print("❌ Error: No se pudo decodificar el Base64 a una imagen real.")
            return nil
        }
        
        self.primary = dto.primary
        self.secondary = dto.secondary
        self.tertiary = dto.tertiary
        self.quaternary = dto.quaternary
        self.percentage = dto.rootPercent
        self.image = uiImageSegura
    }
}
