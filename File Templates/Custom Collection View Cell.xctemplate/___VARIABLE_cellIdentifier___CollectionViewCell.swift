//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

struct ___VARIABLE_cellIdentifier___CollectionViewCellData {

}

class ___VARIABLE_cellIdentifier___CollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets

    // MARK: - Variables
    private var cellData: ___VARIABLE_cellIdentifier___CollectionViewCellData? = nil { // 타입은 재정의해서 사용해주세요.
        didSet {
            // 데이터 들어오면 여기서 레이아웃 설정하시면 됩니다.
        }
    }
    
    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    // MARK: - Actions

}

extension ___VARIABLE_cellIdentifier___CollectionViewCell {
    func configure(with cellData: ___VARIABLE_cellIdentifier___CollectionViewCellData) {
        self.cellData = cellData
    }
    // Dynamic Height
    static func fittingSize(_ cellData: ___VARIABLE_cellIdentifier___CollectionViewCellData, width: CGFloat) -> CGSize {
        guard let cell = Bundle.main.loadNibNamed("\(___VARIABLE_cellIdentifier___CollectionViewCell.self)", owner: self, options: nil)?.first as? ___VARIABLE_cellIdentifier___CollectionViewCell else {
            return .zero
        }
        cell.configure(with: cellData)

        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        return cell.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
    // Dynamic Width
    static func fittingSize(_ cellData: ___VARIABLE_cellIdentifier___CollectionViewCellData, height: CGFloat) -> CGSize {
        guard let cell = Bundle.main.loadNibNamed("\(___VARIABLE_cellIdentifier___CollectionViewCell.self)", owner: self, options: nil)?.first as? ___VARIABLE_cellIdentifier___CollectionViewCell else {
            return .zero
        }
        cell.configure(with: cellData)

        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: height)
        return cell.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    // Dynamic Width, Height
    static func fittingSize(_ cellData: ___VARIABLE_cellIdentifier___CollectionViewCellData) -> CGSize {
        guard let cell = Bundle.main.loadNibNamed("\(___VARIABLE_cellIdentifier___CollectionViewCell.self)", owner: self, options: nil)?.first as? ___VARIABLE_cellIdentifier___CollectionViewCell else {
            return .zero
        }
        cell.configure(with: cellData)

        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: UIView.layoutFittingCompressedSize.height)
        return cell.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .fittingSizeLevel)
    }
}
