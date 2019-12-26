
import UIKit

class StringSize: NSObject {
    
    
    class func estimateFrameForTitleText(_ text: String, width: Double, height: Double, fontSize: CGFloat) -> CGRect
    {
        let size = CGSize(width: width, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: fontSize)]), context: nil)
    }
    
    class func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]?
    {
        guard let input = input else { return nil }
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }
    
    class func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String
    {
        return input.rawValue
    }
    
}

