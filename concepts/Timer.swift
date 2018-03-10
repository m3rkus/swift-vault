// GCD-based timer 


private let timerQueue = DispatchQueue(label: "com.timer.queue", attributes: [])

final class Timer : NSObject {

    private var timer: DispatchSourceTimer?
    var active: Bool {
        return timer != nil
    }

    func start(_ interval: Int, repeats: Bool = false, handler: @escaping () -> Void) {

        cancel()

        let timer = DispatchSource.makeTimerSource(queue: timerQueue)
        self.timer = timer

        timer.scheduleRepeating(deadline: .now() + .seconds(interval), interval: .seconds(interval))
        timer.setEventHandler {
            if !repeats {
                self.cancel()
            }
            DispatchQueue.main.async(execute: handler)
        }
        timer.resume()
    }

    func cancel() {

        guard let timer = timer else { return }
        timer.cancel()
        self.timer = nil
    }

    deinit {

        cancel()
    }
}
