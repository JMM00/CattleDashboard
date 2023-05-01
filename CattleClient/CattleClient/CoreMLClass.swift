////
////  CoreMLClass.swift
////  CattleClient
////
////  Created by 전지민 on 2023/04/27.
////
//
//import Foundation
//import Vision
//import UIKit
//import CoreML
//
//class CoreMLClass{
//    func classificationGrade() {
//        // 모델 생성
//        //        let defaultConfig = MLModelConfiguration()
//        let model = try! Cow_classification(configuration: MLModelConfiguration())
//
//        let sourceImage = UIImage(
//            named: "11-1"
//        )!
//
//        // The shortest side
//        let sideLength = min(
//            sourceImage.size.width,
//            224
//        )
//
//        let sourceSize = sourceImage.size
//        let xOffset = (sourceSize.width - sideLength) / 2.0
//        let yOffset = (sourceSize.height - sideLength) / 2.0
//
//        let cropRect = CGRect(
//            x: xOffset,
//            y: yOffset,
//            width: sideLength,
//            height: sideLength
//        ).integral
//
//        let sourceCGImage = sourceImage.cgImage!
//        let croppedCGImage = sourceCGImage.cropping(
//            to: cropRect
//        )!
//
//        let rawImage = UIImage(named: "11-1")
//        rawImage?.ciImage?.cropped(to: cropRect)
//
//        if let image = UIImage(named: "11-2")?.mlMultiArray() {
//            print(image)
//            let input_ = Cow_classificationInput(x_1: image)
//            print(input_)
//            do {
//                let testModel = try model.model.prediction(from: input_)
//            } catch { (error)
//                print("**\(error)")
//            }
//        }
//
//    }
//
//    func classifyImage(image: CIImage) {
//
//        do {
//            let defaultConfig = MLModelConfiguration()
//
//            let imageClassifierWrapper = try? Cow_classification(configuration: defaultConfig)
//
//
//
//            guard let imageClassifier = imageClassifierWrapper else {
//                fatalError("App failed to create an image classifier model instance.")
//            }
//
//            // Get the underlying model instance.
//            let imageClassifierModel = imageClassifier.model
//
//        } catch {
//
//        }
//    }
//}
