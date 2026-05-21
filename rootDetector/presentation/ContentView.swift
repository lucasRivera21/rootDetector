//
//  ContentView.swift
//  rootDetector
//
//  Created by Lucas Rivera on 14/05/26.
//

import SwiftUI
import _PhotosUI_SwiftUI
import Charts

struct ContentView: View {
    @State var vm = ContentViewModel()
    
    var body: some View {
        ScrollView {
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
                    
                }.frame(maxWidth: .infinity, minHeight: 212).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(vm.arucoDontFound ? .error : .primary), style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [2, 3])))
                
                
                if(vm.arucoDontFound){
                    VStack(alignment: HorizontalAlignment.leading) {
                        
                        Text("Aruco no encontrado").foregroundStyle(Color(.error)).font(.system(size: 12))
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                
                ZStack{
                    
                }.frame(height: 32)
                
                Button(action: {
                    Task{
                        await vm.onSendImage()
                    }
                }){
                    if(vm.isLoading){
                        ProgressView()
                    } else {
                        Text("Comenzar").font(.system(size: 16, weight: Font.Weight.semibold))
                    }
                    
                }.padding().frame(maxWidth: .infinity).background(vm.selectedImage != nil ? Color(.primary) : Color(.onSurface).opacity(0.1)).foregroundStyle(Color(vm.selectedItem != nil ? .onPrimary : .onSurface)).cornerRadius(12)
                
                if let model = vm.rootDetectedModel {
                    VStack{
                        Spacer(minLength: 28)
                        HStack {
                            Text("Resultados").font(.system(size: 20, weight: Font.Weight.semibold)).foregroundStyle(.onSurface)
                            Spacer()
                        }
                        
                        Spacer(minLength: 24)
                        
                        HStack(spacing: 32){
                            ResultCard(title: "Primaria", value: model.primary.description, bgColor: .customGreen)
                            
                            ResultCard(title: "Secundaria", value: model.secondary.description, bgColor: .customBlue)
                        }
                        
                        Spacer(minLength: 16)
                        
                        HStack(spacing: 32){
                            ResultCard(title: "Terciaria", value: model.tertiary.description, bgColor: .customYellow)
                            
                            ResultCard(title: "Cuaternaria", value: model.quaternary.description, bgColor: .customRed)
                        }
                        
                        Spacer(minLength: 40)
                        
                        ZStack {
                            Circle()
                                .stroke(
                                    Color(.systemGray5),
                                    style: StrokeStyle(lineWidth: 24, lineCap: .round)
                                )
                            
                            Circle()
                                .trim(from: 0.0, to: CGFloat(min(model.percentage, 1.0)))
                                .stroke(
                                    Color.purple,
                                    style: StrokeStyle(lineWidth: 24, lineCap: .round)
                                )
                                .rotationEffect(Angle(degrees: -90))
                                .animation(.easeOut(duration: 1.0), value: model.percentage)
                            
                            VStack(spacing: 4) {
                                Text("% Raíces")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundStyle(Color(.onSurface))
                                
                                Text("\(Int(model.percentage * 100))%")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundStyle(Color(.secondaryLabel))
                            }
                        }
                        .frame(width: 200, height: 200)
                        
                        Spacer(minLength: 32)
                        
                        Image(uiImage: model.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit).clipped().cornerRadius(12)
                    }
                }
                
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding().background(Color(.surface)).alert("Error del servidor", isPresented: $vm.showAlert, actions: {Button(action: {vm.onChangeShowAlert()}, label: {Text("Ok")})})
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.surface)
    }
}

#Preview {
    ContentView()
}
