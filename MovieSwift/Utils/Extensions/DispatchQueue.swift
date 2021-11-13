//
//  DispatchQueue.swift
//  metrik
//
//  Created by Canberk Bibican on 24.09.2021.
//

import Foundation

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
    /* Useage
     
     DispatchQueue.background(delay: 3.0, background: {
         // do something in background
     }, completion: {
         // when background job finishes, wait 3 seconds and do something in main thread
     })

     DispatchQueue.background(background: {
         // do something in background
     }, completion:{
         // when background job finished, do something in main thread
     })

     DispatchQueue.background(delay: 3.0, completion:{
         // do something in main thread after 3 seconds
     })
     
     */

}
