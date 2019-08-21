//
//  UIImageHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/20.
//

import Foundation
public class ImageHelper {
    unowned let base: UIImage
    public init(_ base: UIImage) {
        self.base = base
    }
}

//Mask
extension ImageHelper {
    func mask(color: UIColor) -> UIImage {
        let maskImage = self.base.cgImage!
        let width = self.base.size.width
        let height = self.base.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return self.base
        }
    }
}

//Crop
extension ImageHelper {
    public func crop(rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        let drawRect = CGRect(x: -rect.origin.x, y: -rect.origin.y, width: self.base.size.width, height: self.base.size.height)
        context?.clip(to: CGRect(origin: .zero, size: rect.size))
        self.base.draw(in: drawRect)
        let sub = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return sub ?? nil
    }
}

//Resize
extension ImageHelper {
    public func resizeImage(ratio: CGFloat) -> UIImage {
        let size = self.base.size
        return self.resizeImage(targetSize: CGSize(width: size.width*ratio, height: size.height*ratio))
    }
    
    public func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.base.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.base.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

//QrCode
extension ImageHelper {
    public func qrCodeValue() -> String {
        if let ciImage = CIImage(image: self.base) {
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
                
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            }else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
            return (features?.first as? CIQRCodeFeature)?.messageString ?? ""
        }
        
        return ""
    }
    
    public func qrCodeImage(size: CGSize) -> (image: UIImage, imageValue: String)? {
        let value = self.qrCodeValue()
        guard let img = value.qrCIImage, !value.isEmpty else {
            return nil
        }
        let width = img.extent.width
        let smallestOutputExtent = (size.width < size.height) ? size.width : size.height
        let scaleFactor = smallestOutputExtent / width
        let scaledImage = img.transformed(
            by: CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
        return (UIImage(ciImage: scaledImage, scale: UIScreen.main.scale, orientation: .down), value)
    }
}
