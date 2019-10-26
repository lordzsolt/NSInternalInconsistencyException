# NSInternalInconsistencyException

A proof of concept implementation of `NSInternalInconsistencyException` exception handling in Swift.

The exception is thrown when wrong number of rows are inserted/deleted.
When the exception is thrown, the table view is recreated, since the old instance is unusable.
