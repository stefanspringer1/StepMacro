import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import Workflow
import StepMacro

final class StepsTests: XCTestCase {

    func test1() throws {
        
        @Step
        func f(during execution: Execution) {
            g(during: execution)
        }
        
        @Step
        func g(during execution: Execution) {
            execution.log(Message(id: "1", type: .Info, fact: [.en: "hello"]))
        }
        
        let logger = CollectingLogger(loggingLevel: .Progress, progressLogging: true)
        let execution = Execution(applicationName: "test", logger: logger)
        
        f(during: execution)
        
        let logContent: String = logger.getLoggingEvents().map{ $0.description }.joined(separator: "\n")
            .replacing(/\(duration: (\d*\.\d*) seconds\)/, with: "(duration: ... seconds)")
        let shouldBe: String = """
          {Progress}: >> STEP f(during:)@MacroTests/StepsTests.swift
          {Progress}: >> STEP g(during:)@MacroTests/StepsTests.swift
          {Info} [1]: hello
          {Progress}: << DONE STEP g(during:)@MacroTests/StepsTests.swift (duration: ... seconds)
          {Progress}: << DONE STEP f(during:)@MacroTests/StepsTests.swift (duration: ... seconds)
          """
        XCTAssertEqual(logContent, shouldBe)
    }
    
}
