//
//  Music.swift
//  RxSwiftStudy
//
//  Created by fengsong on 2018/5/4.
//  Copyright © 2018年 fengsong. All rights reserved.
//

import UIKit

//class Music: NSObject {
//
//}

struct Music {
    let name:String //歌名
    let singer :String //演唱者

    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

extension Music : CustomStringConvertible{
    
    var description:String{
        return "name：\(name) singer：\(singer)"
    }
}
