//
//  ViewController.swift
//  TableView_practice
//
//  Created by dhui on 11/28/23.
//

import UIKit

protocol NibCellDelegate: AnyObject {
    func nibCellSwitchChangedEvent(id: String, isOn: Bool)
    func onDeleteItemClicked(id: String)
}

/// AddPopUp에서 완료 버튼 누르면 textField 내용 받아오기
protocol AddPopUpDelegate: AnyObject {
    func onSubmitBtnClicked(newTodo: String)
}

class ViewController: UIViewController, NibCellDelegate, AddPopUpDelegate {
    func onDeleteItemClicked(id: String) {
        if let foundIndex = data.firstIndex(of: id) {
            let foundIndexPath = IndexPath(row: foundIndex, section: 0)
            data.remove(at: foundIndexPath.row)
            
            myTableView.deleteRows(at: [foundIndexPath], with: .automatic)
        }
        
    }
    
    
    func onDeleteBtnClicked(_ tag: Int) {
        print(#fileID, #function, #line, "- tag: \(tag)")
        let storyboard = UIStoryboard(name: "DeletePopUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DeletePopUp")
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    
    var data: [String] = []
    
    var selectedIds: Set<String> = [] {
        didSet {
            print(#fileID, #function, #line, "- selectedIds: \(selectedIds)")
        }
    }
    
    var newString: String? = nil
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var textFieldView: UIView!
    
    @IBOutlet weak var textFieldStackView: UIStackView!
    
    @IBOutlet weak var textFieldStackViewTrailingAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let button: UIButton = UIButton(type: .close)
    
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        configureTableView()
        searchTextField.delegate = self
        searchTextField.borderStyle = .none
        button.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        #warning("TODO: - 질문 delegate self가 잘 타지 않는 부분에 대해서")
//        AddPopUp(nibName: "AddPopUp", bundle: nil).delegate = self
        
        let test = self
        
    }
    
    func nibCellSwitchChangedEvent(id: String, isOn: Bool) {
        print(#fileID, #function, #line, "- id: \(id), isOn: \(isOn)")
        
        if isOn {
            selectedIds.insert(id)
        } else {
            selectedIds.remove(id)
        }
    }
    
    func onSubmitBtnClicked(newTodo: String) {
        print(#fileID, #function, #line, "- newTodo: \(newTodo)")
        data.insert(newTodo, at: 0)
        
        let newIndexPath = IndexPath(row: 0, section: 0)
        myTableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    @IBAction func selectedDelete(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        // 선택된 데이터 삭제
        // 1. 선택된 인덱스들 변수에 담기
        
        
        
        let foundIndexes : [Int] = selectedIds.compactMap { anId in
            return data.firstIndex(of: anId)
        }
        
        // filter
        data = data.filter { anItem in
            !selectedIds.contains(anItem)
        }
        
        // 2. 데이터에서 변수의 인덱스 찾기
//        foundIndexes.forEach { anIndex in
//            data.remove(at: anIndex)
//        }
        
        let foundIndexPathArray: [IndexPath] = foundIndexes.map { anIndex in
            return IndexPath(row: anIndex, section: 0)
        }
        
        selectedIds.removeAll()
        
        print(#fileID, #function, #line, "- foundIndexPathArray: \(foundIndexPathArray)")
        
        myTableView.deleteRows(at: foundIndexPathArray, with: .fade)
        
//        myTableView.reloadData()
        
        // 3. 찾은 인덱스 삭제하기
        
    }
    
    fileprivate func configureTableView() {
        
        let cellNib = UINib(nibName: "NibCell", bundle: nil)
        
        self.myTableView.register(cellNib, forCellReuseIdentifier: "NibCell")
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
    }
    
    #warning("TODO: - tableView data update")
    @IBAction func onFilterBtnClicked(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        let wholeAction = UIAlertAction(title: "전체", style: .default) { (action) in
            
        }
        alertController.addAction(wholeAction)
        
        let doneAction = UIAlertAction(title: "완료", style: .default) { (action) in
            
        }
        alertController.addAction(doneAction)
        
        let notDoneAction = UIAlertAction(title: "미완료", style: .default) { (action) in
            
        }
        alertController.addAction(notDoneAction)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func onAddBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        
//        for index in 0..<50 {
//            data.append(UUID().uuidString)
//        }
//        
//        myTableView.reloadData()
        
        // 1. 스토리보드 가져오기
        let storyboard : UIStoryboard = UIStoryboard(name: "AddPopUp", bundle: nil)
        // 2. 스토리보드 통해서 뷰컨트롤러 가져오기
        guard let addPopUpVC = storyboard.instantiateViewController(withIdentifier: "AddPopUp") as? AddPopUp else {
            return
        }
        addPopUpVC.modalPresentationStyle = .overCurrentContext
        addPopUpVC.modalTransitionStyle = .crossDissolve
        addPopUpVC.delegate = self
        
        self.present(addPopUpVC, animated: true)
    }
    
}

extension ViewController: UITextFieldDelegate {
    // 목표: textfield 선택하면 옆에 x 버튼 띄우기
    // 1. textfield 선택 감지
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchTextField {
            print("You edit searchTextField")
            // 2. textfield 선택 true -> textfield width 조정
            searchMode(on: true, animated: true)
            // 3. textfield 옆 x 버튼 스택뷰로 넣기
            self.textFieldView.addSubview(self.button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor, constant: 13),
                button.topAnchor.constraint(equalTo: textFieldView.topAnchor),
                button.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor),
                button.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor)
            ])
        }
    }
    
    func textFieldTouchUpInside() -> Bool {
        return textFieldStackViewTrailingAnchor.constant > 0
    }
    
    func searchMode(on: Bool, animated: Bool) {
        print(#fileID, #function, #line, "- 됐다")
        if on == textFieldTouchUpInside() { return }

        let htrailConst: CGFloat = on ? 53 : 0
        let alpha: CGFloat = on ? 1.0 : 0
        let duration: TimeInterval = animated ? 0.5 : 0

        view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.textFieldStackViewTrailingAnchor.constant = htrailConst
            self?.button.alpha = alpha
            self?.view.layoutIfNeeded()
        })
    }
    
    // 4. x 버튼 클릭 -> textfield 내용 지우기
    @objc func btnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- button")
        searchTextField.text = ""
        searchMode(on: false, animated: true)
    }
}

//MARK: - tableView datasource 관련
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data.count)
        return data.count
    }
    
//    var closure: ((_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell)? = nil
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NibCell", for: indexPath) as? NibCell else {
            return UITableViewCell()
        }
        
        let cellData = data[indexPath.row]
        print(#fileID, #function, #line, "- cellData: \(cellData)")
        cell.cellData = cellData
        cell.indexPath = indexPath
        
        cell.viewController = self
        
        let isSelected = self.selectedIds.contains(cellData)
        cell.configureCell(isSelected: isSelected)
        
        cell.titleLabel.text = data[indexPath.row]
        cell.deleteBtn.tag = indexPath.row
        
//        let addPopUp = AddPopUp(nibName: "AddPopUp", bundle: nil)
//        
//        addPopUp.delegate = self
        return cell
    }
   
    
    
    
//    func addNewItem(_ newItem: String) {
//        
//        // Step 1: Update your data model
//        data.insert(newItem, at: 0)
//
//        // Step 2: Insert new row in the table view
//        let newIndexPath = IndexPath(row: data.count - 1, section: 0)
//        myTableView.insertRows(at: [newIndexPath], with: .automatic)
//    }
    
}

//MARK: - tableView delegate 관련
extension ViewController: UITableViewDelegate {
    
}

