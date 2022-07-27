//
//  PresentationDetent+Extension.swift
//  Test_SwiftUI_PresentationContainers_Detents
//
//  Created by Jaroslaw Trojanowicz on 27/07/2022.
//

import SwiftUI

// For presenting in a picker
extension PresentationDetent: CustomStringConvertible {
    public var description: String {
        switch self {
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        default:
            return "n/a"
        }
    }
}
