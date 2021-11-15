//
//  ArticleCell.swift
//  maroschupkina_1PW5
//
//  Created by Marina Roshchupkina on 09.11.2021.
//

import UIKit
class ArticleCell: UITableViewCell {
    
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    var previewView: UIView?
    var shadowView: UIView?
    var labelsView: UIView?
    private var image: UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupCell() {
        let previewView = UIView()
        let shadowView = UIView()
        
        self.backgroundColor = .clear
        previewView.backgroundColor = .black
        previewView.layer.cornerRadius = 10
        previewView.layer.masksToBounds = true
        
        self.addSubview(shadowView)
        self.addSubview(previewView)
        
        shadowView.layer.masksToBounds = false
        shadowView.backgroundColor = .systemGray
        shadowView.layer.shadowColor = UIColor.systemGray.cgColor
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.cornerRadius = 10
        
        shadowView.pinTop(to: self, 20)
        shadowView.pinBottom(to: self, 20)
        shadowView.pinLeft(to: self, 20)
        shadowView.pinRight(to: self, 20)
        
        previewView.pinTop(to: self, 20)
        previewView.pinBottom(to: self, 20)
        previewView.pinLeft(to: self, 20)
        previewView.pinRight(to: self, 20)
        
        self.previewView = previewView
        self.shadowView = shadowView
        
        setupLabels()
        setupImage()
        selectionStyle = .none
    }
    
    private func setupLabels() {
        let labelsView = UIView()
        previewView?.addSubview(labelsView)
        labelsView.backgroundColor = UIColor.white //UIColor(red: 235/255, green: 255/255, blue: 253/255, alpha: 1)
        labelsView.pinBottom(to: previewView!)
        labelsView.pinLeft(to: previewView!)
        labelsView.pinRight(to: previewView!)
        labelsView.setHeight(to: 120)
        self.labelsView = labelsView
        
        let titleLabel = UILabel()
        labelsView.addSubview(titleLabel)
        titleLabel.pinTop(to: labelsView, 10)
        titleLabel.pinLeft(to: labelsView, 10)
        titleLabel.pinRight(to: labelsView, 10)
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        titleLabel.textColor = .black
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .left
        
        let descriptionLabel = UILabel()
        labelsView.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor)
        descriptionLabel.pinLeft(to: labelsView, 10)
        descriptionLabel.pinBottom(to: labelsView, 10)
        descriptionLabel.pinRight(to: labelsView, 10)
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        descriptionLabel.textColor = .black
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .left
        
        self.titleLabel = titleLabel
        self.descriptionLabel = descriptionLabel
    }
    
    private func setupImage() {
        let image = UIImageView()
        previewView!.addSubview(image)
        image.pinTop(to: previewView!)
        image.pinBottom(to: labelsView!.topAnchor)
        image.pinLeft(to: previewView!)
        image.pinRight(to: previewView!)
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        self.image = image
    }
    
    
    func setImage(image: UIImage?) {
        self.image?.image = image
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
