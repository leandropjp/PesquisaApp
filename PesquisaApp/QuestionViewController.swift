//
//  QuestionViewController.swift
//  PesquisaApp
//
//  Created by Leandro Paiva Andrade on 6/27/18.
//  Copyright © 2018 Lieno Tecnologia. All rights reserved.
//
import Foundation
import UIKit
import SwiftMessages

protocol QuestionDelegate {
    func textDidChange(text: String)
    func buttonDidChange()
}

class QuestionViewController: UIViewController, QuestionDelegate {
    
    @IBOutlet weak var progresBar: UIView!
    @IBOutlet weak var progressBarWidth: NSLayoutConstraint!
    let questions = AppConfig.shared.questions
    @IBOutlet weak var progressStack: UIStackView!
    @IBOutlet var progressCircles: [UIImageView]!
    @IBOutlet var progressCount: [UILabel]!
    let questionCardView = QuestionView()
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isPagingEnabled = true
        //cv.isScrollEnabled = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        for (index,value) in AppConfig.shared.progressNotification.enumerated() {
            if AppConfig.shared.questionsCount > (value-1) {
                progressCircles[index].image = #imageLiteral(resourceName: "progress-filled")
                progressCount[index].textColor = .white
            }
        }
        showNotification()
        progressBarWidth.constant = AppConfig.shared.progressBarValue
        if AppConfig.shared.questionsCount > 33 {
            UserDefaults.standard.set(true, forKey: finishedPoolKey)
            let congrats = UILabel()
            congrats.numberOfLines = 0
            congrats.textAlignment = .center
            let attrs = NSMutableAttributedString(string: "Parabéns! \n\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 22),
                                                                                    .foregroundColor: UIColor.black])
            attrs.append(NSAttributedString(string: "Agora você acesso gratuito ao livro IMPULSIVA-MENTE.", attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                                                                          .foregroundColor: UIColor.gray]))
            congrats.attributedText = attrs
            
            let btn = TopIconButton()
            btn.setImage(#imageLiteral(resourceName: "Icon_download").withRenderingMode(.alwaysOriginal), for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            btn.setTitleColor(.black, for: .normal)
            btn.setTitle("Download", for: .normal)
            btn.addTarget(self, action: #selector(downloadTapped), for: .touchUpInside)
            btn.sizeToFit()
            view.addSubview(congrats)
            congrats.anchor(top: progressStack.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
            
            view.addSubview(btn)
            btn.anchor(top: congrats.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 80)

            
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let jsonData = try encoder.encode(AppConfig.shared.answers)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                print(jsonString) // [{"sentence":"Hello world","lang":"en"},{"sentence":"Hallo Welt","lang":"de"}]
                
                // and decode it back
//                let decodedSentences = try JSONDecoder().decode([Answer].self, from: jsonData)
//                print(decodedSentences)
            } catch { print(error) }
            
            return
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
        questionCardView.cornerRadius = 10
        questionCardView.borderColor = UIColor.gray.withAlphaComponent(0.3)
        questionCardView.borderWidth = 1
        
        questionCardView.translatesAutoresizingMaskIntoConstraints = false
        questionCardView.initRadioQuestionWith(question: questions[AppConfig.shared.questionsCount].question, itens: questions[AppConfig.shared.questionsCount].answers, questionIndex: AppConfig.shared.questionsCount)
        
        let backBtn = UIButton(type: .system)
        let goBtn = UIButton(type: .system)
        backBtn.setTitle("Voltar", for: .normal)
        goBtn.setTitle("Avançar", for: .normal)
        backBtn.layer.borderWidth = 2
        backBtn.layer.borderColor = UIColor.gray.cgColor
        backBtn.setTitleColor(UIColor.gray, for: .normal)
        goBtn.setTitleColor(UIColor.gray, for: .normal)
        goBtn.layer.borderWidth = 2
        goBtn.layer.borderColor = UIColor.gray.cgColor
        backBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        backBtn.cornerRadius = 22
        goBtn.cornerRadius = 22
        backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        goBtn.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        let btnStack = UIStackView(arrangedSubviews: [backBtn, goBtn])
        btnStack.spacing = 5
        btnStack.axis = .horizontal
        
        btnStack.distribution = .fillEqually
        
        let viewStack = UIStackView(arrangedSubviews: [questionCardView, btnStack])
        viewStack.axis = .vertical
        viewStack.spacing = 16
        view.addSubview(viewStack)
        
        viewStack.anchor(top: progressStack.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
    
    @objc func downloadTapped() {
        let vc = PDFViewController()
        if self.navigationController != nil {
            self.navigationController?.present(vc, animated: true, completion: nil)
        } else {
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func showNotification() {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureDropShadow()
        let backgroundColor = UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        let foregroundColor = UIColor.darkText
        view.configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: #imageLiteral(resourceName: "alert-circle-256").imageWithColor(color: UIColor(red: 50/255, green: 143/255, blue: 212/255, alpha: 1)), iconText: nil)
        if AppConfig.shared.questionsCount == 1 {
            view.configureContent(title: "", body: "Pesquisa iniciada.")
        } else {
            var percent = "0"
            if AppConfig.shared.questionsCount == (AppConfig.shared.progressNotification[1]) {
                percent = "30%"
            }
            
            if AppConfig.shared.questionsCount == (AppConfig.shared.progressNotification[2]) {
                percent = "50%"
            }
            
            if AppConfig.shared.questionsCount == (AppConfig.shared.progressNotification[3]) {
                percent = "70%"
            }
            
            if AppConfig.shared.questionsCount == (AppConfig.shared.progressNotification[4]) {
                percent = "100%"
            }
            view.configureContent(title: "Parabéns!", body: "\(percent) concluído.")
        }
        
        if AppConfig.shared.progressNotification.contains(AppConfig.shared.questionsCount) {
            view.button?.isHidden = true
            SwiftMessages.show(view: view)
        }
    }
    
    @objc func nextQuestion() {
        
        AppConfig.shared.questionsCount += 1
        AppConfig.shared.progressBarValue += self.progresBar.frame.width / 35
        if AppConfig.shared.questionsCount > 33 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuestionViewControllerID") as! QuestionViewController
            
            vc.modalPresentationStyle = .custom
            vc.modalTransitionStyle = .crossDissolve //you can change this to do different animations
            vc.view.layer.speed = 1 //adjust this to animate at different speeds
            if self.navigationController != nil {
                self.navigationController?.present(vc, animated: true, completion: nil)
            } else {
                self.present(vc, animated: true, completion: nil)
            }
            return
        }
        AppConfig.shared.answers[AppConfig.shared.questionsCount].selected.removeAll()
        AppConfig.shared.answers[AppConfig.shared.questionsCount].text.removeAll()
        for i in questionCardView.buttonsArray {
            if i.selectedAnswer {
                AppConfig.shared.answers[AppConfig.shared.questionsCount].selected.append(i.answer)
            }
        }
        
        for i in questionCardView.checkButtonsArray {
            if i.selectedAnswer {
                AppConfig.shared.answers[AppConfig.shared.questionsCount].selected.append(i.answer)
            }
        }
        
        for i in questionCardView.textFieldArray {
            if !((i.text?.isEmpty)!) {
                AppConfig.shared.answers[AppConfig.shared.questionsCount].selected.append(i.answer)
                AppConfig.shared.answers[AppConfig.shared.questionsCount].text.append(i.text ?? "")
            }
        }
        //8,18
        if AppConfig.shared.questionsCount == 1 {

        } else if AppConfig.shared.questionsCount == 13 {

        } else {
            if !questionCardView.buttonsArray.isEmpty, AppConfig.shared.answers[AppConfig.shared.questionsCount].selected.isEmpty {
                AppConfig.shared.questionsCount -= 1
                AppConfig.shared.progressBarValue -= self.progresBar.frame.width / 35
                return
            } else if !questionCardView.checkButtonsArray.isEmpty, AppConfig.shared.answers[AppConfig.shared.questionsCount].selected.isEmpty {
                AppConfig.shared.questionsCount -= 1
                AppConfig.shared.progressBarValue -= self.progresBar.frame.width / 35
                return
            }else if !questionCardView.textFieldArray.isEmpty && questionCardView.buttonsArray.isEmpty, AppConfig.shared.answers[AppConfig.shared.questionsCount].text.isEmpty,
                AppConfig.shared.questionsCount != 18 {
                AppConfig.shared.questionsCount -= 1
                AppConfig.shared.progressBarValue -= self.progresBar.frame.width / 35
                return
            }
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuestionViewControllerID") as! QuestionViewController

        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve //you can change this to do different animations
        vc.view.layer.speed = 1 //adjust this to animate at different speeds
        if self.navigationController != nil {
            self.navigationController?.present(vc, animated: true, completion: nil)
        } else {
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @objc func goBack() {
        if AppConfig.shared.questionsCount > 0 {
            AppConfig.shared.questionsCount -= 1
            AppConfig.shared.progressBarValue -= self.progresBar.frame.width / 35
        }
        
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func goToHome(_ sender: Any) {
        let newPage = AppStoryboard.Main.viewController(viewControllerClass: ViewController.self)
        AppConfig.shared.questionsCount = 0
        AppConfig.shared.progressBarValue = 0
        guard let window = self.view.window else {
            return
        }
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: {
                window.rootViewController = newPage
            })
        }
    }
    
    func textDidChange(text: String) {
        
    }
    
    func buttonDidChange() {
        //
    }
    
    @IBAction func openBlog(_ sender: Any) {
        let url = URL(string: "https://hugomontenegro.com.br/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}

