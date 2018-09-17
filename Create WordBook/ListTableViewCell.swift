//
//  ListTableViewCell.swift
//  Create WordBook
//
//  Created by 中重歩夢 on 2018/09/11.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import FoldingCell

class ListTableViewCell: FoldingCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
       
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
