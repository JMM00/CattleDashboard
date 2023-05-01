/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The view controller that selects an image and makes a prediction using Vision and Core ML.
*/

import UIKit
import FirebaseStorage
import FirebaseFirestoreSwift

class MainViewController: UIViewController {
    var firstRun = true

    /// A predictor instance that uses Vision and Core ML to generate prediction strings from a photo.
    let imagePredictor = ImagePredictor()

    /// The largest number of predictions the main view controller displays the user.
    let predictionsToShow = 1

    // MARK: Main storyboard outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    @IBOutlet weak var aiGrade: UILabel!
    
    @IBOutlet weak var historyNum: UITextField!
    
    @IBOutlet weak var finalGrade: UITextField!
    @IBOutlet weak var meatQuality: UITextField!
    @IBOutlet weak var fatGrade: UITextField!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var fatColor: UITextField!
    @IBOutlet weak var organization: UITextField!
    @IBOutlet weak var maturity: UITextField!
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var month: UITextField!
    @IBOutlet weak var totalWeight: UITextField!
    @IBOutlet weak var predictedBreedingRate: UITextField!
    @IBOutlet weak var unitPrice: UITextField!
    @IBOutlet weak var buying: UITextField!
    
}


extension MainViewController {
    // MARK: Main storyboard actions
    /// The method the storyboard calls when the user one-finger taps the screen.
    
    @IBAction func defaultInfoButton() {
        historyNum.text = "002142700199"
        finalGrade.text = "1+"
        color.text = "1++"
        fatColor.text = "1++"
        fatGrade.text = "1+"
        maturity.text = "1++"
        meatQuality.text = "1++"
        organization.text = "1+"
        
        number.text = "1"
        gender.text = "거세"
        month.text = "36"
        totalWeight.text = "486"
        predictedBreedingRate.text = "66.24"
        unitPrice.text = "30270"
        buying.text = "1"
    }
    
    @IBAction func selectPhoto() {
        present(photoPicker, animated: false)
    }
    
    @IBAction func takePhoto(){
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            present(photoPicker, animated: false)
            return
        }

        present(cameraPicker, animated: false)
    }
}

extension MainViewController {
    // MARK: Main storyboard updates
    /// Updates the storyboard's image view.
    /// - Parameter image: An image.
    func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    /// Updates the storyboard's prediction label.
    /// - Parameter message: A prediction or message string.
    /// - Tag: updatePredictionLabel
    func updatePredictionLabel(_ message: String) {
        DispatchQueue.main.async {
            self.predictionLabel.text = message
            self.aiGrade.text = self.getGrade(message: message)
            
        }

        if firstRun {
            DispatchQueue.main.async {
                self.firstRun = false
                self.predictionLabel.superview?.isHidden = false
            }
        }
    }
    func getGrade(message: String) -> String {
        if let firstCharacter = message.first {
            switch firstCharacter {
            case "0":
                return "1"
            case "1":
                return "2"
            case "2":
                return "3"
            case "3":
                return "1++"
            case "4":
                return "1+"
            default:
                return "잘못된 사진"
            }
        }
        return ""
    }
    /// Notifies the view controller when a user selects a photo in the camera picker or photo library picker.
    /// - Parameter photo: A photo from the camera or photo library.
    func userSelectedPhoto(_ photo: UIImage) {
        updateImage(photo)
        updatePredictionLabel("Making predictions for the photo...")

        DispatchQueue.global(qos: .userInitiated).async {
            self.classifyImage(photo)
        }
    }

}

extension MainViewController {
    // MARK: Image prediction methods
    /// Sends a photo to the Image Predictor to get a prediction of its content.
    /// - Parameter image: A photo.
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    /// The method the Image Predictor calls when its image classifier model generates a prediction.
    /// - Parameter predictions: An array of predictions.
    /// - Tag: imagePredictionHandler
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            updatePredictionLabel("No predictions. (Check console log.)")
            return
        }

        let formattedPredictions = formatPredictions(predictions)

        let predictionString = formattedPredictions.joined(separator: "\n")
        updatePredictionLabel(predictionString)
    }

    /// Converts a prediction's observations into human-readable strings.
    /// - Parameter observations: The classification observations from a Vision request.
    /// - Tag: formatPredictions
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            return "\(name) - \(prediction.confidencePercentage)%"
        }

        return topPredictions
    }
    
    func setData(model: Any) {
        switch model {
        case _ as Shortcuts:
            db.collection("Shortcut").document((model as! Shortcuts).id).setData((model as! Shortcuts).dictionary)
        case _ as Curation:
            db.collection("Curation").document((model as! Curation).id).setData((model as! Curation).dictionary)
        case _ as User:
            db.collection("User").document((model as! User).id).setData((model as! User).dictionary)
        case _ as Comments:
            db.collection("Comment").document((model as! Comments).id).setData((model as! Comments).dictionary)
        default:
            print("this is not a model.")
        }
    }
}
