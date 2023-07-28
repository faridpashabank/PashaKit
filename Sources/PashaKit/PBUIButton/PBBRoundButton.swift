//
//  PBBRoundButton.swift
//
//
//  Created by Farid Valiyev on 19.07.23.
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

/// Subclass of UIButton with predefined and customizable style
///
///
/// When adding a button to your interface, perform the following actions:
///
/// * Set the style of the button at creation time.
/// * Supply a title string or image; size the button appropriately for your content.
/// * Connect one or more action methods to the button.
/// * Provide accessibility information and localized strings.
///
/// - Note: PBBRoundButton is optimized for looking as expected with minimum effort at the `height` of 56.0 pt.
///
/// However feel free to customize it.
///
public class PBBRoundButton: UIView {

    public enum PBBRoundButtonType {
        case plain
        case text(String)
        case disabled
    }

    /// Specifies the style of button
    public enum PBBRoundButtonStyle {

        /// A  button with clear background color and PBGreen title color
        ///
        /// By default title color of button will be in PBGreen color. However if theme option is used,
        /// its title color may be PBFauxChestnut depending on returned user type.
        ///
        case plain

        /// A button with 0.1 opacity PBGreen background color and PBGreen title color
        ///
        /// By default background color of button will be in PBGreen color with 0.1 opacity. However if theme option is used,
        /// its background color may be PBFauxChestnut depending on returned user type.
        ///
        case disabled
    }
    
    public enum IconSize {
        case small
        case medium
        case large
    }

    private var seconds: Int = 0
    
    var smallSizeConstraints: [NSLayoutConstraint] = []
    var mediumSizeConstraints: [NSLayoutConstraint] = []
    var largeSizeConstraints: [NSLayoutConstraint] = []
    
    /// Sets the title to use for normal state.
    ///
    /// Since we're using only normal state for UIButton, at the moment PBUIButton also uses only normal state when setting
    /// button title.
    /// For different states use native
    /// ```
    /// func setTitle(_ title: String?, for state: UIControl.State)
    /// ```
    ///
    public var title: String = "" {
        didSet {
            self.titleLabel.text = self.title
        }
    }

    /// Sets the image for displaying on the left side of button.
    ///
    /// By default button will be created with only its title. If you are willing to add
    /// leftImage in future, just set the desired image to this property.
    ///
    public var image: UIImage? {
        didSet {
            self.iconView.image = image
        }
    }

