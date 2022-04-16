import UIKit

class AddDairyViewController: UIViewController {
    
    let placeHolders = ["제목을 입력하세요" , "내용을 입력하세요", "날짜를 선택하세요"]
    
    lazy var titleLabel: UILabel = {
        let label = sectionTitleLabelAttr("제목")
        
        return label
    }()
    
    
    lazy var globalTitleAttr: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contentTitle: UILabel = {
        let label = globalTitleAttr
        label.text = "컨텐츠"
        
        return label
    }()
    
    lazy var contentTitleLabel: UILabel = {
        let label = sectionTitleLabelAttr("내용")
        
        return label
    }()
    
    lazy var dateTitleLabel: UILabel = {
        let label = sectionTitleLabelAttr("날짜")
        
        return label
    }()
    
    lazy var contentTextView: UITextView = {
        let textView = roundTableViewAttr()
        textView.delegate = self
        textView.text = placeHolders[1]
        textView.tag = 1
        
        return textView
    }()
    
    lazy var titleTextView: UITextView = {
        let textView = roundTableViewAttr()
        textView.delegate = self
        textView.text = placeHolders[0]
        textView.tag = 0
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineBreakMode = .byClipping
        
        return textView
    }()
    
    lazy var dateTextView: UITextView = {
        let textView = roundTableViewAttr()
        textView.delegate = self
        textView.text = "날짜를 선택하세요"
        textView.tag = 2
        textView.isEditable = false
        textView.textContainer.maximumNumberOfLines = 1
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(datePickerInputHandler))
        textView.addGestureRecognizer(gesture)
        
        return textView
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(titleTextView)
        view.addSubview(contentTitleLabel)
        view.addSubview(contentTextView)
        view.addSubview(dateTitleLabel)
        view.addSubview(dateTextView)
        
        setTitleSectionLayout()
        setContentSectionLayout()
    }
    
    
    // MARK: Set Components Configuartions
    private func setContentSectionLayout() {
    }
    
    private func setTitleSectionLayout() {
        /* Title */
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        /* TextView */
        titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        titleTextView.layoutIfNeeded()
        
        /* Title */
        contentTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentTitleLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 40).isActive = true
        
        /* TextView */
        contentTextView.topAnchor.constraint(equalTo: contentTitleLabel.bottomAnchor, constant: 6).isActive = true
        contentTextView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        contentTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        /* Title */
        dateTitleLabel.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 40).isActive = true
        dateTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        /* TextView*/
        dateTextView.topAnchor.constraint(equalTo: dateTitleLabel.bottomAnchor, constant: 6).isActive = true
        dateTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        dateTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
    }
    
    // MARK: Reusble Attribute Functions
    func sectionTitleLabelAttr(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func roundTableViewAttr() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .gray
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.isScrollEnabled = false
        
        return textView
    }
    
    
    
    // MARK: INTENTS
    @objc func datePickerInputHandler() {
        showDatePickerAlert()
    }
    
    
    private func showDatePickerAlert() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
        
        let dateChooserAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(datePicker)
        dateChooserAlert.addAction(UIAlertAction(title: "선택완료", style: .cancel, handler: { action in
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyys년 MM월 dd일"
            let formattedDateString = dateFormatter.string(from: selectedDate)
            self.dateTextView.text = formattedDateString
            self.dateTextView.textColor = .black
        }))
        dateChooserAlert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        present(dateChooserAlert, animated: true, completion: nil)

    }

    
}

extension AddDairyViewController: UITextViewDelegate {
        
    // Set TextFiled Interaction Effect.
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView.tag {
        case 0 :
            if titleTextView.text == placeHolders[0] {
                titleTextView.text = nil
                titleTextView.textColor = .black
            }
        case 1 :
            if contentTextView.text == placeHolders[1] {
                contentTextView.text = nil
                contentTextView.textColor = .black
            }
     
        
            
            
        default :
            print("Doesn't Match")
        }
    }
    
    // Reset to TextField Initial Condition If User Doesn't Filled Any Text
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView.tag {
        case 0:
            setInputFieldInteraction(aimTextView: titleTextView, tag: 0)
        case 1:
            setInputFieldInteraction(aimTextView: contentTextView, tag: 1)
        case 2:
            setInputFieldInteraction(aimTextView: dateTextView, tag: 2)
        default :
            print("Doesn't Match")
        }
        
        func setInputFieldInteraction(aimTextView: UITextView, tag: Int) {
            if aimTextView.text.isEmpty {
                aimTextView.text = placeHolders[tag]
                aimTextView.textColor = .gray
            }
        }
    }

    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        switch textView.tag {
        case 0:
            let result = setTextInputCondition(aimTextView: titleTextView, maxCh: 24)
            return result
        case 1:
            let result = setTextInputCondition(aimTextView: contentTextView, maxCh: 240)
            return result
            
        default :
            print("Doesn't Match")
        }
        
        /* Set Max Character Lenght Condition ANd Show Alert Dialog if it needed */
        func setTextInputCondition(aimTextView: UITextView, maxCh: Int) -> Bool {
            let currentText = aimTextView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
            if updatedText.count > maxCh {
                showMaxCharCountAlert()
                return false
            } else {
                return updatedText.count <= maxCh
            }
            
        }
        return true
    }
    
    /* Alert Dialog */
    private func showMaxCharCountAlert() {
        let alert = UIAlertController(title: "경고", message: "최대 입력 가능한 문자를 초과했습니다.", preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(confirmBtn)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
}

