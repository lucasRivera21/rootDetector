//
//  ResultCard.swift
//  rootDetector
//
//  Created by Lucas Rivera on 21/05/26.
//

import SwiftUI

struct ResultCard: View {
    let title: String
    let value: String
    let bgColor: Color
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 4){
            Text(title).font(.system(size: 12)).foregroundStyle(Color(.white))
            Text(value).font(.system(size: 16)).foregroundStyle(Color(.white))
        }.padding().frame(maxWidth: .infinity, alignment: .leading).background(bgColor).cornerRadius(8)
    }
}

#Preview {
    ResultCard(title: "Secundaria", value: "100", bgColor: .error)
}
