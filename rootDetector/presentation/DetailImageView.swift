//
//  DetailImageView.swift
//  rootDetector
//
//  Created by Lucas Rivera on 21/05/26.
//

import SwiftUI

struct DetailImageView: View {
    let img: UIImage
    
    @State private var vm = DetailImageViewModel()
    
    private var isLandscape: Bool {
        img.size.width > img.size.height
    }
    var body: some View {
        VStack{
            Image(uiImage: img.fixedOrientation())
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Button(action: {Task{
                let downloadSuccess = await vm.saveToGallery(image: img)
                print(downloadSuccess)
            }}, label: {Text("Descargar imagen")}).padding().frame(maxWidth: .infinity).background(Color(.primary)).foregroundStyle(Color(.onPrimary)).cornerRadius(12)
        }.frame(maxHeight: .infinity).padding().background(.surface).navigationTitle("Detalles")
    }
}

extension UIImage {
    func fixedOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))

        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return normalizedImage ?? self
    }
}
