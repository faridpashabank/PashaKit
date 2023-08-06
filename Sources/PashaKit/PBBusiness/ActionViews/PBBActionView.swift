//
//  PBBRowView.swift
//
//
//  Created by Farid Valiyev on 20.07.23.
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
/// - Note: PBBActionView is optimized for looking as expected with minimum effort at the `height` of 72.0 pt.
///
/// However feel free to customize it.
///

public class PBBActionView: UIView {

    public enum PBBActionType {
        case normal(localizedText: String)
        case detailed(localizedText: String, detailLocalizedText: String)
        case description(localizedText: String, detailLocalizedText: String, descriptionLocalizedText: String)
    }
    
    public enum PBBActionState {
        case normal
        case disabled
    }

    public enum PBBActionStatusType {
        case new(localizedText: String)
        case waiting(localizedText: String)
        case inprogress(localizedText: String)
        case done(localizedText: String)
    }

    public enum PBBActionStyle {
        case chevron
        case chevronWithText(localizedText: String)
        case chevronWithStatus(localizedText: String, status: PBBActionStatusType)
        case chevronWithButton(localizedText: String)
        case radioButton(isSelected: Bool)
        case switchButton(isSelected: Bool)
    }

    public enum IconSize {
        case small
        case medium
        case large
    }
    
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
    /// image in future, just set the desired image to this property.
    ///
    public var image: UIImage? {
        didSet {
            self.iconView.image = image
        }
    }

    /// The radius to use when drawing rounded corners for the layer’s background.
    ///
    /// By default it will set 12.0 to corner radius property of button.
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
    public var baseBackgroundColor: UIColor = .clear {
        didSet {
            self.backgroundColor = self.baseBackgroundColor
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
    public var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderWidth = 1
            self.layer.borderColor = self.borderColor.cgColor
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
//            self.prepareButtonByState()
        }
    }
    
    private var typeOfAction: PBBActionType = .normal(localizedText: "") {
        didSet {
//            self.prepareButtonByType()
        }
    }

    /// Specifies style of the actionView.
    ///
    /// If not specified by outside, PBBActionView will be created with filled style.
    ///
    public var stateOfAction: PBBActionState = .normal {
        didSet {
//            self.prepareButtonByState()
        }
    }
    
    public var statusTypeOfAction: PBBActionStatusType = .new(localizedText: "") {
        didSet {
//            self.prepareButtonByState()
        }
    }
    
    public var styleOfAction: PBBActionStyle = .chevron {
        didSet {
//            self.prepareButtonByState()
        }
    }
    
    public var iconSize: IconSize = .large {
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
                self.iconWrapperView.layer.cornerRadius = 16
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

        label.textAlignment = .left
        label.text = self.title
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
    ///    - typeOfButton: Sets the type of button.
    ///
    
    public convenience init(typeOfAction: PBBActionType = .normal(localizedText: "")) {
        self.init()
        
        UIFont.registerCustomFonts()
        
        self.typeOfAction = typeOfAction
//        self.stateOfButton = .normal
        
        self.prepareActionViewByType()
        self.prepareActionViewByState()
        
        self.setupViews(for: typeOfAction)
        
    }

    public convenience init(typeOfAction: PBBActionType = .normal(localizedText: ""), stateOfAction: PBBActionState = .normal) {
        self.init()
        
        UIFont.registerCustomFonts()
        
        self.typeOfAction = typeOfAction
        self.prepareActionViewByType()
        self.stateOfAction = stateOfAction
        self.prepareActionViewByState()
       
        self.setupViews(for: typeOfAction)
        
    }
    
    private func setupViews(for type: PBBActionType) {
        
        self.iconWrapperView.addSubview(self.iconView)
        
        self.addSubview(self.iconWrapperView)
        
        self.addSubview(self.titleLabel)
        
        self.cornerRadius = 12.0
        
        switch type {
        case .normal: break
            
        case .detailed: break
        case .description: break
        }

//        switch type {
//        case .plain:
//            self.iconWrapperView.layer.cornerRadius = self.iconWrapperView.layer.frame.height / 2
//        case .withTitle:
//            self.addSubview(self.titleLabel)
//        case .disabled:
//            self.disableView.layer.cornerRadius = 8
//            self.disableView.addSubview(self.disableTitleLabel)
//            self.addSubview(self.disableView)
//            self.addSubview(self.titleLabel)
//        }
        
        self.setupConstraints(for: type)
    }
    
    private func setupConstraints(for type: PBBActionType) {
        switch type {
        case .normal:
            
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 72.0),
                
                self.iconView.centerXAnchor.constraint(equalTo: self.iconWrapperView.centerXAnchor),
                self.iconView.centerYAnchor.constraint(equalTo: self.iconWrapperView.centerYAnchor),
                self.iconWrapperView.heightAnchor.constraint(equalToConstant: 40.0),
                self.iconWrapperView.widthAnchor.constraint(equalToConstant: 40.0),
                
                self.iconWrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
                self.iconWrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
                self.iconWrapperView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
                
                self.titleLabel.leftAnchor.constraint(equalTo: self.iconWrapperView.rightAnchor, constant: 12),
                self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.titleLabel.widthAnchor.constraint(equalToConstant: self.titleLabel.intrinsicContentSize.width),
//                self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            ])
            
        case .detailed:
            
            NSLayoutConstraint.activate([

                self.heightAnchor.constraint(equalToConstant: 128.0),
                self.widthAnchor.constraint(equalToConstant: 118.0),
                
                self.iconWrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                self.iconWrapperView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.iconView.centerXAnchor.constraint(equalTo: self.iconWrapperView.centerXAnchor),
                self.iconView.centerYAnchor.constraint(equalTo: self.iconWrapperView.centerYAnchor),
                
                self.titleLabel.topAnchor.constraint(equalTo: self.iconWrapperView.bottomAnchor, constant: 12.0),
                self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
                self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0),
                self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0)
            
            ])
            
