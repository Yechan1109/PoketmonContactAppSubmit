//
//  CreateController.swift
//  PoketmonContactAppSubmit
//
//  Created by t2023-m0013 on 7/15/24.
//

import UIKit

class PhoneBookViewController: UIViewController {
    
    let phoneBookView = PhoneBookView()
    
    //
    var contact: Contact?
    
    override func loadView() {
        super.loadView()
        view = phoneBookView
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBar로 상속 -> 적용버튼 클릭안되는거 해결
        let setButtonItem = UIBarButtonItem(customView: phoneBookView.setButton)
        navigationItem.rightBarButtonItem = setButtonItem
        
        btnAction()
        loadContact()
        
    }
    // MARK: -
    
    
    private func btnAction() {
        phoneBookView.randomButton.addTarget(self, action: #selector(fetchPoketmonImageTapped), for: .touchUpInside)
        phoneBookView.setButton.addTarget(self, action: #selector(saveAndUpdateTapped), for: .touchUpInside)
    }
    
    private func loadContact() {
        // 클릭된 cell의 contact 가져오기
        if let contact = contact {
            phoneBookView.setName.text = contact.name
            phoneBookView.setNumber.text = contact.number
            if let imageData = contact.image {
                phoneBookView.setImage.image = UIImage(data: imageData)
            }
        }
    }

    @objc private func fetchPoketmonImageTapped() {
        let randomNum = Int.random(in: 1...1000)
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomNum)") else {    // url 출력값이 png파일이 아니라 json 형태임!
            print("Invalid URL")
            return
        }
        // URLSession을 통해 비동기로 데이터 가져오기(클로저에서 받은 데이터 처리 / 네트워크 에러 -> 데이터 에러 처리)
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                // 1. 네트워크 요청시 발생하는 에러 처리
                print("Data task error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // 2. 받는 데이터 없을 경우
                print("No data received")
                return
            }
            
            // 데이터가 있을 경우..
            do {
                // JSONSerialization을 사용하여 json 디코딩 후 이미지 url 추출
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let sprites = json["sprites"] as? [String: Any], // sprites 안에 있는
                   let urlString = sprites["front_default"] as? String, // front_default(이미지url)
                   let imageUrl = URL(string: urlString) {
                    
                    // 메인 쓰레드에서 ui 업데이트 진행
                    DispatchQueue.main.async {
                        self?.phoneBookView.setImage.load(url: imageUrl)
                        print("\(randomNum)")
                    }
                } else {    // json 데이터에서 원하는 키를 찾지 못한 경우
                    print("JSON parsing error: Could not find expected keys")
                }
            } catch let jsonError {     // 디코딩 중 에러
                print("JSON decoding error: \(jsonError.localizedDescription)")
            }
        }.resume()  // URLSession의 dataTask 시작
    }
    
//     Swift 5.5부터 사용가능한 async throws / try await 사용하기 -> 가독성 UP, 비동기 작업 효율 UP
//    @objc private func fetchPoketmonImageTapped() async throws {
//        let randomNum = Int.random(in: 1...1000)
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomNum)") else {
//            print("Invalid URL")
//            return
//        }
//        
//        // URL에서 데이터를 비동기적으로 가져오기
//        let (data, _) = try await URLSession.shared.data(from: url)
//        
//        // JSON 파싱하여 이미지 URL 추출
//        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//              let sprites = json["sprites"] as? [String: Any],
//              let urlString = sprites["front_default"] as? String,
//              let imageUrl = URL(string: urlString) else {
//            throw NSError(domain: "JSON parsing error", code: -1, userInfo: nil)
//        }
//        
//        // 이미지 URL에서 이미지를 비동기적으로 로드하여 UIImageView에 설정
//        let image = try await loadImage(from: imageUrl)
//        DispatchQueue.main.async {
//            self.phoneBookView.setImage.image = image
//            print("\(randomNum)")
//        }
//    }
//
//    // 이미지를 비동기적으로 로드하는 함수
//    private func loadImage(from url: URL) async throws -> UIImage {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        guard let image = UIImage(data: data) else {
//            throw NSError(domain: "Image loading error", code: -1, userInfo: nil)
//        }
//        return image
//    }
    
    @objc private func saveAndUpdateTapped() {
        guard let name = phoneBookView.setName.text, !name.isEmpty,
              let number = phoneBookView.setNumber.text, !number.isEmpty,
              let imageData = phoneBookView.setImage.image?.pngData() else {
            return
        }
        saveContact(name: name, number: number, imageData: imageData)
        navigationController?.popViewController(animated: true)
    }

    private func saveContact(name: String, number: String, imageData: Data) {
        let context = CoreDataManager.shared.context
        // contact가 있으면 업데이트하고 nor 새로 만들기
        let contactToUpdate = contact ?? Contact(context: context)
        contactToUpdate.name = name
        contactToUpdate.number = number
        contactToUpdate.image = imageData
        
        do {
            try context.save()
        } catch {
            print("Failed to save contact: \(error)")
        }
    }
    
    
}

// 이미지를 백그라운드 쓰레드에서 비동기적으로 로드하기 위하
extension UIImageView {
    // UIImageView URL에서 이미지를 비동기 로드
    func load(url: URL) {
        // 백그라운드 스레드에서 실행
        DispatchQueue.global().async { [weak self] in
            // URL에서 데이터를 가져오고, 데이터가 유효한 경우 UIImage로 변환
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                // UI 업데이트는 메인 쓰레드에서!
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