    /// The radius to use when drawing rounded corners for the layer’s background.
    ///
    /// By default it will set 16.0 to corner radius property of button.
    ///
    public var cornerRadius: CGFloat = 12.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }

    /// Button's background color.
    ///
    /// By default button will be created with the background color for selected button style.
    ///
    public var baseBackgroundColor: UIColor = UIColor.Colors.PBGreen {
        didSet {
            self.backgroundColor = self.baseBackgroundColor
        }
    }

    /// The tint color to apply to the button title and image.
    ///
    /// By default button will be created with the tint color for selected button style.
    ///
    public var buttonTintColor: UIColor = UIColor.white {
        didSet {
            self.tintColor = self.buttonTintColor
        }
    }
    
    public var iconBackgroundColor: UIColor = .clear {
        didSet {
            self.iconWrapperView.backgroundColor = self.iconBackgroundColor
        }
    }

    /// The color of button's border.
    ///
    /// By default button will be created with the border color for selected button style.
    ///
    public var borderColor: UIColor = UIColor.Colors.PBGreen {
        didSet {
            switch self.styleOfButton {
            case .plain:
                self.layer.borderColor = UIColor.clear.cgColor
            case .disabled:
                self.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }

    /// The theme for the button's appearance.
    ///
    /// PBUIButton is using theme parameter for defining its color palette for components. These include button's
    /// * Background color
    /// * Border color
    /// * Title color
    /// * Tint color
    ///
    public var theme: PBBUIButtonTheme = .regular {
        didSet {
            self.prepareButtonByStyle()
        }
    }

    private var typeOfButton: PBBRoundButtonType = .plain {
        didSet {
            self.prepareButtonByType()
        }
    }

    /// Specifies style of the button.
    ///
    /// If not specified by outside, PBUIButton will be created with filled style.
    ///
    public var styleOfButton: PBBRoundButtonStyle = .plain {
        didSet {
            self.prepareButtonByStyle()
        }
    }

    public var isDisabled: Bool = false {
        didSet {
            self.makeButton(disabled: self.isDisabled)
        }
    }
    
    public var iconSize: IconSize = .small {
        didSet {
            switch self.iconSize {
            case .small:
                NSLayoutConstraint.activate(self.smallSizeConstraints)
                NSLayoutConstraint.deactivate(self.mediumSizeConstraints)
                NSLayoutConstraint.deactivate(self.largeSizeConstraints)
                self.iconWrapperView.layer.cornerRadius = 12
            case .medium:
                NSLayoutConstraint.deactivate(self.smallSizeConstraints)
                NSLayoutConstraint.activate(self.mediumSizeConstraints)
                NSLayoutConstraint.deactivate(self.largeSizeConstraints)
                self.iconWrapperView.layer.cornerRadius = 28
            case .large:
                NSLayoutConstraint.deactivate(self.smallSizeConstraints)
                NSLayoutConstraint.deactivate(self.mediumSizeConstraints)
                NSLayoutConstraint.activate(self.largeSizeConstraints)
                self.iconWrapperView.layer.cornerRadius = 24
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .darkText
        label.textAlignment = .center
        label.text = self.title

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var iconWrapperView: UIView = {
        let view = UIView()

        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var iconView: UIImageView  = {
        let view = UIImageView()

        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        view.contentMode = .scaleAspectFit

        return view
    }()

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    /// Creates a new button of specified style.
    ///
    /// - Parameters:
    ///    - localizableTitle: Sets the title text for button.
    ///    - styleOfButton: Sets the style of button.
    ///

//    public convenience init(localizableTitle: String, styleOfButton: PBBRoundButtonStyle = .plain) {
////        self.init(type: .plain)
//        self.setupDefaults()
////        self.setTitle(localizableTitle, for: .normal)
//        self.styleOfButton = styleOfButton
//        self.prepareButtonByStyle()
//    }

    public convenience init(typeOfButton: PBBRoundButtonType = .plain) {
        self.init()
//        self.setupDefaults()
        self.typeOfButton = typeOfButton
        self.prepareButtonByType()
        self.setupViews(for: typeOfButton)
    }

//    public convenience init() {
//        self.init(localizableTitle: "")
//    }
    
    private func setupViews(for type: PBBRoundButtonType) {
        
        self.iconWrapperView.addSubview(self.iconView)
        
        self.addSubview(self.iconWrapperView)

        switch type {
        case .plain:
            self.iconWrapperView.layer.cornerRadius = self.iconWrapperView.layer.frame.height / 2
        case .disabled:
            self.iconWrapperView.layer.cornerRadius = 8.0
        case .text:
            print("Text:::")
//            self.iconWrapperView.layer.cornerRadius = self.iconWrapperView.layer.frame.height / 2
            self.addSubview(self.titleLabel)
        }
        
        self.setupConstraints(for: type)
    }
    
    private func setupConstraints(for type: PBBRoundButtonType) {
        switch type {
        case .plain:
            
            NSLayoutConstraint.activate([

//                self.heightAnchor.constraint(equalToConstant: 128.0),
//                self.widthAnchor.constraint(equalToConstant: 128.0),
                
//                self.iconWrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
//                self.iconWrapperView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//
                self.iconView.centerXAnchor.constraint(equalTo: self.iconWrapperView.centerXAnchor),
                self.iconView.centerYAnchor.constraint(equalTo: self.iconWrapperView.centerYAnchor),
                
                self.iconWrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
                self.iconWrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
                self.iconWrapperView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0),
                self.iconWrapperView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0)
            
            ])
        case .disabled:
            self.iconWrapperView.layer.cornerRadius = 8.0
        case .text:
            
            NSLayoutConstraint.activate([

                self.heightAnchor.constraint(equalToConstant: 128.0),
                self.widthAnchor.constraint(equalToConstant: 128.0),
                
                self.iconWrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                self.iconWrapperView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.iconView.centerXAnchor.constraint(equalTo: self.iconWrapperView.centerXAnchor),
                self.iconView.centerYAnchor.constraint(equalTo: self.iconWrapperView.centerYAnchor),
                
                self.titleLabel.topAnchor.constraint(equalTo: self.iconWrapperView.bottomAnchor, constant: 12.0),
                self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
                self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0),
                self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0)
            
            ])
            
            print("TEXT")
        }
        
        self.smallSizeConstraints = [
            self.iconView.widthAnchor.constraint(equalToConstant: 18.0),
            self.iconView.heightAnchor.constraint(equalToConstant: 18.0),
            self.iconWrapperView.widthAnchor.constraint(equalToConstant: 24.0),
            self.iconWrapperView.heightAnchor.constraint(equalToConstant: 24.0)
        ]
        
        self.mediumSizeConstraints = [
            self.iconView.widthAnchor.constraint(equalToConstant: 24.0),
            self.iconView.heightAnchor.constraint(equalToConstant: 24.0),
            self.iconWrapperView.widthAnchor.constraint(equalToConstant: 32.0),
            self.iconWrapperView.heightAnchor.constraint(equalToConstant: 32.0)
        ]
        
        self.largeSizeConstraints = [
            self.iconView.widthAnchor.constraint(equalToConstant: 24.0),
            self.iconView.heightAnchor.constraint(equalToConstant: 24.0),
            self.iconWrapperView.widthAnchor.constraint(equalToConstant: 48.0),
            self.iconWrapperView.heightAnchor.constraint(equalToConstant: 48.0)
        ]
    }

    private func prepareButtonByStyle() {
        switch self.styleOfButton {
        case .plain:
//            self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            self.baseBackgroundColor = .clear
            self.buttonTintColor = self.theme.getPrimaryColor()
            self.borderColor = UIColor.clear
        case .disabled:
//            self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            self.baseBackgroundColor = self.theme.getPrimaryColor().withAlphaComponent(0.1)
            self.buttonTintColor = self.theme.getPrimaryColor()
            self.borderColor = self.theme.getPrimaryColor().withAlphaComponent(0.1)
        }
    }

    private func prepareButtonByType() {
        switch self.typeOfButton {
        case .plain:
            self.styleOfButton = .plain
        case .text(let value):
            self.title = value
//            self.makeTextButton()
        case .disabled: break
//            self.makeDisabledButton()
        }
    }
    
    private func makeDisabledButton() {
        self.styleOfButton = .plain
//        self.setImage(UIImage.Images.icEdit, for: .normal)
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }

    private func makeButton(disabled: Bool) {
        let currentButtonStyle = self.styleOfButton

        if disabled {
            self.isUserInteractionEnabled = false
            self.borderColor = UIColor.Colors.PBGray90
            self.baseBackgroundColor = UIColor.Colors.PBGray90
            self.buttonTintColor = UIColor.Colors.PBGray70
        } else {
            self.isUserInteractionEnabled = true
            self.styleOfButton = currentButtonStyle
        }
    }

    private func setupDefaults() {
//        self.layer.cornerRadius = self.cornerRadius
//        self.layer.masksToBounds = true
//        self.layer.borderWidth = 1.0
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
}
