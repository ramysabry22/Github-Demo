
import UIKit
import SVProgressHUD


extension UIView {
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    func makeShadowWithCornerRadius(radius: CGFloat)
    {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
        layer.cornerRadius = radius
    }
    
    
    func dropShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.1)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
}


@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
extension UITextField
{
    func setErrorStyle()
    {
        self.layer.cornerRadius = 20
        //   self.layer.borderColor = UIColor.red.cgColor
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.red.cgColor
        
    }
    func removeErrorStyle()
    {
        self.layer.cornerRadius = 20
        //   self.layer.borderColor = UIColor.red.cgColor
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}



extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}




extension UIColor {
    
    static func mainAppColor() -> UIColor {
        return UIColor(hexString: "F38300")
    }
    
    
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
    
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension UIImage
{
    func resize() -> UIImage {
        var actualHeight = Float(self.size.height)
        var actualWidth = Float(self.size.width)
        let maxHeight: Float = 800.0
        let maxWidth: Float = 800.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 1.0
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!) ?? UIImage()
    }
}



extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}








extension String
{
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func base64ToImage() -> UIImage?
    {
        if  self.count > 0
        {
            if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
                return image
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func base64ToImageWIthPreficRemove() -> UIImage?
    {
        let result = self.removeBase64Prefix()
        if  result.count > 0
        {
            if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
                return image
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func removeBase64Prefix() -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: "data:image\\/([a-zA-Z]*);base64,([^\\\"]*)")
            let results = regex.matches(in: self, range:  NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    
    
    func isNumeric() -> Bool {
        guard !self.isEmpty else { return false }
        return !self.contains { Int(String($0)) == nil }
    }
    
    func IsValidString() -> Bool {
        if trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }else { return true }
    }
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidStringLenght(Length: Int) -> Bool {
        let string = trimmingCharacters(in: .whitespaces)
        if string.count >= Length { return true}
        else { return false }
    }
    
    func isValidStringLimitedLenght(Length: Int) -> Bool {
        let string = trimmingCharacters(in: .whitespaces)
        if string.count == Length { return true}
        else { return false }
    }
    
    func isStringHaveCapitalLetter() -> Bool {
        let regex = try! NSRegularExpression(pattern: ".*[A-Z]+.*")
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}







extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        
        
        if let nav = base as? UINavigationController {
            
            return topViewController(base: nav.visibleViewController)
            
        }
        
        
        
        if let tab = base as? UITabBarController {
            
            let moreNavigationController = tab.moreNavigationController
            
            
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                
                return topViewController(base: top)
                
            } else if let selected = tab.selectedViewController {
                
                return topViewController(base: selected)
                
            }
            
        }
        
        
        
        if let presented = base?.presentedViewController
        {
            return topViewController(base: presented)
        }
        
        return base
        
    }
    
}





extension SVProgressHUD {
    static func setupView(){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
        //        SVProgressHUD.setForegroundColor(UIColor.white)
        //        SVProgressHUD.setBackgroundColor(UIColor.mainAppColor())
        //        SVProgressHUD.setRingRadius(25)
        //        SVProgressHUD.setRingThickness(5)
        //        SVProgressHUD.setCornerRadius(25)
        //        SVProgressHUD.setMinimumSize(CGSize(width: 30, height: 30))
        //     SVProgressHUD.show()
    }
}



extension UIImage {
    
    public var base64: String {
        return self.jpegData(compressionQuality: 1.0)!.base64EncodedString()
    }
    
    convenience init?(base64: String, withPrefix: Bool) {
        var finalData: Data?
        
        if withPrefix {
            guard let url = URL(string: base64) else { return nil }
            finalData = try? Data(contentsOf: url)
        } else {
            finalData = Data(base64Encoded: base64)
        }
        
        guard let data = finalData else { return nil }
        self.init(data: data)
    }
    
    
    var pngRepresentationData: Data? {
        let compressedImage = self.resized(withPercentage: 0.7)
        return compressedImage?.pngData()
    }
    
    var jpegRepresentationData: Data? {
        return self.jpegData(compressionQuality: 0.7)
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

