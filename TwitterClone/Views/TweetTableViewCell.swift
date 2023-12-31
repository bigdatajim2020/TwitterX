//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Jim Yang on 2023-09-06.
//

import UIKit

protocol TweetTableViewCellDelegate: AnyObject{
    func tweetTableViewCellDidTapReply()
    func tweetTableViewCellDidTapRetweet()
    func tweetTableViewCellDidTapLike()
    func tweetTableViewCellDidTapShare()
}

class TweetTableViewCell: UITableViewCell {
    static let identifier = "TweetTableViewCell"
    private let actionSpacing:CGFloat=60
    
    weak var delegate: TweetTableViewCellDelegate?
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
//        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .red
        
        return imageView
        
    }()
    
    private let displayNameLable: UILabel = {
       let label = UILabel()
//        label.text = "James Yang"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let usernameLable: UILabel = {
       let label = UILabel()
  //      label.text = "@User Name Label"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tweetTextContentLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "This is my mockup tweet. It is going to take multiple lines, unsanitary, go banana, abalone, sea cucumber"
        label.numberOfLines = 0
        
        return label
    }()
    
    private let replyButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()

    private let retweetButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()

    private let likeButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()

    private let shareButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLable)
        contentView.addSubview(usernameLable)
        contentView.addSubview(tweetTextContentLabel)
        contentView.addSubview(replyButton)
        contentView.addSubview(retweetButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)

        
        configureConstraints()
        configureButtons()
    }
    
    @objc
    private func didTapReply(){
        delegate?.tweetTableViewCellDidTapReply()
    }
    
    @objc
    private func didTapRetweet(){
        delegate?.tweetTableViewCellDidTapRetweet()
    }
    
    @objc
    private func didTapLike(){
        delegate?.tweetTableViewCellDidTapLike()
    }
    
    @objc
    private func didTapShare(){
        delegate?.tweetTableViewCellDidTapShare() //implement delegate function in HomeViewController
    }
    
    private func configureButtons(){
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
  
    func configureTweet(with displayName: String, username: String, tweetTextContent: String, avatarPath: String){
        displayNameLable.text = displayName
        usernameLable.text = "@\(username)"
        tweetTextContentLabel.text = tweetTextContent
        avatarImageView.sd_setImage(with: URL(string: avatarPath))
    }
    
    private func configureConstraints(){
        let avatarImageViewConstraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        let displayNameLableConstraints = [
            displayNameLable.leadingAnchor.constraint(equalTo:avatarImageView.trailingAnchor, constant: 20),
            displayNameLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        ]
        
        let usernameLableConstraints = [
            usernameLable.leadingAnchor.constraint(equalTo: displayNameLable.trailingAnchor, constant: 10),
            usernameLable.centerYAnchor.constraint(equalTo: displayNameLable.centerYAnchor)
        ]
        
        let tweetTextContentLabelConstraints = [
            tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNameLable.leadingAnchor),
            tweetTextContentLabel.topAnchor.constraint(equalTo: displayNameLable.bottomAnchor, constant: 10),
            tweetTextContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15),
//            tweetTextContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        
        let replyButtonConstraints = [
            replyButton.leadingAnchor.constraint(equalTo: tweetTextContentLabel.leadingAnchor),
            replyButton.topAnchor.constraint(equalTo: tweetTextContentLabel.bottomAnchor, constant: 10),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]

        let retweetButtonConstraints = [
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: actionSpacing),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
        ]

        let likeButtonConstraints = [
            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: actionSpacing),
            likeButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
        ]

        let shareButtonConstraints = [
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: actionSpacing),
            shareButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
        ]

        
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLableConstraints)
        NSLayoutConstraint.activate(usernameLableConstraints)
        NSLayoutConstraint.activate(tweetTextContentLabelConstraints)
        NSLayoutConstraint.activate(replyButtonConstraints)
        NSLayoutConstraint.activate(retweetButtonConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
        NSLayoutConstraint.activate(shareButtonConstraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
