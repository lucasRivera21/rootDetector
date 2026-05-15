//
//  ContentViewModel.swift
//  rootDetector
//
//  Created by Lucas Rivera on 15/05/26.
//

import Foundation
import PhotosUI
import SwiftUI

@Observable class ContentViewModel {
    var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                await onUploadImage()
            }
        }
    }
    var selectedImage: UIImage?
    
    @MainActor
    private func onUploadImage() async {
        guard let selectedItem else { return }
        
        if let data = try? await selectedItem.loadTransferable(type: Data.self){
            if let uiImage = UIImage(data: data) {
                self.selectedImage = uiImage
            }
        }
    }
}
