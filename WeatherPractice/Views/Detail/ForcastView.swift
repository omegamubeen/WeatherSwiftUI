//
//  ForcastView.swift
//  WeatherPractice
//
//  Created by Mubeen Khalid on 19/12/2022.
//

import SwiftUI

struct ForcastView: View {
    
    var bottomSheetTranslationProrated: CGFloat = 1
    @State var selection = 0
    
    var body: some View {
        ScrollView {
            SegmentController(selection: $selection)
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44),
                     color: Color.bottomSheetBorderMiddle,
                     lineWidth: 1,
                     offsetX: 0,
                     offsetY: 1,
                     blur: 0,
                     blendMode: .overlay,
                     opacity: 1 - bottomSheetTranslationProrated)
        .overlay {
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ForcastView_Previews: PreviewProvider {
    static var previews: some View {
        ForcastView()
            .background(Color.background)
            .preferredColorScheme(.dark)
    }
}
