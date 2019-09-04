//
//  UIImageHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/20.
//

import Foundation

//Mask
extension UIImage {
    /**
     ItemHelper Extension
     ```
     Change image tint
     ```
     */
    
    public func mask(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        let rect = CGRect(origin: .zero, size: size)
        color.setFill()
        self.draw(in: rect)
        context.setBlendMode(.sourceIn)
        context.fill(rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
}

//Crop
extension UIImage {
    /**
     ItemHelper Extension
     ```
     Crop Image on rect
     ```
     */
    public func crop(rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        let drawRect = CGRect(x: -rect.origin.x, y: -rect.origin.y, width: self.size.width, height: self.size.height)
        context?.clip(to: CGRect(origin: .zero, size: rect.size))
        self.draw(in: drawRect)
        let sub = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return sub ?? nil
    }
}

//Resize
extension UIImage {
    /**
     ItemHelper Extension
     ```
     Resize image with rate
     ```
     */
    public func resizeImage(ratio: CGFloat) -> UIImage {
        let size = self.size
        return self.resizeImage(targetSize: CGSize(width: size.width*ratio, height: size.height*ratio))
    }
    
    /**
     ItemHelper Extension
     ```
     Resize image with size
     ```
     */
    public func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
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
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

//QrCode
extension UIImage {
    /**
     ItemHelper Extension
     ```
     Qrcode Image to string
     ```
     */
    public func qrCodeValue() -> String {
        if let ciImage = CIImage(image: self) {
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
    
    static func gradient(frame: CGRect, colors: [UIColor]) -> UIImage? {
        let l = CAGradientLayer()
        l.frame = frame
        l.colors = colors.map({ $0.cgColor })
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(l.frame.size)
        l.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
}
