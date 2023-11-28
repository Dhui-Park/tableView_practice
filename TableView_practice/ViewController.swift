//
//  ViewController.swift
//  TableView_practice
//
//  Created by dhui on 11/28/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var textFieldView: UIView!
    
    @IBOutlet weak var textFieldStackView: UIStackView!
    
    @IBOutlet weak var textFieldStackViewTrailingAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let button: UIButton = UIButton(type: .close)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        configureTableView()
        searchTextField.delegate = self
        searchTextField.borderStyle = .none
    }
    
    fileprivate func configureTableView() {
        
        let cellNib = UINib(nibName: "NibCell", bundle: nil)
        
        self.myTableView.register(cellNib, forCellReuseIdentifier: "NibCell")
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
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
}

//MARK: - tableView datasource 관련
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NibCell", for: indexPath) as? NibCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}

//MARK: - tableView delegate 관련
extension ViewController: UITableViewDelegate {
    
}
