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
    @State var hasDragged: Bool = false
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
                    
                    Image("Background").resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationPorated * imageOffset)
                    
                    Image("House").frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 280)
                        .offset(y: -bottomSheetTranslationPorated * imageOffset)
                    
                    VStack(spacing: -5 * (1  - bottomSheetTranslationPorated)) {
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                            Text("H:20°    L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationPorated)
                        }
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranslationPorated * 46)
                    
                    //MARK: BottomSheet
                    BottomSheetView(position: $bottomSheetPosition) {
//                        Text(bottomSheetTranslationPorated.formatted())
                    } content: {
                        ForcastView(bottomSheetTranslationProrated: bottomSheetTranslationPorated)
                    }.onBottomSheetDrag { position in
                        bottomSheetTranslation = position / screenHeight
                        
                        withAnimation(.easeInOut) {
                            if bottomSheetPosition == BottomSheetPosition.top {
                                hasDragged = true
                            } else {hasDragged = false}
                        }
                    }
                    
                    //MARK: TabBar
                    TabBar(action: {bottomSheetPosition = .top})
                        .offset(y: bottomSheetTranslationPorated * 115)
                }
            }
        }.navigationBarHidden(true)
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + (hasDragged ? " | " : "\n ") + "Mostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: (hasDragged ? 20 : 96), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationPorated)
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
