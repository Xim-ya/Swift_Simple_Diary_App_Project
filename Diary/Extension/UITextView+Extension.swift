import UIKit

extension AddEditDiaryViewController: UITextViewDelegate {
    
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
            validationCheck()
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
            validationCheck()
            if updatedText.count > maxCh {
                showAlert(title: "경고", message: "최대 입력 가능한 문자를 초과했습니다")
                return false
            } else {
                return updatedText.count <= maxCh
            }
            
        }
        return true
    }
    

    // Alert Dialog
        func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(confirmBtn)
        present(alert, animated: true, completion: nil)
    }
}




