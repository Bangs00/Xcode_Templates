//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

struct ___VARIABLE_reuseIdentifier___CollectionReusableViewModel {

}

class ___VARIABLE_reuseIdentifier___CollectionReusableView: UICollectionReusableView {
    // MARK: - Outlets

    // MARK: - Variables
    private var viewModel: ___VARIABLE_reuseIdentifier___CollectionReusableViewModel? = nil { // 타입은 재정의해서 사용해주세요.
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

extension ___VARIABLE_reuseIdentifier___CollectionReusableView {
    func configure(with viewModel: ___VARIABLE_reuseIdentifier___CollectionReusableViewModel) {
        self.viewModel = viewModel
    }
    // Dynamic Height
    static func fittingSize(_ viewModel: ___VARIABLE_reuseIdentifier___CollectionReusableViewModel, width: CGFloat) -> CGSize {
        guard let view = Bundle.main.loadNibNamed("\(___VARIABLE_reuseIdentifier___CollectionReusableView.self)", owner: self, options: nil)?.first as? ___VARIABLE_reuseIdentifier___CollectionReusableView else {
            return .zero
        }
        view.configure(with: viewModel)

        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        return view.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
    // Dynamic Width
    static func fittingSize(_ viewModel: ___VARIABLE_reuseIdentifier___CollectionReusableViewModel, height: CGFloat) -> CGSize {
        guard let view = Bundle.main.loadNibNamed("\(___VARIABLE_reuseIdentifier___CollectionReusableView.self)", owner: self, options: nil)?.first as? ___VARIABLE_reuseIdentifier___CollectionReusableView else {
            return .zero
        }
        view.configure(with: viewModel)

        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: height)
        return view.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    // Dynamic Width, Height
    static func fittingSize(_ viewModel: ___VARIABLE_reuseIdentifier___CollectionReusableViewModel) -> CGSize {
        guard let view = Bundle.main.loadNibNamed("\(___VARIABLE_reuseIdentifier___CollectionReusableView.self)", owner: self, options: nil)?.first as? ___VARIABLE_reuseIdentifier___CollectionReusableView else {
            return .zero
        }
        view.configure(with: viewModel)

        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: UIView.layoutFittingCompressedSize.height)
        return view.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .fittingSizeLevel)
    }
}
