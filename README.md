## API

- `dispatch_group_async`
- `dispatch_barrier_async`
- `dispatch_semaphore_signal`

## Why

I wanna send a request, but the parmaeters is get from the other three request's response.

So, I think about `dispatch_group_async` api, but any can guarantee the start request time make sense. I wanna the asynchronous request finished, request the specfic request at last. :[

And try `dispatch_barrier_async`, the same result.

The reason is the `dispatch_group_async` and `dispatch_barrier_async` block run the code is already asynchronous, so execute asynchronous task nested don't konw when is finish. alternative, use synchronous.


## Refrence

- [NSURLSession synchronous request solution](http://stackoverflow.com/questions/21198404/nsurlsession-with-nsblockoperation-and-queues)