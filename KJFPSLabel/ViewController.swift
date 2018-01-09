//
//  ViewController.swift
//  KJFPSLabel
//
//  Created by Kim on 2018/1/8.
//  Copyright © 2018年 Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    private var scheduleTimes = 0
    private var timestamp: Double = 0
    var displayLink: CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell!.imageView!.image = UIImage(named: "00" + String(indexPath.row % 8 + 1))
        cell!.imageView!.layer.cornerRadius = 10
        cell!.imageView!.clipsToBounds = true
        cell!.imageView!.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell!.imageView!.layer.shadowOpacity = 1

        if (indexPath.row % 3 == 0) {
            cell!.textLabel!.text = "上路 巩州遇虎熊五百年前一场疯腾霄又是孙悟空失马 鹰愁涧飞白龙沙河阻断 路难通福陵山中收天"
        } else if (indexPath.row % 3 == 1) {
            cell!.textLabel!.text = "岭上 前行逆黄风七星不照 波月洞千年白骨 化阴风鱼篮 网通天一尾红紫金葫芦二道童九尾老狐敢压龙白虹坠 雪浪击石碎思归 难归 堕回 轮回"
        } else {
            cell!.textLabel!.text = "红霓垂 九重紫云飞久归 未归 欲回 恨回凡胎恰登对 天命难违比丘走白鹿 十三娘情丝缠缚乌袍君生百目庙前拦路自称黄眉老祖"
        }
        
        cell!.textLabel!.backgroundColor = UIColor.clear
        cell!.textLabel!.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell!.textLabel!.layer.shadowOpacity = 1
        cell!.textLabel!.numberOfLines = 0
    
        return cell!
    }
}

// MARK: Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row % 3 == 0) {
            return ("上路 巩州遇虎熊五百年前一场疯腾霄又是孙悟空失马 鹰愁涧飞白龙沙河阻断 路难通福陵山中收天" as NSString).boundingRect(with: CGSize(width: view.frame.size.width, height: 10000), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine], attributes: [.font: UIFont.systemFont(ofSize: 30)], context: nil).size.height
            
        } else if (indexPath.row % 3 == 1) {
            return ("岭上 前行逆黄风七星不照 波月洞千年白骨 化阴风鱼篮 网通天一尾红紫金葫芦二道童九尾老狐敢压龙白虹坠 雪浪击石碎思归 难归 堕回 轮回" as NSString).boundingRect(with: CGSize(width: view.frame.size.width, height: 10000), options: .usesLineFragmentOrigin, attributes: nil, context: nil).size.height
        } else {
            return ("红霓垂 九重紫云飞久归 未归 欲回 恨回凡胎恰登对 天命难违比丘走白鹿 十三娘情丝缠缚乌袍君生百目庙前拦路自称黄眉老祖" as NSString).boundingRect(with: CGSize(width: view.frame.size.width, height: 10000), options: .usesLineFragmentOrigin, attributes: nil, context: nil).size.height
        }
        return 60
    }
}
