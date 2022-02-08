import UIKit

class SeriesDetailViewCell: UITableViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    var item: VMseriesItem? {
        didSet {
            if let item = item as? VMseriesDetailPremiereDateItem {
                keyLabel.text = item.sectionTitle
                valueLabel.text = dateToString(date: item.premiereDate, locale: Locale(identifier: "ru_RU"), dateFormat: "dd MMMM yyyy г.")
            }
            
            if let item = item as? VMseriesDetailChannelCountryItem {
                keyLabel.text = item.sectionTitle
                valueLabel.text = "\(item.channels) (\(item.country))"
            }
            
            if let item = item as? VMseriesDetailRatingIMDbItem {
                keyLabel.text = item.sectionTitle
                valueLabel.text = String(format: "%.1f", item.ratingIMDb)
            }
            
            if let item = item as? VMseriesDetailGenreItem {
                keyLabel.text = item.sectionTitle
                valueLabel.text = item.genre
            }
            
            if let item = item as? VMseriesDetailTypeItem {
                keyLabel.text = item.sectionTitle
                valueLabel.text = item.typeName
            }
            
            if let item = item as? VMseriesDetailOfficialSiteItem {
                keyLabel.text = item.sectionTitle
                valueLabel.text = item.officialSiteUrl.absoluteString
            }
        }
    }
    
    class var reuseIdentifier: String {
//        String(describing: self)
        "SeriesDetailViewCell"
    }
    
    class var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        translatesAutoresizingMaskIntoConstraints = false
    }
}
