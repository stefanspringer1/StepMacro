# StepMacro

---
**NOTE**

**This package is deprecated** because:

- This macro has an issue with the relocation of compilation errors.
- Instead of the [Workflow](https://github.com/stefanspringer1/SwiftWorkflow) package used here, the new [Pipeline](https://github.com/stefanspringer1/Pipeline) should be used.
- For the [Pipeline](https://github.com/stefanspringer1/Pipeline) package, the [PipelineStepMacro](https://github.com/stefanspringer1/PipelineStepMacro) was created (which does not have the issue with the relocation of compilation errors).
- The [PipelineStepMacro](https://github.com/stefanspringer1/PipelineStepMacro) is now integrated into the [Pipeline](https://github.com/stefanspringer1/Pipeline) package.

---

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

The function must have the argument with inner-function name `execution` of type `Execution`.

See the included test for a complete example.

**BUT:** The repositioning of errors is not perfect.
