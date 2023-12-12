//
//  PhotoSell.swift
//  HomeWorkIOS
//
//  Created by Герман Яренко on 22.11.23.
//

import UIKit

//class PhotoCell: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    let cats = ["cats1","cats2","cats3","cats4","cats5"]
//    var collectionView: UICollectionView!
//    override func viewDidLoad() {
//        let layout = UICollectionViewFlowLayout()
//        
//        
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        
//        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        
//        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
//        
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cats.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
//        cell.catImageView.image = UIImage (named: cats[indexPath.row])
//        return cell
//        }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width/2 - 20  , height: 250)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        print ("cat\(indexPath.row + 1) выбран ")
//    }
//}
//
//
//class CustomCell : UICollectionViewCell {
//    
//    let catImageView = UIImageView()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(catImageView)
//        
//        catImageView.translatesAutoresizingMaskIntoConstraints = false
//        catImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        catImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        catImageView.trailingAnchor.constraint(equalTo:trailingAnchor).isActive = true
//        catImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        
//        
//        catImageView.layer.cornerRadius = 20
//        catImageView.layer.masksToBounds = true
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}







import UIKit

final class PhotoCell: UICollectionViewCell {
    
    private var photoView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(model: Photo) {
        DispatchQueue.global().async {
            if let url = URL(string: model.sizes[1].url ),
               let data = try? Data(contentsOf: url)
            {
                DispatchQueue.main.async {
                    self.photoView.image = UIImage(data: data)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
    }
    
    private func setupViews() {
        addSubview(photoView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: topAnchor),
            photoView.leftAnchor.constraint(equalTo: leftAnchor),
            photoView.rightAnchor.constraint(equalTo: rightAnchor),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
