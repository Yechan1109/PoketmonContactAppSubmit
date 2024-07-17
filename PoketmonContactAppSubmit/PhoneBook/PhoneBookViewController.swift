//
//  CreateController.swift
//  PoketmonContactAppSubmit
//
//  Created by t2023-m0013 on 7/15/24.
//

import UIKit

class PhoneBookViewController: UIViewController {
    
    let phoneBookView = PhoneBookView()
    
    override func loadView() {
        super.loadView()
        view = phoneBookView
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let setButtonItem = UIBarButtonItem(customView: phoneBookView.setButton)
        navigationItem.rightBarButtonItem = setButtonItem
        
        
        phoneBookView.randomButton.addTarget(self, action: #selector(loadPoketmonImageTapped), for: .touchUpInside)
        phoneBookView.setButton.addTarget(self, action: #selector(saveContactTapped), for: .touchUpInside)
        
    }
    
    
    @objc private func loadPoketmonImageTapped() {
        let randomNum = Int.random(in: 1...1000)
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomNum)") else {return} // url 출력값이 png파일이 아니라 json 형태임!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], // Json -> dict
               let sprites = json["sprites"] as? [String: Any], // sprites 안에 있는
               let urlString = sprites["front_default"] as? String, // front_default(이미지url)
               let imageUrl = URL(string: urlString) {
                
                DispatchQueue.main.async {
                    self.phoneBookView.setImage.load(url: imageUrl)
                    print("\(randomNum)")
                }
            }
        }.resume()
    }
    
    
    @objc private func saveContactTapped() {
        print("saveContactTapped 작동중") // 디버깅용
        guard let name = phoneBookView.setName.text, !name.isEmpty,
              let number = phoneBookView.setNumber.text, !number.isEmpty else {
            // 사용자에게 이름과 번호를 입력하도록 알림
            return
        }
        
        let image = phoneBookView.setImage.image
        CoreDataManager.shared.saveContact(name: name, number: number, image: image)
        
        // 저장 후 ListViewController로 이동
        if let navigationController = self.navigationController {
            let listViewController = ListViewController()
            navigationController.pushViewController(listViewController, animated: true)
        } else {
            print("Navigation controller 작동중") // 디버깅용
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

