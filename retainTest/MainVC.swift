//
//  ViewController.swift
//  retainTest
//
//  Created by 林智浩 on 2017/10/24.
//  Copyright © 2017年 林智浩. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.mLay(size: CGSize(width: 100, height: 50))
        button.mLayCenterXY()
        button.setTitle("到下一頁", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(TapButton(_:)), for: .touchUpInside)
    }

    @objc func TapButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(TableVC(), animated: true)
    }
}

class TableVC: UIViewController {

    let tableView = UITableView()
    let cellIdentifier = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.mLay(pin: .zero)
        tableView.register(BlockCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
    }
    
    deinit {
        print("\(type(of: self)) deinit")
    }
}

extension TableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! BlockCell
        cell.textLabel?.text = "\(indexPath.row)"
        cell.block = {
            // 若是註解掉 print 就會正常執行 deinit
            print(self.tableView)
        }
        return cell
    }
}

class BlockCell: UITableViewCell {
    var block: (() -> ())?
}
