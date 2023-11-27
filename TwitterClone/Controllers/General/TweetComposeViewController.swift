//
//  TweetComposeViewController.swift
//  TwitterClone
//
//  Created by Jim Yang on 2023-11-23.
//

import UIKit
import Combine

class TweetComposeViewController: UIViewController {

    private var viewModel = TweetComposeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let tweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .twitterBlueColor
        button.setTitle("Tweet Button", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.white.withAlphaComponent(0.7), for: .disabled)
        button.tintColor = .white
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.isEnabled = false
        
        return button
    }()
    
    private let tweetContentTextView: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = "Write your first tweet..."
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 16)
        
        return textView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Tweet Compose"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        view.addSubview(tweetButton)
        view.addSubview(tweetContentTextView)
        
        tweetContentTextView.delegate = self
        
        configureConstraints()
        
        bindViews()
        
        tweetButton.addTarget(self, action: #selector(didTapToTweet), for: .touchUpInside)
    }
    
    @objc
    private func didTapToTweet(){
        viewModel.dispatchTweet()
    }
    
    private func bindViews(){
        viewModel.$isValidToTweet.sink{
            [weak self] state in
            self?.tweetButton.isEnabled = state
        }.store(in: &subscriptions)
        
        viewModel.$shouldDissmissComposer.sink{
           [weak self] success in
            if success{
                self?.dismiss(animated: true)
            }
        }.store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
    }
    
    private func configureConstraints(){
        let tweetButtonConstraints = [
            tweetButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetButton.widthAnchor.constraint(equalToConstant: 120),
            tweetButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let tweetContentTextViewConstraints = [
            tweetContentTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tweetContentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tweetContentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tweetContentTextView.bottomAnchor.constraint(equalTo: tweetButton.topAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(tweetButtonConstraints)
        NSLayoutConstraint.activate(tweetContentTextViewConstraints)
    }
    
    @objc
    private func didTapCancel(){
        dismiss(animated: true)
    }
    

}

extension TweetComposeViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray{
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "What's happening?"
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.tweetContent = textView.text
        viewModel.validateToTweet()
    }
}
