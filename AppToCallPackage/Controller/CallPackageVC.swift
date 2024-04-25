//
//  CallPackageVC.swift
//  AppToCallPackage
//
//  Created by Onkar Mishra on 24/04/24.
//

import UIKit
import SwiftUI
import MyListPackage

class CallPackageVC: UIViewController {

    @IBOutlet var responseLabel: UILabel!
    
    private var hostingController: UIHostingController<ListView>?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnActionToCallPackage(_ sender: Any) {
        presentListView()
    }

    private func presentListView() {
        let listView = ListView(didSelectEmailAction: { [weak self] selectedEmail in
            self?.updateResponseLabel(selectedEmail)
            self?.dismissListView()
        })
        
        presentListViewWithController(listView)
    }

    private func presentListViewWithController(_ listView: ListView) {
        hostingController = UIHostingController(rootView: listView)
        
        guard let hostingController = hostingController else { return }
        
        addHostingControllerToView(hostingController)
    }

    private func addHostingControllerToView(_ hostingController: UIHostingController<ListView>) {
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        addChild(hostingController)
    }

    private func updateResponseLabel(_ selectedEmail: String) {
        responseLabel.text = selectedEmail
    }

    private func dismissListView() {
        hostingController?.willMove(toParent: nil)
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
    }
}
