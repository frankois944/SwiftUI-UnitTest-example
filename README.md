# Some example for Unit Test SwiftUI View

This repository uses 2 tools
- https://github.com/nalexn/ViewInspector : for dynamicaly load a specific view and check values inside
- https://github.com/pointfreeco/swift-snapshot-testing : for comparing a rendered view and check regression


Example of values checking :

```swift
let sut = ContentView()
let exp = sut.inspection.inspect { view in
    let value = try view.implicitAnyView().vStack().text(0).string()
    XCTAssertEqual(value, "Current status: Waiting for action!")
    try view.implicitAnyView().vStack().button(1).tap()
    let value2 = try view.implicitAnyView().vStack().text(0).string()
    XCTAssertEqual(value2, "Current status: Action done!")
}
ViewHosting.host(view: sut)
wait(for: [exp], timeout: 0.1)
```

Example of screen checking :

```swift
let sut = ContentView()
let exp = sut.inspection.inspect { view in
    assertSnapshot(of: try view.actualView().body, as: .image(layout: .device(config: .iPhoneSe)))
    try view.implicitAnyView().vStack().button(1).tap()
    assertSnapshot(of: try view.actualView().body, as: .image(layout: .device(config: .iPhoneSe)))
}
ViewHosting.host(view: sut)
wait(for: [exp], timeout: 0.1)
```



No UITest here, just Unit test, it's faster !
  
