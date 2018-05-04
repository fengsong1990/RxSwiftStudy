//
//  Tool.swift
//  RxSwiftStudy
//
//  Created by fengsong on 2018/5/4.
//  Copyright © 2018年 fengsong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Tool: NSObject {

}

extension Reactive where Base : UILabel{
    public var fontSize : Binder<CGFloat>{
        return Binder(self.base){label,fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
