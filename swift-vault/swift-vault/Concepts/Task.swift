//
//  Task.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 02/03/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation


/// Usage
//func publish(_ post: Post,
//             then handler: @escaping (Outcome) -> Void) {
//    let photoTasks = post.photos.map { photo in
//        return Task.uploading(photo, using: uploader)
//    }
//
//    let videoTasks = post.videos.map { video in
//        return Task.uploading(video, using: uploader)
//    }
//
//    let sequence = Task.sequence([
//        .group(photoTasks + videoTasks),
//        .uploading(post, using: uploader)
//        ])
//
//    sequence.perform(then: handler)
//}

struct Task {
    
    init(closure: @escaping Closure) {
        self.closure = closure
    }
    
    typealias Closure = (Controller) -> Void
    
    private let closure: Closure
    
    struct Controller {
        fileprivate let queue: DispatchQueue
        fileprivate let handler: (Outcome) -> Void
        
        func finish() {
            handler(.success)
        }
        
        func fail(with error: Error) {
            handler(.failure(error))
        }
    }
    
    enum Outcome {
        case success
        case failure(Error)
    }
    
    func perform(on queue: DispatchQueue = .global(),
                 then handler: @escaping (Outcome) -> Void) {
        queue.async {
            let controller = Controller(
                queue: queue,
                handler: handler
            )
            
            self.closure(controller)
        }
    }
    
    static func group(_ tasks: [Task]) -> Task {
        return Task { controller in
            let group = DispatchGroup()
            
            // To avoid race conditions with errors, we set up a private
            // queue to sync all assignments to our error variable
            let errorSyncQueue = DispatchQueue(label: "Task.ErrorSync")
            var anyError: Error?
            
            for task in tasks {
                group.enter()
                
                // It’s important to make the sub-tasks execute
                // on the same DispatchQueue as the group, since
                // we might cause unexpected threading issues otherwise.
                task.perform(on: controller.queue) { outcome in
                    switch outcome {
                    case .success:
                        break
                    case .failure(let error):
                        errorSyncQueue.sync {
                            anyError = anyError ?? error
                        }
                    }
                    
                    group.leave()
                }
            }
            
            group.notify(queue: controller.queue) {
                if let error = anyError {
                    controller.fail(with: error)
                } else {
                    controller.finish()
                }
            }
        }
    }
    
    static func sequence(_ tasks: [Task]) -> Task {
        var index = 0
        
        func performNext(using controller: Controller) {
            guard index < tasks.count else {
                // We’ve reached the end of our array of tasks,
                // time to finish the sequence.
                controller.finish()
                return
            }
            
            let task = tasks[index]
            index += 1
            
            task.perform(on: controller.queue) { outcome in
                switch outcome {
                case .success:
                    performNext(using: controller)
                case .failure(let error):
                    // As soon as an error was occurred, we’ll
                    // fail the entire sequence.
                    controller.fail(with: error)
                }
            }
        }
        
        return Task(closure: performNext)
    }
}
