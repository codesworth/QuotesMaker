//
//  OptionsStack.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol OptionsSelectedDelegate:class {
    func didPressButton(_ id:Int)
}

class OptionsStack: UIView {
    
    
    private var stackView:UIStackView
    private var upperStack:UIStackView
    private var lowerStack:UIStackView
    private var options = Options.getDefaultOptions()
    var createButtons:[OptionsButtonView]!
    weak var delegate:OptionsSelectedDelegate?
    var isRemovedFromSuperView = false
    override init(frame: CGRect) {
        stackView = UIStackView(frame: frame)
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        upperStack = UIStackView(frame: .zero)
        lowerStack = UIStackView(frame: .zero)
        upperStack.axis = .horizontal
        lowerStack.axis = .horizontal
        upperStack.distribution = .fillEqually
        lowerStack.distribution = .fillEqually
        lowerStack.spacing = 5
        upperStack.spacing = 5
        lowerStack.alignment = .fill
        upperStack.alignment = .fill
        super.init(frame: frame)
        addSubview(stackView)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        createButtons = options.compactMap{
            return OptionsButtonView(frame: .zero, option: $0)
        }
        createButtons.forEach{$0.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)}
        precondition(createButtons.count == 4, "CreateButtons Count Error")
        upperStack.addArrangedSubview(createButtons[0])
        upperStack.addArrangedSubview(createButtons[1])
        lowerStack.addArrangedSubview(createButtons[2])
        lowerStack.addArrangedSubview(createButtons[3])
    }
    
    @objc func optionSelected(_ sender:OptionsButtonView){
        delegate?.didPressButton(sender.option.position)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //upperStack.frame.size = [frame.size.width,frame.size.height/]
        stackView.addArrangedSubview(upperStack)
        stackView.addArrangedSubview(lowerStack)
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        isRemovedFromSuperView = true
    }
    
    

}
