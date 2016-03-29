# Mail by InVision

This is a demo iOS application developed as part of an interview process to InVision.

Hosted JSON with a list of messages - https://www.dropbox.com/s/hma5zdh4y4i8635/messages.json?dl=1

The app demonstrates a part of an email application containing four screens - a *Login*, *Inbox* and *Message* detail screens with a *Menu* screen providing base navigation within the app. *Inbox* screen contains list of messages which can represent either a single message or part of an email thread. The *Detail* screen shows more details about a message or a thread.

It is designed according to [design](https://projects.invisionapp.com/share/3K6DOMMD5#/screens/140244447) provided by InVision, supporting both iPhones and iPads.

## Technical

As required, it's programmed in Objective-C; using `Core Data` framework for persistence and data model and `AFNetworking` for networking.

Regarding *hamburger menu* implementation, there's a different approach for iPhones and iPads. For the former, a custom container view controller is used to display content view controllers, e.g. the *Inbox* screen controller and provides "access" to the *Menu* screen. On iPads, a split view controller with custom delegate controller provides this functionality.

## Notes

Despite the fact the app is designed according to design provided, I have to mention that some UX and UI components are outdated where I'd suggest a different approach:
- most importantly it's the *hamburger menu* which is a bad UX design as there are more practical approaches to solve an app/screen navigation, e.g. a tab bar.
- regarding UI, I don't think there's a need for customizing navigation bar height, I'd stick with system default height.
