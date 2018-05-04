//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by fengsong on 2018/5/4.
//  Copyright © 2018年 fengsong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    
    let musicListViewModel = MusicListViewModel()
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.tableView)
        self.tableView.addSubview(self.lab)
        lab.backgroundColor = UIColor.red
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        
        //将数据源数据绑定到tableView上
        musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier: "musicCell")){ index , music, cell in
            cell.textLabel?.text = music.name
            cell.detailTextLabel?.text = music.singer
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { (music) in
            
            print("你选中的歌曲信息【\(music.description)】")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        
        test4()
    }
    
    
    fileprivate lazy var tableView : UITableView = {
        let tempTableView = UITableView (frame: self.view.bounds, style:.plain)
        //        tempTableView.delegate = self
        //        tempTableView.dataSource = self
        tempTableView.backgroundColor = UIColor.green
        tempTableView.separatorStyle = .singleLine
        return tempTableView
    }()
    
    let lab = UILabel.init(frame: CGRect.init(x: 0, y: 20, width: 200, height: 30))
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




extension ViewController{
    
    
    
    fileprivate func test4(){
        
        lab.text = "对 UILabel 进行扩展"
        let observable1  = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable1.map{ CGFloat($0) }
        .bind(to: lab.rx.fontSize)
        .disposed(by: disposeBag)
    }
    /*
     相较于 AnyObserver 的大而全，Binder 更专注于特定的场景。Binder 主要有以下两个特征：
     不会处理错误事件
     确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
     */
    fileprivate func test3(){
        
        let observable1  = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        let observable2 : Binder<String> = Binder(self.tableView){ [weak self](tablew1 , text1) in
            
            //****==8
            self?.lab.text = text1
            print("Value==\(text1)")
            
        }
        
        observable1.map { (value) -> String in
            return "****==\(value)"
            }
            .bind(to: observable2).disposed(by: disposeBag)
    }
    
    fileprivate func test2(){
        
        let observable1  = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable1
            .map { (value) -> String in
                return "****==\(value)"
            }.bind { [weak self](text) -> Void in
                print("\(text)")
            }
            .disposed(by: disposeBag)
        
        /*
         .map { "当前索引数：\($0 )"}
         .bind { [weak self](text) in
         //收到发出的索引数后显示到label上
         print("\(text)")
         }
         .disposed(by: disposeBag)
         */
        
        //**********************************
        let observable2 : AnyObserver<String> = AnyObserver{ (event) in
            
            switch event{
            case .next(let text):
                print("observable ==\(text)")
            case .error(_):
                print("error")
            case .completed:
                print("completed")
            }
        }
        
        observable1.map { (value) -> String in
            return "****==\(value)"
            }.bind(to: observable2).disposed(by: disposeBag)
        //**********************************
        
        
    }
    
    fileprivate func test1(){
        let observable = Observable.of("A", "B", "C")
        
        observable
            .do(onNext: { element in
                print("Intercepted Next：", element)
            }, onError: { error in
                print("Intercepted Error：", error)
            }, onCompleted: {
                print("Intercepted Completed")
            }, onDispose: {
                print("Intercepted Disposed")
            })
            .subscribe(onNext: { element in
                print(element)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            }).disposed(by: disposeBag)
    }
}

