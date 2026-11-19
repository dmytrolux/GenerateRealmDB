//
//  SizeHelper.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 19.11.2026.
//

import UIKit
extension BinaryFloatingPoint {
    func proportionalWidth() -> CGFloat {
        
        let wScreen = 375
        let value = CGFloat(wScreen) / CGFloat(self)
        let widthDevice = UIScreen.main.bounds.size.width //'main' was deprecated in iOS 26.0: Use a UIScreen instance found through context instead (i.e, view.window.windowScene.screen), or for properties like UIScreen.scale with trait equivalents, use a traitCollection found through context.
        return widthDevice / value
    }
    
    func proportionalHeight() -> CGFloat {
        let hScreen = 812
        let value = CGFloat(hScreen) / CGFloat(self)
        let heightDevice = UIScreen.main.bounds.size.height //'main' was deprecated in iOS 26.0: Use a UIScreen instance found through context instead (i.e, view.window.windowScene.screen), or for properties like UIScreen.scale with trait equivalents, use a traitCollection found through context.
        return heightDevice / value
    }

}
