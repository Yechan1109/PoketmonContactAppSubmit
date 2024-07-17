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
        //        let listView = ListView(frame: view.bounds)
        //        listView.delegate = self
        view = listView
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAction()
        setupTableView()
        fetchContacts()
    }
    
    
    private func setAction() {
        listView.createButton.addTarget(self, action: #selector(goToCreateTapped), for: .touchUpInside)
    }
    
    @objc private func goToCreateTapped() {
        let phoneBookViewController = PhoneBookViewController()
        navigationController?.pushViewController(phoneBookViewController, animated: true)
    }
    
    private func setupTableView() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func fetchContacts() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
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
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    //        let contact = contacts[indexPath.row]
    //        cell.textLabel?.text = contact.name
    //        if let imageData = contact.image {
    //            cell.imageView?.image = UIImage(data: imageData)
    //        }
    //        return cell
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        let contact = contacts[indexPath.row]
        cell.configure(withName: contact.name ?? "", number: contact.number, image: UIImage(data: contact.image ?? Data()))
        return cell
    }
}
