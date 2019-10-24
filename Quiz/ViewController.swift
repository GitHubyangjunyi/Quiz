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
        // Do any additional setup after loading the view.
        
        currentQuestionLabel.text = questions[currentQuestionIndex]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0 //下一个问题标签消失
    }

    //当前项目中视图控制器是一个ViewController实例,负责管理Main.storyboard中定义的界面
    //按住Control从大纲视图中的View Controller拖到试图上方的标签上,当标签高亮时选择questionLabel设置插座变量
    //当应用载入storyboard时ViewController对象的插座变量就会自动指向位于视图上方的标签对象,通过这个关联,ViewController对象就能在运行时管理这个标签
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    //选中画布中的下一个问题按钮,按住Control并拖至View Controller,当View Controller高亮时选择Sent Events的动作
    //或者直接将按钮拖动到ViewController.swift代码编辑区生成新的动作
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
    
    //动画
    func animateLabelTransitions(){
        let animationClosure = {()-> Void in
            self.currentQuestionLabel.alpha = 0 //当前问题标签消失
            self.nextQuestionLabel.alpha = 1    //下一个问题标签显示
        }
        UIView.animate(withDuration: 1, animations: animationClosure)
    }
    
    //MARK: 模型对象
    var currentQuestionIndex: Int = 0                               //跟踪用户正在回答的问题
    let questions: [String] = ["From what is cognac made?",
                               "What is 7 + 7?",
                               "What is the capital of Vermont?",
                               ]
    let answers: [String] = ["Grapes",
                            "14",
                            "Montpelier",
                            ]
    
}
