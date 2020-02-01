//
//  InstructionsViewController.swift
//  dda-tap
//
//  Created by Victor Sira on 2019-10-31.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    @IBOutlet weak var TapPatternTextView: UITextView!
    
    @IBOutlet weak var TextCodeInstruction: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        resizeInstructionsTextView(textView: InstructionsTextView)
        fitTextViewToContent(textView: TapPatternTextView)
        fitTextViewToContent(textView: TextCodeInstruction)
    }
    
    func fitTextViewToContent(textView: UITextView) {
        var newFrame = textView.frame
        let width = textView.frame.width
        let newSize = textView.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        newFrame.size = newSize
        textView.frame = newFrame
    }

//    func resizeInstructionsTextView(textView: UITextView) {
//        var newFrame = textView.frame
//        let height = textView.frame.height
//        let newSize = textView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: height))
//        newFrame.size = newSize
//        print("new size \(newSize)")
//        textView.frame = newFrame
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
