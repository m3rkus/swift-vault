//
//  RepeatingTimer.swift
//  Gymkhana
//
//  Created by m3rk on 28/11/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation


#warning("Add unit tests")
protocol RepeatingTimerDelegate: class {
    func timer(_ timer: RepeatingTimer, didChangeState state: RepeatingTimer.State)
    func timerDidFire(_ timer: RepeatingTimer)
}

extension RepeatingTimerDelegate {
    
    func timer(_ timer: RepeatingTimer, didChangeState state: RepeatingTimer.State) {
        // Empty implementation to allow this method to be optional
    }
    
}

public final class RepeatingTimer {
    
    /// State of the timer
    ///
    /// - paused: idle (never started yet or paused)
    /// - running: timer is running
    /// - finished: timer lifetime is finished
    public enum State: Equatable {
        case paused
        case running
        case finished
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.paused, .paused),
                 (.running, .running),
                 (.finished, .finished):
                return true
            default:
                return false
            }
        }
        
        /// Return `true` if timer is currently running
        public var isRunning: Bool {
            guard self == .running else { return false }
            return true
        }
        
        /// Is timer finished its lifetime?
        /// It return always `false` for infinite timers.
        /// It return `true` for `.once` mode timer after the first fire,
        /// and when `.remainingIterations` is zero for `.finite` mode timers
        public var isFinished: Bool {
            guard case .finished = self else { return false }
            return true
        }
    }
    
    /// Repeat interval
    public enum Interval {
        case nanoseconds(_: Int)
        case microseconds(_: Int)
        case milliseconds(_: Int)
        case minutes(_: Int)
        case seconds(_: Double)
        case hours(_: Int)
        case days(_: Int)
        
        internal var value: DispatchTimeInterval {
            switch self {
            case .nanoseconds(let value):       return .nanoseconds(value)
            case .microseconds(let value):      return .microseconds(value)
            case .milliseconds(let value):      return .milliseconds(value)
            case .seconds(let value):           return .milliseconds(Int( Double(value) * Double(1000)))
            case .minutes(let value):           return .seconds(value * 60)
            case .hours(let value):             return .seconds(value * 3600)
            case .days(let value):              return .seconds(value * 86400)
            }
        }
    }
    
    /// Mode of the timer.
    ///
    /// - infinite: infinite number of repeats.
    /// - finite: finite number of repeats.
    /// - once: single repeat.
    public enum Mode {
        case infinite
        case finite(_: Int)
        case once
        
        /// Is timer a repeating timer?
        internal var isRepeating: Bool {
            switch self {
            case .once:     return false
            default:        return true
            }
        }
        
        /// Number of repeats, if applicable. Otherwise `nil`
        public var countIterations: Int? {
            switch self {
            case .finite(let counts):    return counts
            default:                     return nil
            }
        }
        
        /// Is infinite timer
        public var isInfinite: Bool {
            guard case .infinite = self else {
                return false
            }
            return true
        }
        
    }
    
    // MARK: - Public Properties
    
    /// Timer's delegate
    weak var delegate: RepeatingTimerDelegate?
    
    /// Current state of the timer
    public private(set) var state: State = .paused {
        didSet {
            delegate?.timer(self, didChangeState: state)
        }
    }
    
    /// Timer mode
    public private(set) var mode: Mode
    
    /// Number of remaining repeats count
    public private(set) var remainingIterations: Int?
    
    // MARK: - Private Properties
    
    /// Internal GCD Timer
    private var timer: DispatchSourceTimer?
    
    /// Interval of the timer
    private var interval: Interval
    
    /// Accuracy of the timer
    private var tolerance: DispatchTimeInterval
    
    /// Dispatch queue parent of the timer
    private var queue: DispatchQueue?
    
    // MARK: - Lifecycle
    
    /// Initialize a new timer.
    ///
    /// - Parameters:
    ///   - interval: interval of the timer
    ///   - mode: mode of the timer
    ///   - tolerance: tolerance of the timer, 0 is default.
    ///   - queue: queue in which the timer should be executed; if `nil` a new queue is created automatically.
    ///   - observer: observer
    public init(interval: Interval,
                mode: Mode = .infinite,
                tolerance: DispatchTimeInterval = .nanoseconds(0),
                queue: DispatchQueue? = nil) {
        
        self.mode = mode
        self.interval = interval
        self.tolerance = tolerance
        self.remainingIterations = mode.countIterations
        self.queue = (queue ?? DispatchQueue(label: "com.repeatingTimer.queue"))
        self.timer = configureTimer()
    }
    
    deinit {
        self.destroyTimer()
    }
}

// MARK: - Public Methods
extension RepeatingTimer {
    
