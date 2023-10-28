//
//  ConfirmNavigationController.swift
//  metroTextGame
//
//  Created by Павел Петров on 28.10.2023.
//

import UIKit

class ConfirmationNavigationController: NSObject, UINavigationControllerDelegate {
    var shouldAskForConfirmation = true

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if shouldAskForConfirmation {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(confirmBackAction))
        }
    }

    @objc func confirmBackAction() {
        let alert = UIAlertController(
            title: "Подтверждение",
            message: "Вы уверены, что хотите вернуться?",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        let confirmAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            // Выбрано "Да", выполняйте действия, которые нужно выполнить при нажатии "Back"
            self?.shouldAskForConfirmation = false
            self?.navigationController.popViewController(animated: true)
        }

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)

        navigationController.topViewController?.present(alert, animated: true, completion: nil)
    }

    func navigationController(_ navigationController: UINavigationController, shouldPop viewController: UIViewController) -> Bool {
        if shouldAskForConfirmation {
            // Возвращаем false, чтобы предотвратить фактический переход
            return false
        } else {
            // Разрешаем фактический переход
            return true
        }
    }
}

