//
//  BoxViewController.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 30.10.22.
//

import UIKit

class BoxViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CircleCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BoxItemCell.self, forCellWithReuseIdentifier: BoxItemCell.reuseIdentifire)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition(in: view) { _ in
            self.collectionView.performBatchUpdates(nil)
        }
    }
    
    private func getScene(_ scene: Scene) -> UIViewController {
        switch scene {
        case .currencyConverter:
            let vc = CurrencyConverterViewController()
            vc.viewModel = CurrencyConverterViewModel(viewController: vc)
            return vc
        }
    }

}

extension BoxViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Stuff.stuff.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxItemCell.reuseIdentifire, for: indexPath) as? BoxItemCell else {
            fatalError()
        }
        cell.setupCell(Stuff.stuff[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = getScene(Stuff.stuff[indexPath.row].controller)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

import SwiftUI

struct Provider: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        let controller = BoxViewController()
        func makeUIViewController(context: Context) -> BoxViewController {
            return controller
        }
        
        func updateUIViewController(_ uiViewController: BoxViewController, context: Context) {
            
        }
    }
}
