//
//  PostModel.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import RxSwift

class ResponseModel {

    private let networkDataFetch: DataFetcher
    private let hardCodedAnswerModel: HardCodedAnswerModel
    private let storageAnswer: PersistenceStore
    private let disposeBag = DisposeBag()

    let answer = BehaviorSubject<Answer?>(value: nil)
    let loading = PublishSubject<Bool>()
    let shakeAction = PublishSubject<Void>()

    init(networkDataFetch: NetworkDataFetcher,
         hardCodedAnswerModel: HardCodedAnswerModel,
         storageAnswer: StorageAnswerService) {
        self.networkDataFetch = networkDataFetch
        self.hardCodedAnswerModel = hardCodedAnswerModel
        self.storageAnswer = storageAnswer
        setupBindigns()
    }

    private func setupBindigns() {
        shakeAction.subscribe(onNext: { [weak self] in
            self?.requestData()
        }).disposed(by: disposeBag)
    }

    func requestData() {
        self.loading.onNext(true)
        networkDataFetch.dataAnswerFetch(urlString: L10n.URLstring.answerURL) { (response, error) in
            self.loading.onNext(false)
            if error != nil {
                let answer = self.hardCodedAnswerModel.getSavedAnswer()
                self.answer.onNext(answer)
            } else {
                self.storageAnswer.saveAnswer(answer: response)
                self.answer.onNext(response)
            }
        }
    }
}
