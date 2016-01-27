//
//  TextParser.swift
//  YYTextSwiftDemo
//
//  Created by Hilen on 1/22/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

import Foundation
import YYText

public let kSpeedChatTextKeyPhone = "phone"
public let kSpeedChatTextKeyURL = "URL"

class TextParser: NSObject {
    class func parseText(text: String, font: UIFont, fontSize: CGFloat) -> NSMutableAttributedString? {
        if text.characters.count == 0 {
            return nil
        }
        
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedText.yy_font = font
        attributedText.yy_color = UIColor.blackColor()
        
        //匹配电话
        self.enumeratePhoneParser(attributedText)
        //匹配 URL
        self.enumerateURLParser(attributedText)
        //匹配 [表情]
        self.enumerateEmotionParser(attributedText, fontSize: fontSize)
        
        return attributedText
    }
    
    /**
     匹配电话
     
     - parameter attributedText: 富文本
     */
    private class func enumeratePhoneParser(attributedText: NSMutableAttributedString) {
        let phonesResults = TextParseHelper.regexPhoneNumber.matchesInString(
            attributedText.string,
            options: [.ReportProgress],
            range: attributedText.yy_rangeOfAll()
        )
        for phone: NSTextCheckingResult in phonesResults {
            if phone.range.location == NSNotFound && phone.range.length <= 1 {
                continue
            }
            
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, atIndex: UInt(phone.range.location)) == nil) {
                attributedText.yy_setColor(UIColor.yellowColor(), range: phone.range)
                let highlight = YYTextHighlight()
                let stringRange = attributedText.string.RangeFromNSRange(phone.range)!
                highlight.userInfo = [kSpeedChatTextKeyPhone : attributedText.string.substringWithRange(stringRange)]
                attributedText.yy_setTextHighlight(highlight, range: phone.range)
            }
        }
    }

    /**
     匹配 URL
     
     - parameter attributedText: 富文本
     */
    private class func enumerateURLParser(attributedText: NSMutableAttributedString) {
        let URLsResults = TextParseHelper.regexURLs.matchesInString(
            attributedText.string,
            options: [.ReportProgress],
            range: attributedText.yy_rangeOfAll()
        )
        for URL: NSTextCheckingResult in URLsResults {
            if URL.range.location == NSNotFound && URL.range.length <= 1 {
                continue
            }
            
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, atIndex: UInt(URL.range.location)) == nil) {
                attributedText.yy_setColor(UIColor.yellowColor(), range: URL.range)
                let highlight = YYTextHighlight()
                let stringRange = attributedText.string.RangeFromNSRange(URL.range)!
                highlight.userInfo = [kSpeedChatTextKeyURL : attributedText.string.substringWithRange(stringRange)]
                attributedText.yy_setTextHighlight(highlight, range: URL.range)
            }
        }
    }
    
    /**
     /匹配 [表情]
     
     - parameter attributedText: 富文本
     - parameter fontSize:       字体大小
     */
    private class func enumerateEmotionParser(attributedText: NSMutableAttributedString, fontSize: CGFloat) {
        let emoticonResults = TextParseHelper.regexEmotions.matchesInString(
            attributedText.string,
            options: [.ReportProgress],
            range: attributedText.yy_rangeOfAll()
        )
        var emoClipLength: Int = 0
        for emotion: NSTextCheckingResult in emoticonResults {
            if emotion.range.location == NSNotFound && emotion.range.length <= 1 {
                continue
            }
            var range: NSRange  = emotion.range
            range.location -= emoClipLength
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, atIndex: UInt(range.location)) != nil) {
                continue
            }
            if (attributedText.yy_attribute(YYTextAttachmentAttributeName, atIndex: UInt(range.location)) != nil) {
                continue
            }
            
            //这里写死了一个表情
            let _ = attributedText.string.substringWithRange(attributedText.string.RangeFromNSRange(range)!)
//            let imagePath = "111111111111,表情路径"
//            print("emotionString，imagePath：\(emotionString,imagePath)")
            guard let image = UIImage(named: "dribbble64_imageio") else {
                continue
            }
            
            let emoText = NSMutableAttributedString.yy_attachmentStringWithEmojiImage(image, fontSize: fontSize)
            attributedText.replaceCharactersInRange(range, withAttributedString: emoText)
            
            emoClipLength += range.length - 1
        }
    }
}


private class TextParseHelper {
    /**
     正则：匹配 [哈哈] [笑哭。。] 表情
     */
    class var regexEmotions: NSRegularExpression {
        get {
            let regularExpression = try! NSRegularExpression(pattern: "\\[[^\\[\\]]+?\\]", options: [.CaseInsensitive])
            return regularExpression
        }
    }
    
    /**
     正则：匹配 www.a.com 或者 http://www.a.com 的类型
     
     ref: http://stackoverflow.com/questions/3809401/what-is-a-good-regular-expression-to-match-a-url
     */
    class var regexURLs: NSRegularExpression {
        get {
            let regex: String = "([hH]ttp[s]{0,1})://[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)|[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)"
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
            return regularExpression
        }
    }
    
    /**
     正则：匹配 7-25 位的数字, 010-62104321, 0373-5957800, 010-62104321-230
     */
    class var regexPhoneNumber: NSRegularExpression {
        get {
            let regex = "([\\d]{7,25}(?!\\d))|((\\d{3,4})-(\\d{7,8}))|((\\d{3,4})-(\\d{7,8})-(\\d{1,4}))"
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
            return regularExpression
        }
    }
}


private extension String {
    func NSRangeFromRange(range : Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.startIndex, within: utf16view)
        let to = String.UTF16View.Index(range.endIndex, within: utf16view)
        return NSMakeRange(utf16view.startIndex.distanceTo(from), from.distanceTo(to))
    }
    
    func RangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
                return from ..< to
        }
        return nil
    }
}





