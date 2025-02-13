import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension SyntaxStringInterpolation {
    mutating func appendInterpolation<Node: SyntaxProtocol>(
        _ node: Node,
        location: AbstractSourceLocation?,
        lineOffset: Int? = nil,
        close: Bool = true
    ) {
        if let location {
            let line = if let lineOffset {
                ExprSyntax("\(literal: Int(location.line.as(IntegerLiteralExprSyntax.self)?.literal.text ?? "0")! + lineOffset)")
            } else {
                location.line
            }
            var block = CodeBlockItemListSyntax {
                "#sourceLocation(file: \(location.file), line: \(line))"
                "\(node)"
            }
            if close {
                block.append("\n#sourceLocation()")
            }
            appendInterpolation(block)
        } else {
            appendInterpolation(node)
        }
    }
}

public struct StepMacro: BodyMacro {
    
    public static var formatMode: FormatMode { .disabled }
    
    public static func expansion(
        of node: AttributeSyntax,
        providingBodyFor declaration: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
        in context: some MacroExpansionContext
    ) throws -> [CodeBlockItemSyntax] {
        return [
            """
            execution.effectuate(checking: StepID(crossModuleFileDesignation: #file, functionSignature: #function)) {
                \(declaration.body!.statements, location: context.location(of: declaration.body!.statements, at: .beforeLeadingTrivia, filePathMode: .filePath), lineOffset: 0)
            }
            """
        ]
//        return [
//            """
//            execution.effectuate(checking: StepID(crossModuleFileDesignation: #file, functionSignature: #function)) {
//                \(declaration.body!.statements)
//            }
//            """
//        ]
    }
    
}
