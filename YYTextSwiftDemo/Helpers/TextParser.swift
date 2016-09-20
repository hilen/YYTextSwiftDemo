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
    class func parseText(_ text: String, font: UIFont) -> NSMutableAttributedString? {
        if text.characters.count == 0 {
            return nil
        }
        
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedText.yy_font = font
        attributedText.yy_color = UIColor.black
        
        //匹配电话
        self.enumeratePhoneParser(attributedText)
        //匹配 URL
        self.enumerateURLParser(attributedText)
        //匹配 [表情]
        self.enumerateEmotionParser(attributedText, fontSize: font.pointSize)
        
        return attributedText
    }
    
    /**
     匹配电话
     
     - parameter attributedText: 富文本
     */
    fileprivate class func enumeratePhoneParser(_ attributedText: NSMutableAttributedString) {
        let phonesResults = TextParseHelper.regexPhoneNumber.matches(
            in: attributedText.string,
            options: [.reportProgress],
            range: attributedText.yy_rangeOfAll()
        )
        for phone: NSTextCheckingResult in phonesResults {
            if phone.range.location == NSNotFound && phone.range.length <= 1 {
                continue
            }
            
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, at: UInt(phone.range.location)) == nil) {
                attributedText.yy_setColor(UIColor.yellow, range: phone.range)
                let highlight = YYTextHighlight()
                let stringRange = attributedText.string.range(from:phone.range)!
                highlight.userInfo = [kSpeedChatTextKeyPhone : attributedText.string.substring(with: stringRange)]
                attributedText.yy_setTextHighlight(highlight, range: phone.range)
            }
        }
    }

    /**
     匹配 URL
     
     - parameter attributedText: 富文本
     */
    fileprivate class func enumerateURLParser(_ attributedText: NSMutableAttributedString) {
        let URLsResults = TextParseHelper.regexURLs.matches(
            in: attributedText.string,
            options: [.reportProgress],
            range: attributedText.yy_rangeOfAll()
        )
        for URL: NSTextCheckingResult in URLsResults {
            if URL.range.location == NSNotFound && URL.range.length <= 1 {
                continue
            }
            
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, at: UInt(URL.range.location)) == nil) {
                attributedText.yy_setColor(UIColor.yellow, range: URL.range)
                let highlight = YYTextHighlight()
                let stringRange = attributedText.string.range(from: URL.range)!
                highlight.userInfo = [kSpeedChatTextKeyURL : attributedText.string.substring(with: stringRange)]
                attributedText.yy_setTextHighlight(highlight, range: URL.range)
            }
        }
    }
    
    /**
     /匹配 [表情]
     
     - parameter attributedText: 富文本
     - parameter fontSize:       字体大小
     */
    fileprivate class func enumerateEmotionParser(_ attributedText: NSMutableAttributedString, fontSize: CGFloat) {
        let emoticonResults = TextParseHelper.regexEmotions.matches(
            in: attributedText.string,
            options: [.reportProgress],
            range: attributedText.yy_rangeOfAll()
        )
        var emoClipLength: Int = 0
        for emotion: NSTextCheckingResult in emoticonResults {
            if emotion.range.location == NSNotFound && emotion.range.length <= 1 {
                continue
            }
            var range: NSRange  = emotion.range
            range.location -= emoClipLength
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, at: UInt(range.location)) != nil) {
                continue
            }
            if (attributedText.yy_attribute(YYTextAttachmentAttributeName, at: UInt(range.location)) != nil) {
                continue
            }
            
            //这里写死了一个表情
            let _ = attributedText.string.substring(with: attributedText.string.range(from:range)!)
//            let imagePath = "111111111111,表情路径"
//            print("emotionString，imagePath：\(emotionString,imagePath)")
            guard let image = UIImage(named: "dribbble64_imageio") else {
                continue
            }
            
            let emoText = NSMutableAttributedString.yy_attachmentString(withEmojiImage: image, fontSize: fontSize)
            attributedText.replaceCharacters(in: range, with: emoText!)
            
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
            let regularExpression = try! NSRegularExpression(pattern: "\\[[^\\[\\]]+?\\]", options: [.caseInsensitive])
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
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            return regularExpression
        }
    }
    
    /**
     正则：匹配 7-25 位的数字, 010-62104321, 0373-5957800, 010-62104321-230
     */
    class var regexPhoneNumber: NSRegularExpression {
        get {
            let regex = "([\\d]{7,25}(?!\\d))|((\\d{3,4})-(\\d{7,8}))|((\\d{3,4})-(\\d{7,8})-(\\d{1,4}))"
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            return regularExpression
        }
    }
}


//http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index
private extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = range.lowerBound.samePosition(in: utf16view)
        let to = range.upperBound.samePosition(in: utf16view)
        return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from),
                           utf16view.distance(from: from, to: to))
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}





