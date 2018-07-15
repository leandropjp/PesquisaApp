//
//  RadioQuestion.swift
//  PesquisaApp
//
//  Created by Leandro Paiva Andrade on 6/27/18.
//  Copyright © 2018 Lieno Tecnologia. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var delegate: QuestionDelegate?
    var commentTextField: QuestionField?
    var questionIndex = -1
    @objc func radioTapped(sender: QuestionButton) {
        if sender.hasIf {
            commentTextField?.isHidden = false
        } else {
            commentTextField?.isHidden = true
        }
        for (index,btn) in buttonsArray.enumerated() {
            if sender.tag == index {
                btn.isSelected = true
                btn.selectedAnswer = true
                UserDefaults.standard.set(true, forKey: "\(AppConfig.shared.questionsCount)_\(index)")
            } else {
                btn.isSelected = false
                btn.selectedAnswer = false
                UserDefaults.standard.removeObject(forKey: "\(AppConfig.shared.questionsCount)_\(index)")
            }
        }
    }
    
    @objc func checkTapped(sender: QuestionButton) {
        UserDefaults.standard.set(!sender.isSelected, forKey: "\(AppConfig.shared.questionsCount)_\(sender.tag)_check")
        sender.isSelected = !sender.isSelected
        sender.selectedAnswer = sender.isSelected
    }
    
    var buttonsArray = [QuestionButton]()
    var checkButtonsArray = [QuestionButton]()
    var textFieldArray = [QuestionField]()
    
    func initRadioQuestionWith(question: String, itens: [String], questionIndex: Int) {
        self.questionIndex = questionIndex
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.text = question
        
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        var answers = [UIStackView]()
        var count = 0
        buttonsArray.removeAll()
        for (index,i) in itens.enumerated() {
            var finalText = i
            let radioButton = QuestionButton()
            radioButton.index = index
            radioButton.tag = count
            if finalText.contains(radioFlag) {
                finalText = finalText.replacingOccurrences(of: radioFlag, with: "")
                radioButton.setImage(#imageLiteral(resourceName: "radio-clear"), for: .normal)
                radioButton.setImage(#imageLiteral(resourceName: "radio-checked"), for: .selected)
                radioButton.addTarget(self, action: #selector(radioTapped(sender:)), for: .touchUpInside)
                buttonsArray.append(radioButton)
                if UserDefaults.standard.bool(forKey: "\(AppConfig.shared.questionsCount)_\(index)") == true {
                    radioButton.isSelected = true
                    radioButton.selectedAnswer = true
                }
            } else if i.contains(checkFlag) {
                finalText = finalText.replacingOccurrences(of: checkFlag, with: "")
                radioButton.setImage(#imageLiteral(resourceName: "check-clear"), for: .normal)
                radioButton.setImage(#imageLiteral(resourceName: "check-filled"), for: .selected)
                radioButton.addTarget(self, action: #selector(checkTapped(sender:)), for: .touchUpInside)
                checkButtonsArray.append(radioButton)
                if UserDefaults.standard.bool(forKey: "\(AppConfig.shared.questionsCount)_\(radioButton.tag)_check") == true {
                    radioButton.isSelected = true
                    radioButton.selectedAnswer = true
                }
            }
            
            radioButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
            count += 1

            let textLabel = UILabel()
            
            let stack = UIStackView(arrangedSubviews: [radioButton, textLabel])
            stack.axis = .horizontal
            answers.append(stack)
            var placeholder = ""
            
            if questionIndex == 0 {
                radioButton.isHidden = true
                placeholder = "Opcional"
            }
            
            if finalText.contains(textFlag) {
                radioButton.isHidden = true
                finalText = finalText.replacingOccurrences(of: textFlag, with: "")
                let commentField = QuestionField()
                commentField.index = index
                let final = finalText.components(separatedBy: "*").first!
                commentField.answer = final.replacingOccurrences(of: "*", with: "")
                commentField.borderStyle = .roundedRect
                commentField.placeholder = placeholder
                commentField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
                answers.append(UIStackView(arrangedSubviews: [commentField]))
                textFieldArray.append(commentField)
                if let text = UserDefaults.standard.string(forKey: "\(AppConfig.shared.questionsCount)_\(index)_check") {
                    commentField.text = text
                }
            }
            
            if finalText.contains(textNumberFlag) {
                radioButton.isHidden = true
                finalText = finalText.replacingOccurrences(of: textNumberFlag, with: "")
                let commentField = QuestionField()
                let final = finalText.components(separatedBy: "*").first!
                commentField.answer = final.replacingOccurrences(of: "*", with: "")
                commentField.index = index
                commentField.borderStyle = .roundedRect
                commentField.keyboardType = .numberPad
                commentField.placeholder = placeholder
                commentField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
                answers.append(UIStackView(arrangedSubviews: [commentField]))
                textFieldArray.append(commentField)
                if let text = UserDefaults.standard.string(forKey: "\(AppConfig.shared.questionsCount)_\(index)_check") {
                    commentField.text = text
                }
            }
            
            if i.contains(commentFlag) {
                finalText = finalText.replacingOccurrences(of: commentFlag, with: "")
                commentTextField = QuestionField()
                commentTextField?.index = index
                let final = finalText.components(separatedBy: "*").first!
                commentTextField?.answer = final.replacingOccurrences(of: "*", with: "")
                commentTextField?.borderStyle = .roundedRect
                commentTextField?.placeholder = placeholder
                answers.append(UIStackView(arrangedSubviews: [commentTextField!]))
                commentTextField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
                textFieldArray.append(commentTextField!)
                if finalText.contains(ifFlag) {
                    radioButton.hasIf = true
                    finalText = finalText.replacingOccurrences(of: ifFlag, with: "")
                    commentTextField?.isHidden = true
                    
                    let query = finalText
                    let regex = try! NSRegularExpression(pattern:"%(.*?)%", options: [])
                    var results = [String]()
                    
                    regex.enumerateMatches(in: query, options: [], range: NSMakeRange(0, query.utf16.count)) { result, flags, stop in
                        if let r = result?.range(at: 1), let range = Range(r, in: query) {
                            results.append(String(query[range]))
                        }
                    }
                    if let placeholder = results.first {
                        finalText = finalText.replacingOccurrences(of: "%\(placeholder)%", with: "")
                        commentTextField?.placeholder = placeholder
                    }
                    
                    if let text = UserDefaults.standard.string(forKey: "\(AppConfig.shared.questionsCount)_\(index)_check"), !text.isEmpty {
                        commentTextField?.text = text
                        commentTextField?.isHidden = false
                    }
                    
                }
                
                if let text = UserDefaults.standard.string(forKey: "\(AppConfig.shared.questionsCount)_\(index)_check") {
                    commentTextField?.text = text
                }
            }
            
            radioButton.answer = finalText.replacingOccurrences(of: "*", with: "")
            textLabel.text = finalText.replacingOccurrences(of: "*", with: "")
            textLabel.font = UIFont.systemFont(ofSize: 16)
        }
        let botStack = UIStackView(arrangedSubviews: answers)
        botStack.axis = .vertical
        botStack.spacing = 8
        addSubview(botStack)
        botStack.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, width: 0, height: 0)
        layoutIfNeeded()
    }
    
    @objc func textFieldDidChange(_ textField: QuestionField) {
        if (textField.text?.isEmpty)! {
          UserDefaults.standard.removeObject(forKey: "\(AppConfig.shared.questionsCount)_\(textField.index)_check")
        } else {
          UserDefaults.standard.set(textField.text, forKey: "\(AppConfig.shared.questionsCount)_\(textField.index)_check")
        }
        
    }
    
}

import UIKit

extension UIView {
    func anchorToEntireView(of view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

import UIKit

@IBDesignable
open class GradientView: UIView {
    @IBInspectable
    public var startColor: UIColor = .clear {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    @IBInspectable
    public var endColor: UIColor = .clear {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}


