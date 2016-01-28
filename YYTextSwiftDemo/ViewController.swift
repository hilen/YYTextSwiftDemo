//
//  ViewController.swift
//  YYTextSwiftDemo
//
//  Created by Hilen on 1/27/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

import UIKit
import YYText

private let fontSize:CGFloat = 16

class ViewController: UIViewController {
    @IBOutlet weak var leftYYLabel: YYLabel!
    @IBOutlet weak var rightUILabel: UILabel!
    @IBOutlet weak var contentScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let maxWidth: CGFloat = 140
        let targetSize = CGSizeMake(maxWidth, CGFloat.max)
        let targetFont: UIFont = UIFont.systemFontOfSize(fontSize)
//        let testString: String = " 😯这是一段测试文字，this is test text. 😷🤖👹🤖👽😾👊🏼🏛🍜🍠◽️☆_🔛🔲🔊🔔🔇🇫🇯🇬🇲☆入:--1😯狗狗不理😷🤖👹🤖👽😾👊🏼🏛🍜🍠◽️☆_🔛🔲🔊🔔🔇🇫🇯🇬🇲☆入:--1😯狗狗不理😷🤖👹🤖👽😾👊🏼🏛🍜🍠◽️☆_🔛🔲🔊🔔🔇🇫🇯🇬🇲☆入:--1😯狗狗不理😷🤖👹🤖👽😾👊🏼🏛🍜🍠◽️☆_🔛🔲🔊🔔🔇🇫🇯🇬🇲☆入:--1😯狗狗不理😷🤖👹🤖👽😾👊🏼🏛🍜🍠◽️☆_🔛🔲🔊🔔🔇🇫🇯🇬🇲☆入:--1😯狗狗不理😷🤖👹🤖👽😾👊🏼🏛🍜🍠◽️☆_🔛🔲🔊🔔🔇🇫🇯🇬🇲☆入:--1😯狗狗不理😷🤖👹🤖👽😾👊🏼🏛🍜🍠◽️☆_🔛🔲🔊🔔🔇🇫🇯🇬🇲☆入:--2222"
        let testString: String = "这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,[呵]这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,[呵]这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,[呵]这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,[呵]这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,[呵]这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,[呵]这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,[呵]这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,[呵]这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,这是一段测试的数据，测试富文本高度来使用，因为微信有部分内容，123456789 所以就问问你那边做到啥成都, ios uilabel lineheight value,ios uilabel http://www.baidu.com lineheight 010-62998383 value,ios uilabel [呵呵]lineheight value,[呵]4"
        
        self.setupYYLabel(testString, targetSize: targetSize, font: targetFont)
        self.setupUILabel(testString, targetSize: targetSize, font: targetFont, maxWidth: maxWidth)
        self.contentScrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, self.rightUILabel.height + 200)
        self.contentScrollView.size = UIScreen.mainScreen().bounds.size
    }
    
    func setupYYLabel(text: String, targetSize: CGSize, font: UIFont) {
        //解析的文字
        let attributedString = TextParser.parseText(text, font: font)!
        //布局
        let modifier = TextLinePositionModifier(font: font)
        
        self.leftYYLabel.attributedText = attributedString
        self.leftYYLabel.debugOption = self.debugYYLabel()
        self.leftYYLabel.numberOfLines = 0
        self.leftYYLabel.linePositionModifier = modifier
        self.leftYYLabel.backgroundColor = UIColor ( red: 0.7799, green: 0.7799, blue: 0.7799, alpha: 1.0 )
        self.leftYYLabel.textVerticalAlignment = YYTextVerticalAlignment.Top
        self.leftYYLabel.lineBreakMode = .ByWordWrapping
        self.leftYYLabel.displaysAsynchronously = true
        self.leftYYLabel.ignoreCommonProperties = true
        self.leftYYLabel.highlightTapAction = ({containerView, text, range, rect in
            print("highlightTapAction taped")
        })
        
        let textContainer: YYTextContainer = YYTextContainer()
        textContainer.size = targetSize
        textContainer.linePositionModifier = modifier
        textContainer.maximumNumberOfRows = 0
        
        let textLayout = YYTextLayout(container: textContainer, text: attributedString)
        self.leftYYLabel.textLayout = textLayout
        self.leftYYLabel.width = textLayout.textBoundingSize.width
        
        let contentHeight = modifier.heightForLineCount(Int(textLayout.rowCount))
        self.leftYYLabel.height = contentHeight
    }

    func setupUILabel(text: String, targetSize: CGSize, font: UIFont, maxWidth: CGFloat) {
        self.rightUILabel.font = font
        self.rightUILabel.text = text
        self.rightUILabel.numberOfLines = 0
        self.rightUILabel.lineBreakMode = .ByWordWrapping
        self.rightUILabel.backgroundColor = UIColor.yellowColor()
        self.rightUILabel.setFrameWithString(text, width: maxWidth)
        print("rightUILabel:\(self.rightUILabel)")
    }

    func debugYYLabel() -> YYTextDebugOption {
        let debugOptions = YYTextDebugOption()
        debugOptions.baselineColor = UIColor.redColor();
        debugOptions.CTFrameBorderColor = UIColor.redColor();
        debugOptions.CTLineFillColor = UIColor ( red: 0.0, green: 0.463, blue: 1.0, alpha: 0.18 )
        debugOptions.CGGlyphBorderColor = UIColor ( red: 0.9971, green: 0.6738, blue: 1.0, alpha: 0.360964912280702 )
        return debugOptions
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

