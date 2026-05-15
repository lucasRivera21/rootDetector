//
//  ContentView.swift
//  rootDetector
//
//  Created by Lucas Rivera on 14/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack() {
            Text("Detector de raices").font(.system(size: 20, weight: Font.Weight.semibold)).foregroundStyle(Color(.onSurface))
            
            ZStack{
                
            }.frame(height: 80)
            
            VStack(spacing: 16){
                Image(systemName: "square.and.arrow.up").resizable().scaledToFit().frame(width: 24).foregroundStyle(Color(.onSurface))
                Text("Sube tu imagen aquí").font(.system(size: 12)).foregroundStyle(Color(.onSurface))
                Button(action: {}){
                    Text("Navegar").font(.system(size: 14, weight: Font.Weight.semibold))
                }.padding().background(Color(.primary)).foregroundStyle(Color(.onPrimary)).cornerRadius(12)
            }.frame(maxWidth: .infinity, maxHeight: 212).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.primary), style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [2, 3])))
            
            ZStack{
                
            }.frame(height: 32)
            
            Button(action: {}){
                Text("Comenzar").font(.system(size: 16, weight: Font.Weight.semibold))
            }.padding().frame(maxWidth: .infinity).background(Color(.primary)).foregroundStyle(Color(.onPrimary)).cornerRadius(12)
            
            Spacer()
        }.frame(maxHeight: .infinity)
        .padding().background(Color(.surface))
    }
}

#Preview {
    ContentView()
}
