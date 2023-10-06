//
//  PBBLabelView.swift
//
//
//  Created by Farid Valiyev on 07.08.23.
//

//  MIT License
//
//  Copyright (c) 2023 Farid Valiyev
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

/// Subclass of PBBTipsView with predefined and customizable style
///
///
/// When adding a button to your interface, perform the following actions:
///
/// * Set the style of the button at creation time.
/// * Supply a title string or image; size the button appropriately for your content.
/// * Connect one or more action methods to the button.
/// * Provide accessibility information and localized strings.
///
/// - Note: PBBTipsView is optimized for looking as expected with minimum effort at the `height` of 72.0 pt.
///
/// However feel free to customize it.
///
public class PBBTipsView: UIView {
    
    public enum PBBTipsType {
        case left(localizedText: String)
        case right(localizedText: String)
        case topLeft(localizedText: String)
        case topCenter(localizedText: String)
        case topRight(localizedText: String)
        case bottomLeft(localizedText: String)
        case bottomCenter(localizedText: String)
        case bottomRight(localizedText: String)
    }
    
}
