//
//  CreateView.swift
//  PoketmonContactAppSubmit
//
//  Created by t2023-m0013 on 7/15/24.
//

import UIKit

class PhoneBookView: UIView {
    //소스트리확인용
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "연락처 추가"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let setButton: UIButton = {
        let button = UIButton()
        button.setTitle("적용", for:.normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for:.normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let setImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true  // 이미지가 뷰 경계 넘지 않도록(true)
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var setName: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray4
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 10
        tf.autocapitalizationType = .none  // 첫 문자 대문자 X
        tf.autocorrectionType = .no        // 자동완성 X
        tf.clearsOnBeginEditing = false    // 재사용시 리셋
        let paragraphStyle = NSMutableParagraphStyle()  // placeholder text_align -> center
        paragraphStyle.alignment = .center
        tf.attributedPlaceholder = NSAttributedString(string: "이름을 입력하세요", attributes: [.foregroundColor: UIColor.systemGray, .paragraphStyle: paragraphStyle])
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var setNumber: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray4
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 10
        tf.autocapitalizationType = .none  // 첫 문자 대문자 X
        tf.autocorrectionType = .no        // 자동완성 X
        tf.clearsOnBeginEditing = false    // 재사용시 리셋
        let paragraphStyle = NSMutableParagraphStyle()  // placeholder text_align -> center
        paragraphStyle.alignment = .center
        tf.attributedPlaceholder = NSAttributedString(string: "전화번호를 입력하세요", attributes: [.foregroundColor: UIColor.systemGray, .paragraphStyle: paragraphStyle])
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // MARK: - button
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        addSubview(titleLabel)
        addSubview(setButton)
        addSubview(setImage)
        addSubview(randomButton)
        addSubview(setName)
        addSubview(setNumber)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            
            setButton.topAnchor.constraint(equalTo: topAnchor, constant: 55),
            setButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            setImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            setImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            setImage.widthAnchor.constraint(equalToConstant: 200),
            setImage.heightAnchor.constraint(equalToConstant: 200),
            
            randomButton.topAnchor.constraint(equalTo: setImage.bottomAnchor, constant: 20),
            randomButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            setName.topAnchor.constraint(equalTo: setImage.bottomAnchor, constant: 100),
            setName.centerXAnchor.constraint(equalTo: centerXAnchor),
            setName.widthAnchor.constraint(equalToConstant: 300),
            setName.heightAnchor.constraint(equalToConstant: 30),
            
            setNumber.topAnchor.constraint(equalTo: setName.bottomAnchor, constant: 10),
            setNumber.centerXAnchor.constraint(equalTo: centerXAnchor),
            setNumber.widthAnchor.constraint(equalToConstant: 300),
            setNumber.heightAnchor.constraint(equalToConstant: 30),
            
            
        ])
    }
}

#Preview {
    PhoneBookView()
}
