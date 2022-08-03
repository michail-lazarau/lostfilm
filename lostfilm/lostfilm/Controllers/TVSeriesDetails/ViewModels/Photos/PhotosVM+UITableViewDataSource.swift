import Foundation

extension PhotosVM: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = itemList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesPhotoViewCell.reuseIdentifier, for: indexPath) as? SeriesPhotoViewCell
        cell?.item = item
        return cell ?? UICollectionViewCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
