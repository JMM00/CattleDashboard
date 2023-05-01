//
//  NSImage+Extension.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/30.
//

import Cocoa

extension NSImage {
    typealias UIImage = NSImage
    
    var cgImage: CGImage? {
        var proposedRect = CGRect(origin: .zero, size: size)

        return cgImage(forProposedRect: &proposedRect,
                       context: nil,
                       hints: nil)
    }

    convenience init?(named name: String) {
        self.init(named: Name(name))
    }
}
