# Body Sculpting

![](https://github.com/thomasmarkiewicz/bodysculpting/workflows/Build/badge.svg?branch=master)

My hope is that one day this app will become a viable alternative for keeping track of all of your workouts. Right now development is in early stages and includes only basic examples of how weight-lifting tracking will work.  My plan is to eventually support keeping track of the following activities:

- many different **weight lifting** programs
- triathlon (**swimming, biking, running**)
- **cross training** (lifting/cardio circuits)

A major goal is to create a multi-platform friendly solution, with this client supporting Android and iOS, but also with a standard data format that can be easily consumed on other platforms as well. I'm thinking here of third-party apps for Linux phones like [Librem 5](https://puri.sm/products/librem-5/) for example, as well as Linux, Mac, and Windows desktop applications - those apps should be able to use and sync with the same data.

A secondary goal is to place YOU in control of your data. The data should be stored locally on your device, and the app should work offline. Data should also hopefully be encryptable and synchronizable between devices via third-party apps like [Nextcloud](https://nextcloud.com/) or [rsync](https://rclone.org/) / [rcx](https://github.com/x0b/rcx).

Another major goal is to create a workout-tracking app that doesn't track YOU. It should not require any info about you to work or force you to create accounts if you don't want to. You should have the option to share your data, but only if you explicitly choose to do so.

And of course the app needs to be beautiful, easy to use, and practical so you can focus on working out and sculpting your body  instead of figuring out, setting up and configuring the app.
