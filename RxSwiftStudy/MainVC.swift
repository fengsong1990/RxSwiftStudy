//
//  MainVC.swift
//  RxSwiftStudy
//
//  Created by fengsong on 2018/6/4.
//  Copyright © 2018年 fengsong. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class MainVC: UIViewController {

    @IBOutlet weak var tableList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let items = Observable.just([
            "歌曲",
            "Tablew的操作",
            "Maya网络集中管理"
            ])
        

        items.bind(to: tableList.rx.items(cellIdentifier: "cell")){index,str,cell in
            
            cell.textLabel?.text = str
        }
        
        tableList.rx.itemSelected.subscribe { index in
            
            let indexValue : Int = index.element!.row
            var _VC : UIViewController!
            let story1 = UIStoryboard.init(name: "Main", bundle: nil)
            if indexValue == 0{
                 _VC = ViewController()
            }else if indexValue == 1{
                 _VC = story1.instantiateViewController(withIdentifier: "second")
            }else if indexValue == 2{
                _VC = MoyaVC()
            }
            self.navigationController?.pushViewController(_VC, animated: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
