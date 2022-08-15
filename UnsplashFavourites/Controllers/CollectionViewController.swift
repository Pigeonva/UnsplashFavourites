//
//  CollectionViewController.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 07.08.2022.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var searchController = UISearchController()
    var timer: Timer?
    var networkDataFetcher = NetworkDataFetcher()
    var photos = [UnsplashPhoto]()
    let itemPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
        getRandomPhotos()
        setupNavigationBar()
        definesPresentationContext = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    //MARK: - CreateUI
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4,
                                 height: (view.frame.size.width/3)-4)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {return}
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: K.identifierForCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    private func setupSearchBar() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.becomeFirstResponder()
        navigationItem.titleView = searchController.searchBar
    }
    
    private func setupNavigationBar() {
        
        let label = UILabel()
        label.text = "Unsplash"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.identifierForCell, for: indexPath) as! CustomCollectionViewCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        
        return cell
    }
}

//MARK: - UISearchBarDelegate

extension CollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) {[weak self] (photoData) in
                guard let fetchedPhotos = photoData else {return}
                self?.photos = fetchedPhotos.results
                self?.collectionView?.reloadData()
            }
        })
    }
    
    private func getRandomPhotos() {
        
        self.networkDataFetcher.fetchImages(){[weak self] (randomPhotoData) in
            guard let fetchedPhotos = randomPhotoData else {return}
            self?.photos = fetchedPhotos
            self?.collectionView?.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInserts.left * (itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemPerRow
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInserts.left
    }
}

//MARK: - Pass data to DetailViewController

extension CollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        guard let image = cell.photoImageView.image?.pngData() else {return}
        let id = photos[indexPath.item].id
        let detailVC = DetailViewController()
        detailVC.imageView.image = UIImage(data: image)
        detailVC.id = id
        
        let model = PhotoModel(context: context)
        model.image = image; model.name = ""; model.downloads = ""; model.createAt = ""; model.location = ""
        detailVC.collectionModel = model
        detailVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
