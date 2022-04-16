import UIKit

class AddDairyViewController: UIViewController {
    
    let placeHolders = ["제목을 입력하세요" , "내용을 입력하세요"]
    let tiltePlaceHodler = "제목을 입력하세요"
    
    lazy var sectionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = sectionTitle
        label.text = "제목"

        return label
    }()
    
    
    lazy var roundedTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.refreshControl?.addTarget(self, action: #selector(titleTextViewHandler), for: .editingChanged)
            
        return textView
    }()
    
    lazy var titleTextView: UITextView = {
        let textView = roundedTextView
        textView.text = placeHolders[0]
        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(roundedTextView)
        
        setTitleSectionLayout()
    }
    
    
    // MARK: Set Components Configuartions
    private func setTitleSectionLayout() {
        /* Title */
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        /* TextView */
        roundedTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        roundedTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        roundedTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    // MARK: UITextView Delegate Actions
    @objc func titleTextViewHandler() {
        print("AIOM")
    }

}

extension AddDairyViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView.tag {
        case 0 :
            if textView.text == placeHolders[0] {
                textView.textColor = .gray
            }
        default :
            print("NOPE")
        }
    }
    
}

