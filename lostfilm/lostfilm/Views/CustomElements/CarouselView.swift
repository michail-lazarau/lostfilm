import UIKit

@IBDesignable
class CarouselView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Subviews
    
    private lazy var carouselCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(CarouselCollectionViewCell.nib, forCellWithReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier)
        collection.backgroundColor = .clear
        return collection
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()

    // MARK: - Properties
    
    private var carouselData: LFPhotoListContentItemModel?
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }

    // MARK: - Initializators

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
        setupPageControl()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupPageControl()
    }
}

// MARK: - UICollectionViewDataSource

extension CarouselView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData?.photoURLs.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier, for: indexPath) as? CarouselCollectionViewCell else {
            return UICollectionViewCell()
        }

        let url = carouselData!.photoURLs[indexPath.row] // FIXME: force wrapping
        cell.configure(by: url)
        return cell
    }
}

extension CarouselView {
    public func configureView(with data: LFPhotoListContentItemModel) {
        carouselData = data
        pageControl.numberOfPages = data.photoURLs.count
        carouselCollectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate

extension CarouselView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

// MARK: - Helpers

private extension CarouselView {
    func setupCollectionView() {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 16 * 9)
        carouselLayout.sectionInset = .zero
        carouselLayout.minimumLineSpacing = 0
        carouselCollectionView.collectionViewLayout = carouselLayout
        
        addSubview(carouselCollectionView)
        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carouselCollectionView.topAnchor.constraint(equalTo: topAnchor),
            carouselCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func setupPageControl() {
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 16),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }

        return currentPage
    }
}
