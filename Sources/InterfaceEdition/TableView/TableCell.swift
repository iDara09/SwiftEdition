import UIKit


open class TableCell: UITableViewCell {
    
    public let contentContainer = UIStackView()
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentContainer()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupContentContainer() {
        contentView.addAutoLayoutSubview(contentContainer)
        contentContainer.constraint(fill: contentView)
    }
}


extension TableCell: TableCollectionContentContainer {}
