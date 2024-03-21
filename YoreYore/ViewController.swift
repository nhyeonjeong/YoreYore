//
//  ViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        let label = {
            let view = UILabel()
            view.text = "dlfkasdf"
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.borderWidth = 2
            return view
            
        }()
        
        view.addSubview(scrollView)
        scrollView.addSubview(label)
        
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
    }
}
