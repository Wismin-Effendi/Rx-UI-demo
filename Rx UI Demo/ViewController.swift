//
//  ViewController.swift
//  Rx UI Demo
//
//  Created by Wismin Effendi on 10/24/17.
//  Copyright © 2017 Wismin Effendi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segmentedLabel: UILabel!
    @IBOutlet weak var textViewCopyLabel: UILabel!
    @IBOutlet weak var textViewCountLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var stepperTextLabel: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTapGestureRecognizer()
        setupStepper()
        setupSegmentedControl()
        setupTextView()
    }
    
    private func setupTapGestureRecognizer() {
        tapGestureRecognizer.rx.event
            .bind { [unowned self] _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupStepper() {
        stepper.rx.value
            .map { String(Int($0)) }
            .bind(to: stepperTextLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.rx.value
            .skip(0)
            .bind { [unowned self] in
                self.segmentedLabel.text = "Selected segment: \($0)"
            }
            .disposed(by: disposeBag)
    }
    
    private func setupTextView() {
        textView.rx.text.orEmpty.asDriver()
            .drive(textViewCopyLabel.rx.text)
            .disposed(by: disposeBag)
        
        textView.rx.text.orEmpty.asDriver()
            .map {
                "Character count: \($0.characters.count)"
            }
            .drive(textViewCountLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

