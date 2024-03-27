//
//  BaseViewController.swift
//  Gutter
//
//  Created by Dev Team on 16/03/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityViewController: UIActivityViewController?
    weak var activityDelegate: ActivityViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        activityViewController?.popoverPresentationController?.sourceRect = CGRect(origin: center, size: CGSize(width: 0, height: 0))
    }

    func showDownloadedFile(fileName:String){
        let documentsUrl:URL = (FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        do {
            //Mark: Show UIActivityViewController to save the downloaded file
            let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for indexx in 0..<contents.count {
                if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                    activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                    activityViewController?.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
                        if completed {
                            // The activity was completed (shared or performed)
                            self.activityDelegate?.activityViewControllerDismissed()
                            print("Activity completed")
                        } else {
                            // The activity was dismissed
                            self.activityDelegate?.activityViewControllerDismissed()
                            print("Activity dismissed")
                        }
                    }
                    DispatchQueue.main.async {
                        if let popoverController = self.activityViewController?.popoverPresentationController {
                            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                            popoverController.sourceView = self.view
                            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                        }
                        self.present(self.activityViewController!, animated: true, completion: nil)
                    }
                }
            }
        }catch (let err) {
            print("error: \(err)")
        }
    }
}
protocol ActivityViewControllerDelegate: AnyObject {
    func activityViewControllerDismissed()
}