        case .description:
            NSLayoutConstraint.activate([

                self.heightAnchor.constraint(equalToConstant: 128.0),
                self.widthAnchor.constraint(equalToConstant: 118.0),
                
                self.iconWrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                self.iconWrapperView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.iconView.centerXAnchor.constraint(equalTo: self.iconWrapperView.centerXAnchor),
                self.iconView.centerYAnchor.constraint(equalTo: self.iconWrapperView.centerYAnchor),
                
//                self.disableTitleLabel.centerXAnchor.constraint(equalTo: self.disableView.centerXAnchor),
//                self.disableTitleLabel.centerYAnchor.constraint(equalTo: self.disableView.centerYAnchor),
//
//                self.disableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//                self.disableView.heightAnchor.constraint(equalToConstant: 16),
//                self.disableView.widthAnchor.constraint(equalToConstant: self.disableTitleLabel.intrinsicContentSize.width + 12),
//                self.disableView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -4.0),
                
                self.titleLabel.topAnchor.constraint(equalTo: self.iconWrapperView.bottomAnchor, constant: 12.0),
                self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
                self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0),
                self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0)
            
            ])
        }
        
        self.smallSizeConstraints = [
            self.iconView.widthAnchor.constraint(equalToConstant: 12.0),
            self.iconView.heightAnchor.constraint(equalToConstant: 12.0),
            self.iconWrapperView.widthAnchor.constraint(equalToConstant: 24.0),
            self.iconWrapperView.heightAnchor.constraint(equalToConstant: 24.0)
        ]
        
        self.mediumSizeConstraints = [
            self.iconView.widthAnchor.constraint(equalToConstant: 16.0),
            self.iconView.heightAnchor.constraint(equalToConstant: 16.0),
            self.iconWrapperView.widthAnchor.constraint(equalToConstant: 32.0),
            self.iconWrapperView.heightAnchor.constraint(equalToConstant: 32.0)
        ]
        
        self.largeSizeConstraints = [
            self.iconView.widthAnchor.constraint(equalToConstant: 24.0),
            self.iconView.heightAnchor.constraint(equalToConstant: 24.0),
            self.iconWrapperView.widthAnchor.constraint(equalToConstant: 48.0),
            self.iconWrapperView.heightAnchor.constraint(equalToConstant: 48.0)
        ]
        
        self.iconSize = .large
    }

    private func prepareActionViewByState() {
        switch self.stateOfAction {
        case .normal: break
//            self.titleLabel.font = UIFont.sfProText(ofSize: 13, weight: self.buttonTitleWeight)
//            self.iconBackgroundColor = self.theme.getPrimaryColor()
//            self.iconWrapperView.backgroundColor = self.theme.getPrimaryColor()
        case .disabled: break
//            self.titleLabel.font = UIFont.sfProText(ofSize: 13, weight: .semibold)
//            self.titleLabel.textColor = UIColor.Colors.PBBGray
//            self.disableTitleLabel.font = UIFont.sfProText(ofSize: 11, weight: .medium)
//            self.disableTitleLabel.textColor = .white
//            self.iconBackgroundColor = UIColor.Colors.PBBBackgroundGray
        }
    }

    private func prepareActionViewByType() {
        switch self.typeOfAction {
        case .normal(let localizedText):
            self.title = localizedText
        case .detailed(let localizedText, let detailLocalizedText):
            self.title = localizedText
//            self.stateOfButton = .normal
        case .description(let localizedText, let detailLocalizedText, let descriptionLocalizedText):
            self.title = localizedText
//            self.disableTitle = disableTitle
//            self.stateOfButton = .disabled
        }
    }
    
    private func prepareActionViewByStatusType() {
        switch self.statusTypeOfAction {
        case .new: break
        case .waiting: break
        case .inprogress: break
        case .done: break
        }
    }
    
    private func prepareActionViewByStyle() {
        switch self.styleOfAction {
        case .chevron: break
        case .chevronWithButton(let localizedText): break
        case .chevronWithStatus(let localizedText, let status): break
        case .chevronWithText(let localizedText): break
        case .radioButton(let isSelected): break
        case .switchButton(let isSelected): break
        }
    }
    
}
