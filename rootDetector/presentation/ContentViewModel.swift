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
    private var apiNetwork: ApiNetwork? = nil
    var isLoading: Bool = false
    var arucoDontFound: Bool = false
    
    var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                arucoDontFound = false
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
    
    func onSendImage() async {
        isLoading = true
        let data: Data? = prepareImageForUpload()
        if(data == nil){
            return
        }
        
        if(apiNetwork == nil){
            apiNetwork = ApiNetwork()
        }
        
        do{
            let result = try await apiNetwork!.postImage(data!)
            switch result {
            case .success:
                print("success")
            case .arucoDontFound:
                arucoDontFound = true
            case .serverError:
                print("Server error")
            }
        } catch {
            print("error")
        }
        isLoading = false
       
    }
    
    private func prepareImageForUpload() -> Data? {
        return self.selectedImage?.jpegData(compressionQuality: 0.7)
    }
}
