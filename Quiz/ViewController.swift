//
//  ViewController.swift
//  Quiz
//
//  Created by 杨俊艺 on 2019/9/4.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0 //下一个问题标签消失
    }

    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    @IBAction func showNextQuestion(sender: AnyObject)
    {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        nextQuestionLabel.text = questions[currentQuestionIndex]
        answerLabel.text = "???"
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject)
    {
        answerLabel.text = answers[currentQuestionIndex]
    }
    
    func updateOffScreenLabel(){
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    //动画
    func animateLabelTransitions(){
        view.layoutIfNeeded()
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        UIView.animate(withDuration: 1, delay: 0, options: [.curveLinear], animations: {
            self.currentQuestionLabel.alpha = 0 //当前问题标签消失
            self.nextQuestionLabel.alpha = 1    //下一个问题标签显示
            self.view.layoutIfNeeded()
        }, completion: {_ in
            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
            swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
            self.updateOffScreenLabel()
        })
    }
    
    //MARK: 模型对象
    var currentQuestionIndex: Int = 0
    let questions: [String] = ["From what is cognac made?",
                               "What is 7 + 7?",
                               "What is the capital of Vermont?",
                               ]
    let answers: [String] = ["Grapes",
                            "14",
                            "Montpelier",
                            ]
    
}
