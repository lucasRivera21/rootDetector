//
//  DetailImageViewModel.swift
//  rootDetector
//
//  Created by Lucas Rivera on 28/05/26.
//

import UIKit
import Photos

import Foundation
@Observable class DetailImageViewModel {
    func saveToGallery(image: UIImage) async -> Bool {
        let status = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
        
        guard status == .authorized || status == .limited else {
            return false
        }
        
        return await withCheckedContinuation{ continuation in
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            } completionHandler: { success, error in
                if success {
                    print("✅ Imagen guardada con éxito en la galería.")
                    continuation.resume(returning: true)
                } else {
                    print("❌ Error al guardar la imagen: \(error?.localizedDescription ?? "Desconocido")")
                    continuation.resume(returning: false)
                }
            }
        }
    }
}
