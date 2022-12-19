//
//  HomeView.swift
//  WeatherPractice
//
//  Created by Mubeen Khalid on 23/11/2022.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 //702/844
    case middle = 0.385 //325/844
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    
    
    var bottomSheetTranslationPorated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) /
        (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                
                ZStack {
                    Color.background
                        .ignoresSafeArea()
                    
                    Image("Background").resizable().ignoresSafeArea().offset(y: -bottomSheetTranslationPorated * imageOffset)
                    
                    Image("House").frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 280).offset(y: -bottomSheetTranslationPorated * imageOffset)
                    
                    VStack {
                        Text("Montreal").font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                            Text("H:20°    L:18°").font(.title3.weight(.semibold))
                        }
                        Spacer()
                    }
                    .padding(.top, 51).offset(y: -bottomSheetTranslationPorated * imageOffset)
                    
                    BottomSheetView(position: $bottomSheetPosition) {
                        Text(bottomSheetTranslationPorated.formatted())
                    } content: {
                        ForcastView()
                    }.onBottomSheetDrag { position in
                        bottomSheetTranslation = position / screenHeight
                    }
                    
                    
                    TabBar(action: {bottomSheetPosition = .top})
                }
            }
        }.navigationBarHidden(true)
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + "\n " + "Mostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        } 

        
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().preferredColorScheme(.dark)
    }
}
