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
    var showAlert: Bool = false
    var rootDetectedModel: RootDetectedModel?
    
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
    
    func onChangeShowAlert(){
        showAlert = false
    }
    
    func onSendImage() async {
        isLoading = true
        rootDetectedModel = nil
        
        let data: Data? = prepareImageForUpload()
        if(data == nil){
            isLoading = false
            return
        }
        
        if(apiNetwork == nil){
            apiNetwork = ApiNetwork()
        }
        
        do{
            if let networkService = apiNetwork{
                let result = try await networkService.postImage(data!)
                switch result {
                case .success(let dto):
                    self.rootDetectedModel = RootDetectedModel(from: dto)
                case .arucoDontFound:
                    arucoDontFound = true
                case .serverError:
                    showAlert = true
                }
            }
        } catch {
            showAlert = true
        }
        isLoading = false
       
    }
    
    private func prepareImageForUpload() -> Data? {
        return self.selectedImage?.jpegData(compressionQuality: 0.7)
    }
}
