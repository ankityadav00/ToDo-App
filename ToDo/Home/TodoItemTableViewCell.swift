
import UIKit

class TodoItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    var isCheck: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func checkButton(_ sender: UIButton) {
        if checkImage.image != nil {
            // Remove the image
            checkImage.image = nil
        } else {
            // Set the image (replace "yourImageName" with the actual image name)
            checkImage.image = UIImage(named: "check")
        }
        isCheck = sender.isSelected
    }
}
