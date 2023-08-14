//
//  PBBAttentionView.swift
//  
//
//  Created by Farid Valiyev on 05.08.23.
//
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

/// `PBBAttentionView` is a type of `UIView` for showing information, alerts to customers.
///
/// There is 2 levels of `AttentionLevel` for `PBBAttentionView`:
///  - `low`
///  - `high`
/// Low level attention views are in grayish theme, while high level alerts are in red one.
///
open class PBBAttentionView: UIView {
    
    /// Attention type of information
    ///
    /// Used for setting up attention view. Depending on its case,
    /// attention view' s theme can change into gray and red ones.
    ///
    public enum AttentionType: Equatable {
        case normal(localizedTitle: String)
        case detailed(localizedTitle: String, localizedDetailedTitle: String)
    }

    /// Attention style of information
    ///
    /// Used for setting up attention view. Depending on its case,
    /// attention view' s theme can change into gray and red ones.
    ///
    public enum AttentionStyle {
        
        /// Least level of attention
        ///
        /// Use this case for attentions which are `recommended` to consider when doing action,
        /// but isn't must.
        ///
        case info
        
        /// Informative level of attention
        ///
        /// Use this case for attentions which are `informative` to user
        /// contains informations good to know
        ///
        case inprogress

        /// Intermediate level of attention
        ///
        /// Use this case for attentions which are `required` to consider when doing action, but isn't must.
        ///
        case waiting

        /// Highest level of attention
        ///
        /// Use this case for attentions which is very important to consider when doing action.
        ///
        case error
        
        /// Highest level of attention
        ///
        /// Use this case for attentions which is very important to consider when doing action.
        ///
        case done
    }
    
    public var title: String = "" {
        didSet {
            self.infoTitle.text = title
        }
    }
    
    public var detail: String = "" {
        didSet {
            self.infoBody.text = detail
        }
    }

    /// Sets attention type for view.
    ///
    /// By default `PBBAttentionView` will be created with `normal` type.
    ///
    public var attentionType: AttentionType = .normal(localizedTitle: "") {
        didSet {
            self.prepareAttentionByType(type: self.attentionType)
        }
    }
    
    /// Sets attention style for view.
    ///
    /// By default `PBBAttentionView` will be created with `info` style.
    ///
    public var attentionStyle: AttentionStyle = .info {
        didSet {
            if self.attentionStyle != oldValue {
                self.prepareAttentionByStyle(style: self.attentionStyle)
            }
        }
    }

    private lazy var infoIcon: UIImageView = {
        let view = UIImageView()

        self.addSubview(view)

        view.image = UIImage.Images.icInfoDark
        view.contentMode = .scaleAspectFit

        view.translatesAutoresizingMaskIntoConstraints = false

        view.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        view.heightAnchor.constraint(equalToConstant: 24.0).isActive = true

        return view
    }()

    private lazy var infoTitle: UILabel = {
        let label = UILabel()

        label.font = UIFont.sfProText(ofSize: 15, weight: .medium)
        label.textColor = .darkText
        label.numberOfLines = 0
        label.text = self.title

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var infoBody: UILabel = {
        let label = UILabel()

        label.font = UIFont.sfProText(ofSize: 13, weight: .regular)
        label.textColor = .darkText
        label.numberOfLines = 0
        label.text = self.detail
        
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let view = UIStackView()

        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.alignment = .leading
        view.axis = .vertical
        view.spacing = 4.0
        view.distribution = .fill
        return view
    }()

    required public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    public convenience init(typefAttention: AttentionType = .normal(localizedTitle: "")) {
        self.init()
        
        UIFont.registerCustomFonts()
        
        self.attentionType = typefAttention
        self.attentionStyle = .info
        
        self.prepareAttentionByType(type: typefAttention)
        self.prepareAttentionByStyle(style: .info)
        
        self.setupViews()
        
        self.setupConstraints()
    }
    
    public convenience init(typefAttention: AttentionType = .normal(localizedTitle: ""), styleOfAttention: AttentionStyle = .info) {
        self.init()
        
        UIFont.registerCustomFonts()
        
        self.attentionStyle = styleOfAttention
        self.attentionType = typefAttention
        
        self.prepareAttentionByType(type: typefAttention)
        self.prepareAttentionByStyle(style: styleOfAttention)
        
        self.setupViews()
        
        self.setupConstraints()
    }

    private func setupViews() {
//        self.layoutSubviews()
        
        
        switch self.attentionType {
        case .normal:
            self.textStackView.addArrangedSubview(self.infoTitle)
        case .detailed:
            self.textStackView.addArrangedSubview(self.infoTitle)
            self.textStackView.addArrangedSubview(self.infoBody)
        }
        
        self.setupDefaults()
    }

    private func setupConstraints() {
        
        print("TYPE::: \(self.attentionType)")
        
        switch self.attentionType {
        case .normal:
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 48.0)
            ])
        case .detailed:
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 66.0)
            ])
        }
        
        NSLayoutConstraint.activate([
            self.infoIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.infoIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            self.heightAnchor.constraint(equalToConstant: 66.0),
//            self.textStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
//            self.textStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            self.textStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.textStackView.leftAnchor.constraint(equalTo: self.infoIcon.rightAnchor, constant: 12),
            self.textStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        ])
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
//        self.setupConstraints()
    }

    /// Sets informational text and its level for atttenion view.
    ///
    /// - Parameters:
    ///  - text: informational text
    ///  - attentionLevel: attention level, default value is low
    ///

    private func setupDefaults() {
        self.backgroundColor = UIColor.Colors.PBGrayTransparent
        self.layer.cornerRadius = 12.0
    }
    
    func prepareAttentionByType(type: AttentionType) {
        switch type {
        case .normal(let localizedTitle):
            self.infoTitle.text = localizedTitle
        case .detailed(let localizedTitle, let localizedDetailText):
            self.infoTitle.text = localizedTitle
            self.infoBody.text = localizedDetailText
//        case .low:
//            self.backgroundColor = UIColor.Colors.PBGrayTransparent
//            self.infoBody.textColor = UIColor.Colors.PBBlackMedium
//            self.infoIcon.image = UIImage.Images.icInfoGray
//        case .informative:
//            self.backgroundColor = UIColor.Colors.PBInfoYellowBG
//            self.infoBody.textColor = UIColor.Colors.PBInfoYellowFG
//            self.infoIcon.image = UIImage.Images.icInfoYellow
//        case .medium:
//            self.backgroundColor = UIColor.Colors.PBGrayTransparent
//            self.infoBody.textColor = .darkText
//            self.infoIcon.image = UIImage.Images.icInfoDark
//        case .high:
//            self.backgroundColor = UIColor.Colors.PBRed8
//            self.infoBody.textColor = UIColor.Colors.PBRed
//            self.infoIcon.image = UIImage.Images.icInfoRed
        }
        
//        self.setupConstraints()
    }
    
    func prepareAttentionByStyle(style: AttentionStyle) {
        switch style {
        case .info:
            self.backgroundColor = UIColor.Colors.PBGrayTransparent
            self.infoBody.textColor = UIColor.Colors.PBBlackMedium
            self.infoIcon.image = UIImage.Images.icInfoGray
        case .waiting: break
        case .inprogress: break
        case .error: break
        case .done: break
        }
    }
}
