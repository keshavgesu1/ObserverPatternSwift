//
//  ViewController.swift
//  ObserverPatternSwift
//
//  Created by Keshav Raj Kashyap on 29/11/21.
//

import UIKit
import RxCocoa
import RxSwift


class ViewController: UIViewController {

    
    let heySequence = Observable.from(["h","e","y"])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        behaviourRelay()
        subscription()
        disposeBag()
        
        
    }
    
    ///subscriptions
    func subscription(){
        let subscription = heySequence.subscribe { event in
            switch event {
            case .next(let value):
                print("onNext Event: \(value)")
            case .error(let error):
                print(error)
            case .completed:
                print("onCompleted")
            }
        }
    }

    ///behaviour relay example
    
    func behaviourRelay(){
        let disposeBag = DisposeBag()
        //1
        let behaviourRelay = BehaviorRelay<String>(value: "")
        //2
        let subscription1 = behaviourRelay.subscribe(onNext:{ string in
            print("subscription1: ", string)
        })
        //3
        subscription1.disposed(by: disposeBag)
        //4
        // subscription1 receives these 2 events, subscription2 won't
        behaviourRelay.accept("Hey")
        behaviourRelay.accept("there")
        //5
        // subscription2 will not get "Hey" because it susbcribed later but "there" will be received as it was the last event
        let subscription2 = behaviourRelay.subscribe(onNext:{ string in
            print("subscription2: ", string)
        })
        //6
        subscription2.disposed(by: disposeBag)
        //7
        behaviourRelay.accept("Both Subscriptions receive this message")
    }
    
    ///dispose bag example
    
    func disposeBag(){
        let disposeBag = DisposeBag()

        let heySequence = Observable.from(["H","e","y"])
        let subscription = heySequence.subscribe { event in
            switch event {
            case .next(let value):
                print("onNext, Event: \(value)")
            case .error(let error):
                print(error)
            case .completed:
                print("onCompleted")
            }
        }
        subscription.disposed(by: disposeBag)
    }

}

