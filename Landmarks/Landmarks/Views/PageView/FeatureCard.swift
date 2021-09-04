//
//  FeatureCard.swift
//  Landmarks
//
//  Created by Chen Xiaohan on 2021/7/11.
//

import SwiftUI

struct FeatureCard: View {
    var landmark: Landmark
    
    var body: some View {
        landmark.featureImage?
            .resizable()
            .aspectRatio(3 / 2,contentMode: .fit)
            .overlay(TextOverLay(landmark: landmark))
    }
}

struct TextOverLay: View {
    var landmark: Landmark
    
    var gradient: LinearGradient{
        LinearGradient(
            gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View{
        ZStack(alignment: .bottomLeading){
            Rectangle().fill(gradient)
            VStack(alignment: .leading){
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(landmark: ModelData().features[0])
    }
}
