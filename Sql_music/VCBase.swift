//
//  VCBase.swift
//  Sql_music
//
//  Created by Pham Ngoc Hai on 1/17/17.
//  Copyright © 2017 pnh. All rights reserved.
//

import UIKit

class VCBase: UIViewController {
    var btn_Title : UIButton!
    var txt_Search: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBtnTitle()
        addTxtSearch()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setActionforRightBarButton()

    }
    
    
    func addBtnTitle()
    {
    btn_Title = UIButton()
    btn_Title.setTitle("Name", for: .normal)
    btn_Title.setTitleColor(UIColor.gray, for: .highlighted)
        btn_Title.addTarget(self, action: #selector(chooseOrder), for: .touchUpInside)
        btn_Title.backgroundColor = UIColor.black
        self.view.addSubview(btn_Title)
        btn_Title.translatesAutoresizingMaskIntoConstraints = false
        let cn1 = NSLayoutConstraint(item: btn_Title, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        let cn2 = NSLayoutConstraint(item: btn_Title, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let cn3 = NSLayoutConstraint(item: btn_Title, attribute: .height, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        let cn4 = NSLayoutConstraint(item: btn_Title, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 64)
        NSLayoutConstraint.activate([cn1,cn2,cn3,cn4])
    
    }
    func chooseOrder()
    {
    print("Click")
    
    }
    func addTxtSearch()
    {
    txt_Search = UITextField()
        txt_Search.isHidden = true
        txt_Search.borderStyle = .roundedRect
        txt_Search.placeholder = "Enter name here"
        txt_Search.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(txt_Search)
        btn_Title.translatesAutoresizingMaskIntoConstraints = false
        let cn1 = NSLayoutConstraint(item: txt_Search, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        let cn2 = NSLayoutConstraint(item: txt_Search, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let cn3 = NSLayoutConstraint(item: txt_Search, attribute: .height, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        let cn4 = NSLayoutConstraint(item: txt_Search, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 64)
        NSLayoutConstraint.activate([cn1,cn2,cn3,cn4])
    
    
    }
  func  setActionforRightBarButton()
  {
    self.tabBarController?.navigationItem.rightBarButtonItem?.target = self
    self.tabBarController?.navigationItem.rightBarButtonItem?.action = #selector(checkHiddenSearch)
    
    }
    func checkHiddenSearch(){
        if txt_Search.isHidden == true{
        UIView.transition(with: txt_Search, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }else{
        UIView.transition(with: txt_Search, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
        txt_Search.isHidden = !txt_Search.isHidden
        txt_Search.resignFirstResponder()
    }
   }
