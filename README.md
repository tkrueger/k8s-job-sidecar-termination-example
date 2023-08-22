## Kubernetes Sidecar Termination Example

This shows a new feature in Kubernetes 1.28: sidecar containers. More
specifically, how to make a sidecar container stop when the main container is
finished.

The solution is to trap the `SIGINT` that Kubernetes now sends to the sidecar
container when the main container completes. Not having this was a bit problem
in Jobs, because the job will not finish as long a sidecar container is still
running.

To see it in action, simply run `./run.sh`. It will bring up a kind cluster in
version `1.28` and start a job with a pod doing a countdown from 10 before
terminating. The sidecar is simply waiting for it to finish.

``` shell
[...]
job.batch/countdown created
pod/countdown-4xkjv condition met
[pod/countdown-4xkjv/sidecar-container] still here
[pod/countdown-4xkjv/counter] 9
[pod/countdown-4xkjv/sidecar-container] still here
[pod/countdown-4xkjv/counter] 8
[pod/countdown-4xkjv/counter] 7
[pod/countdown-4xkjv/sidecar-container] still here
[pod/countdown-4xkjv/counter] 6
[pod/countdown-4xkjv/counter] 5
[pod/countdown-4xkjv/sidecar-container] still here
[pod/countdown-4xkjv/counter] 4
[pod/countdown-4xkjv/counter] 3
[pod/countdown-4xkjv/sidecar-container] still here
[pod/countdown-4xkjv/counter] 2
[pod/countdown-4xkjv/counter] 1
[pod/countdown-4xkjv/sidecar-container] still here
[pod/countdown-4xkjv/sidecar-container] SIGINT or SIGTERM received: exiting!
```

To verify that the feature helps, try commenting out the `trap` line in
`sidecar/sidecar-script.sh`.

To clean up after, run `kubectl delete ns sidecar-trial`, or simply
`kind delete cluster`.
