//
//  StringHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/20.
//

import Foundation

// Qrcode
extension String {
    /**
     ItemHelper Extension
     ```
     Qrcode String to image with size
     ```
     */
    public func qrCodeImage(size: CGSize) -> UIImage? {
        guard let img = self.qrCIImage, self.count > 0 else {
            return nil
        }
        let width = img.extent.width
        let smallestOutputExtent = (size.width < size.height) ? size.width : size.height
        let scaleFactor = smallestOutputExtent / width
        let scaledImage = img.transformed(
            by: CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
        return UIImage(ciImage: scaledImage, scale: UIScreen.main.scale, orientation: .down)
    }
    /**
     ItemHelper Extension
     ```
     Qrcode String to image
     ```
     */
    public var qrCodeImage: UIImage? {
        get {
            guard let output = self.qrCIImage else {
                return nil
            }
            return UIImage(ciImage: output)
        }
    }
    
    var qrCIImage: CIImage? {
        let data = self.data(using: .utf8)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        guard let output = filter?.outputImage else {
            return nil
        }
        
        let scale = UIScreen.main.scale
        let reset = output.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        return reset
    }
}

// Bound
extension String {
    func get(index: Int) -> String.Index {
        return self.index(startIndex, offsetBy: index)
    }
    
    
    /**
     ItemHelper Extension
     ```
     Get character index i
     ```
     */
    public subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    /**
     ItemHelper Extension
     ```
     Get sub string
     ```
     */
    public subscript (safe range: CountableClosedRange<Int>) -> String {
        if range.lowerBound < 0 || range.upperBound >= self.count {
            return ""
        }
        return self[range.lowerBound..<range.upperBound+1]
    }
    
    /**
     ItemHelper Extension
     ```
     Get sub string
     ```
     */
    public subscript (r: Range<Int>) -> String {
        let start = self.get(index: r.lowerBound)
        let end = self.get(index: r.upperBound)
        return String(self[start..<end])
    }
    
    /**
     ItemHelper Extension
     ```
     Get sub string
     ```
     */
    public func subStrings(_ value: String) -> [NSRange] {
        var range = [NSRange]()
        var index = 0
        while index <= self.count {
            let r = NSString(string: self[index..<self.count]).range(of: value)
            if r.length > 0 {
                range.append(NSRange.init(location: index+r.location, length: r.length))
                index += r.length+r.location
                
            } else {
                index += 1
            }
        }
        return range
    }
}

