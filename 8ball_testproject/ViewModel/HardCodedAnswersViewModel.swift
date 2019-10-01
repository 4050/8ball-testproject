//
//  HardCodedAnswerViewModel.swift
//  8ball_testproject
//
//  Created by Станислав on 01/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import UIKit

class HardCodedAnswersViewModel {

    private let hardCodedAnswersModel: HardCodedAnswersModel

    init(hardCodedAnswersModel: HardCodedAnswersModel) {
        self.hardCodedAnswersModel = hardCodedAnswersModel
    }
}

extension HardCodedAnswersViewModel {
    func getDefaultAnswer() -> [String] {
       return hardCodedAnswersModel.motivationAnswers
    }
}