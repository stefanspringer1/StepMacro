# StepMacro

This package implements the macro `@Step` for functions that should act as steps according to the [SwiftWorkflow](https://github.com/stefanspringer1/SwiftWorkflow) package.

Instead of writing:

```swift
func myGreeting(during execution: Execution) {
    execution.effectuate(checking: StepID(crossModuleFileDesignation: #file, functionSignature: #function)) {
        print("Hello!")
    }
}
```

you just write:

```swift
@Step
func myGreeting(during execution: Execution) {
    print("Hello!")
}
```

See the included test for a complete example.

**BUT:** The repositioning of errors is not perfect.