    /// Create and schedule a timer that will call `handler` once after the specified time.
    ///
    /// - Parameters:
    ///   - interval: interval delay for single fire
    ///   - queue: destination queue, if `nil` a new `DispatchQueue` is created automatically.
    ///   - observer: handler to call when timer fires.
    /// - Returns: timer instance
    @discardableResult
    public class func once(after interval: Interval,
                           tolerance: DispatchTimeInterval = .nanoseconds(0),
                           queue: DispatchQueue? = nil) -> RepeatingTimer {
        
        let timer = RepeatingTimer(interval: interval,
                                   mode: .once,
                                   tolerance: tolerance,
                                   queue: queue)
        timer.start()
        return timer
    }
    
    /// Create and schedule a timer that will fire every interval optionally by limiting the number of fires.
    ///
    /// - Parameters:
    ///   - interval: interval of fire
    ///   - count: a non `nil` and > 0  value to limit the number of fire, `nil` to set it as infinite.
    ///   - queue: destination queue, if `nil` a new `DispatchQueue` is created automatically.
    ///   - handler: handler to call on fire
    /// - Returns: timer
    @discardableResult
    public class func every(_ interval: Interval,
                            count: Int? = nil,
                            tolerance: DispatchTimeInterval = .nanoseconds(0),
                            queue: DispatchQueue? = nil) -> RepeatingTimer {
        
        let mode: Mode = (count != nil ? .finite(count!) : .infinite)
        let timer = RepeatingTimer(interval: interval,
                                   mode: mode,
                                   tolerance: tolerance,
                                   queue: queue)
        timer.start()
        return timer
    }
    
    /// Force fire.
    ///
    /// - Parameter pause: `true` to pause after fire, `false` to continue the regular firing schedule.
    public func fire(andPause pause: Bool = false) {
        
        self.timeFired()
        if pause == true {
            pauseTimer()
        }
    }
    
    /// Reset the state of the timer, optionally changing the fire interval.
    ///
    /// - Parameters:
    ///   - interval: new fire interval; pass `nil` to keep the latest interval set.
    ///   - restart: `true` to automatically restart the timer, `false` to keep it stopped after configuration.
    public func reset(_ interval: Interval?,
                      restart: Bool = true) {
        
        if self.state.isRunning {
            pauseTimer()
        }
        
        // For finite counter we want to also reset the repeat count
        if case .finite(let count) = self.mode {
            self.remainingIterations = count
        }
        
        // Create a new instance of timer configured
        if let newInterval = interval {
            self.interval = newInterval
        } // update interval
        self.destroyTimer()
        self.timer = configureTimer()
        self.state = .paused
        
        if restart {
            self.timer?.resume()
            self.state = .running
        }
    }
    
    /// Start timer. If timer is already running it does nothing.
    @discardableResult
    public func start() -> Bool {
        
        guard self.state.isRunning == false else {
            return false
        }
        
        // If timer has not finished its lifetime we want simply
        // restart it from the current state.
        guard self.state.isFinished == true else {
            self.state = .running
            self.timer?.resume()
            return true
        }
        
        // Otherwise we need to reset the state based upon the mode
        // and start it again.
        self.reset(nil, restart: true)
        return true
    }
    
}

// MARK: - Private Methods
private extension RepeatingTimer {
    
    /// Configure a new timer session.
    ///
    /// - Returns: dispatch timer
    func configureTimer() -> DispatchSourceTimer {
        
        let associatedQueue = (queue ?? DispatchQueue(label: "com.repeatingTimer.\(UUID().uuidString)"))
        let timer = DispatchSource.makeTimerSource(queue: associatedQueue)
        let repeatInterval = interval.value
        let deadline: DispatchTime = (DispatchTime.now() + repeatInterval)
        if self.mode.isRepeating {
            timer.schedule(deadline: deadline, repeating: repeatInterval, leeway: tolerance)
        } else {
            timer.schedule(deadline: deadline, leeway: tolerance)
        }
        
        timer.setEventHandler { [weak self] in
            guard let _self = self else { return }
            
            _self.timeFired()
        }
        return timer
    }
    
    /// Destroy current timer
    func destroyTimer() {
        self.timer?.setEventHandler(handler: nil)
        // If the timer is suspended, calling cancel without resuming triggers a crash
        if state == .paused || state == .finished {
            self.timer?.resume()
        }
        self.timer?.cancel()
    }
    
    /// Pause a running timer
    func pauseTimer() {
        
        guard state != .paused &&
            state != .finished
            else {
                return
        }
        
        self.timer?.suspend()
        self.state = .paused
        
    }
    
    /// Called when timer is fired
    func timeFired() {
        // manage lifetime
        switch self.mode {
        case .once:
            // once timer's lifetime is finished after the first fire
            // you can reset it by calling `reset()` function.
            pauseTimer()
        case .finite:
            // for finite intervals we decrement the left iterations count...
            remainingIterations! -= 1
            if remainingIterations! == 0 {
                // if left count is zero we just pause the timer and stop
                pauseTimer()
            }
        case .infinite:
            // infinite timer does nothing special on the state machine
            break
        }
        
    }
    
}

