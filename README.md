# LazyGridViewSelection

This project demonstrates a problem with a focus state of a view. It is possible to make all the code work on macOS 14,
but so far I did not manage to solve the selection/focus problem on earlier versions of macOSes.

A view in SwiftUI stack could be marked as `focusable()`. It enables focus switch between views by pressing Tab.

In my case I want re-create a collection view of items, where a singe item could be selected. It would be possible also
to move the selection by pressing on arrow keys.

I've left some inline comments to point out problematic places in the code, mainly in `LocalGridView`.
