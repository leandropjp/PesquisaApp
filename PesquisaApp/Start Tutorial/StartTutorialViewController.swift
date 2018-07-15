//
//  StartTutorialViewController.swift
//  Chu Ko Nu
//
//  Created by Leandro Paiva Andrade on 4/5/18.
//  Copyright © 2018 Wololo. All rights reserved.
//

import UIKit

class StartTutorialViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    @IBOutlet weak var jumpIntroButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fowardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var images = [#imageLiteral(resourceName: "Screen"),
                  #imageLiteral(resourceName: "Screen2"),
                  #imageLiteral(resourceName: "Screen3")]
    var texts = [String]()
    var titles = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "tutorial")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(StartTutorialCell.self, forCellWithReuseIdentifier: cellId)
        
        //let appName = "Hugo Montenegro"
        
        titles.append("Conheça o aplicativo.")
        texts.append("Bem vindo ao meu aplicativo! Aqui você encontrará informações sobre minhas pesquisas e as minhas redes sociais.")
        
        titles.append("Participe das pesquisas.")
        texts.append("Participe das minhas pesquisas e tenha acesso a conteúdos exclusivos criados por mim, que vão te ajudar a melhorar sua empresa.")
        
        titles.append("Acesso exclusivo.")
        texts.append("Após participar da pesquisa tenha acesso a livros e conteúdos exclusivos, que podem ser lidos direto no app ou baixados para seu aplicativo.")
        
        fowardButton.alpha = 1
        fowardButton.isEnabled = true
        
        titleLabel.text = "Seja bem-vindo!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .gray
        titleLabel.alpha = 1
        jumpIntroButton.setTitle("Pular introdução", for: .normal)
        
        jumpIntroButton.setTitleColor(.gray, for: .normal)
        jumpIntroButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        jumpIntroButton.addTarget(self, action: #selector(jumpIntro), for: .touchUpInside)
        self.pageControl.numberOfPages = titles.count
        self.collectionView.backgroundColor = .clear
    }
    
    @objc func jumpIntro() {
        let vc = AppStoryboard.Main.viewController(viewControllerClass: ViewController.self)
        guard let window = self.view.window else {
            return
        }
        
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: {
                window.rootViewController = UINavigationController(rootViewController: vc)
            })
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StartTutorialCell
        cell.image.image = images[indexPath.item]
        let titleColor = UIColor.gray
        let textColor = UIColor.gray
        
        var attributes1: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)]
        attributes1[NSAttributedStringKey.foregroundColor] =  titleColor
        var attributes2: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]
        attributes2[NSAttributedStringKey.foregroundColor] =  textColor
        let attributedString = NSMutableAttributedString(string: titles[indexPath.item] + "\n", attributes: attributes1)
        attributedString.append(NSAttributedString(string: "\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12)]))
        attributedString.append(NSAttributedString(string: texts[indexPath.item], attributes: attributes2))
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let fullRange = (attributedString.string as NSString).range(of: attributedString.string)
        attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: style], range: fullRange)
        cell.tutoText.attributedText = attributedString

        return cell
    }
    
    var scrolling = false
    @IBAction func goNextPage(_ sender: Any) {
        if !scrolling {
            let collectionBounds = self.collectionView.bounds
            let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
            scrolling = true
            self.moveToFrame(contentOffset: contentOffset)
        }
    }
    
    @IBAction func goPreviousPage(_ sender: Any) {
        if !scrolling {
            scrolling = true
            let collectionBounds = self.collectionView.bounds
            let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
            self.moveToFrame(contentOffset: contentOffset)
            
        }
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension StartTutorialViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / self.collectionView.frame.width)
        self.pageControl.currentPage = Int(pageIndex)
        if self.pageControl.currentPage == titles.count - 1 {
            
            self.fowardButton.setBackgroundImage(#imageLiteral(resourceName: "Next Step Button"), for: .normal)
            self.fowardButton.removeTarget(self, action: #selector(goNextPage(_:)), for: .touchUpInside)
            self.fowardButton.addTarget(self, action: #selector(jumpIntro), for: .touchUpInside)
            scrollView.bounces = false
        } else {
            self.fowardButton.alpha = 1
            self.fowardButton.isEnabled = true
        }
        
        if self.pageControl.currentPage == 0 {
            
            //self.backButton.alpha = 0
            self.backButton.isEnabled = false
            scrollView.bounces = false
        } else {
            self.backButton.alpha = 1
            self.backButton.isEnabled = true
        }
        
        if pageControl.currentPage < titles.count - 1 {
            self.fowardButton.setBackgroundImage(#imageLiteral(resourceName: "Next Step Button"), for: .normal)
            self.fowardButton.removeTarget(self, action: #selector(jumpIntro), for: .touchUpInside)
            self.fowardButton.addTarget(self, action: #selector(goNextPage(_:)), for: .touchUpInside)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //
        scrolling = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrolling = false
        //
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrolling = false
        //
        
    }
}

class StartTutorialCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let tutoText: UITextView = {
        let label = UITextView()
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        label.allowsEditingTextAttributes = false
        label.backgroundColor = .clear
        label.layer.shadowOpacity = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .clear
        addSubview(image)
        image.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(tutoText)
        tutoText.anchor(top: image.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 10, paddingRight: 32, width: 0, height: 150)
    }
    
}

