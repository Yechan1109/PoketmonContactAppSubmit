//
//  ViewController.swift
//  PoketmonContactAppSubmit
//
//  Created by t2023-m0013 on 7/15/24.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    private let listView = ListView()
    
    var contacts: [Contact] = []
    
    override func loadView() {
        super.loadView()
        view = listView
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
        
        btnAction()
        fetchContacts()
    }
    
    // viewWillAppear에서 fetchContacts() 사용 -> 화면이 나타날 때마다 데이터 reload
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchContacts()
        }
    
    // MARK: -
    
    @objc private func goToCreateTapped() {
        let phoneBookViewController = PhoneBookViewController()
        navigationController?.pushViewController(phoneBookViewController, animated: true)
    }
    
    private func btnAction() {
        listView.createButton.addTarget(self, action: #selector(goToCreateTapped), for: .touchUpInside)
    }
    
    func fetchContacts() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        // 이름 오름차순으로 정렬
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            contacts = try context.fetch(fetchRequest)
            listView.tableView.reloadData() // 데이터를 불러온 후 테이블 뷰 리로드
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 셀 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        let contact = contacts[indexPath.row]
        cell.configure(withName: contact.name ?? "", number: contact.number, image: UIImage(data: contact.image ?? Data()))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phoneBookViewController = PhoneBookViewController()
        phoneBookViewController.contact = contacts[indexPath.row] // 선택된 연락처 데이터를 전달
        navigationController?.pushViewController(phoneBookViewController, animated: true)
    }
}
