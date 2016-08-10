//
//  ViewController.swift
//  ThirdPartyKeyboardTest
//
//  Created by Jordan on 8/1/16.
//  Copyright © 2016 Jordan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    
    var keyboardOnView: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard)));
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil);
    }
    
    func hideKeyboard() {
        self.textField.resignFirstResponder();
    }
    
    func keyboardWillShow(notification:NSNotification) {
        if (keyboardOnView == false) {
            keyboardOnView = true;
            let keyboardSize:CGRect = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]!.CGRectValue;
            let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey]! as! Int;
            var duration:Double = 0.25;
            if let keyboardDuration:Double = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]! as? Double {duration = keyboardDuration;}
            
            self.view.layoutIfNeeded();
            UIView.animateWithDuration(duration) {
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!);
                self.scrollViewBottomConstraint.constant += keyboardSize.height;
                self.view.layoutIfNeeded();
            }
        }
    }
    
    func keyboardWillHide(notification:NSNotification){
        if (keyboardOnView == true) {
            keyboardOnView = false;
            let keyboardSize:CGRect = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]!.CGRectValue;
            let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey]! as! Int;
            var duration:Double = 0.25;
            if let keyboardDuration:Double = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]! as? Double {duration = keyboardDuration;}
            
            self.view.layoutIfNeeded();
            UIView.animateWithDuration(duration) {
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!);
                self.scrollViewBottomConstraint.constant -= keyboardSize.height;
                self.view.layoutIfNeeded();
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

