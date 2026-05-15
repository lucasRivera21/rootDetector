//
//  ContentView.swift
//  rootDetector
//
//  Created by Lucas Rivera on 14/05/26.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct ContentView: View {
    @State var vm = ContentViewModel()
    
    var body: some View {
        VStack() {
            Text("Detector de raices").font(.system(size: 20, weight: Font.Weight.semibold)).foregroundStyle(Color(.onSurface))
            
            ZStack{
                
            }.frame(height: 80)
            
            VStack(spacing: 16){
                if let uiImage = vm.selectedImage{
                    GeometryReader{ geometry in
                        PhotosPicker(selection: $vm.selectedItem, matching: .images){
                            Image(uiImage: uiImage).resizable().rotationEffect(uiImage.size.height > uiImage.size.width ? .degrees(-90) : .degrees(0))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .cornerRadius(12)
                        }
                    }
                } else {
                    Image(systemName: "square.and.arrow.up").resizable().scaledToFit().frame(width: 24).foregroundStyle(Color(.onSurface))
                    Text("Sube tu imagen aquí").font(.system(size: 12)).foregroundStyle(Color(.onSurface))
                    PhotosPicker(selection: $vm.selectedItem, matching: .images){
                        Text("Navegar")
                                            .padding()
                                            .background(Color(.primary))
                                            .foregroundStyle(Color(.onPrimary))
                                            .cornerRadius(12)
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: 212).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.primary), style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [2, 3])))
            
            ZStack{
                
            }.frame(height: 32)
            
            Button(action: {}){
                Text("Comenzar").font(.system(size: 16, weight: Font.Weight.semibold))
            }.padding().frame(maxWidth: .infinity).background(vm.selectedImage != nil ? Color(.primary) : Color(.onSurface).opacity(0.1)).foregroundStyle(Color(vm.selectedItem != nil ? .onPrimary : .onSurface)).cornerRadius(12)
            
            
            
            Spacer()
        }.frame(maxHeight: .infinity)
        .padding().background(Color(.surface))
    }
}

#Preview {
    ContentView()
}
