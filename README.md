# ABNScheduler 
![screen shot 2017-08-11 at 10 16 44 am](https://user-images.githubusercontent.com/30854711/29202817-47500ce8-7e89-11e7-86f9-8e2abfe0ebde.png)
![screen shot 2017-08-11 at 10 18 33 am](https://user-images.githubusercontent.com/30854711/29202824-527d4068-7e89-11e7-9065-3b2d362089c2.png)
![screen shot 2017-08-11 at 10 18 48 am](https://user-images.githubusercontent.com/30854711/29202826-56fceb70-7e89-11e7-936a-61ca698d49ac.png)
![screen shot 2017-08-11 at 10 19 12 am](https://user-images.githubusercontent.com/30854711/29202828-5a04d468-7e89-11e7-985d-99ca5f944c20.png)
![screen shot 2017-08-11 at 10 21 02 am](https://user-images.githubusercontent.com/30854711/29202829-5bf83fc6-7e89-11e7-9ac2-5f539922e735.png)

## Features

- Easily schedule and manipulate local notifications
- Ability to schedule more than 64 local notifications
- Schedule flexible notifications (upcoming)


## Usage
### Scheduling a Notification
```
var notification = ABNotification(alertBody: "A Notification")
let identifier = notification.schedule(fireDate: NSDate().nextHours(2))
```

`schedule(fireDate:)` returns the identifier of the notification if it was scheduled successfully. It returns `nil` if it was not scheduled or if it was already scheduled.

To preset an identifier to the notification:
```
var notification = ABNotification(alertBody: "A Notification", identifier: "identifier")
let identifier = notification.schedule(fireDate: NSDate().nextHours(2))
```

>nextHours(_:) is part of an NSDate extension.

You can also quickly schedule a notification:
```
let identifier = ABNScheduler.schedule(alertBody: "A Notification", fireDate: NSDate().nextDays(1))
```

>nextDays(_:) is part of an NSDate extension.

To schedule a notification for a specific time today or tomorrow:
```
let identifier = ABNScheduler.schedule(alertBody: "A Notification", fireDate: 1300.date)
```
This notification will be scheduled for 1:00 PM today if the current time precedes 1:00 PM, otherwise, it will be scheduled for tomorrow at 1:00 PM.

> date is a computed property and is part of an Int extension.

ABNScheduler uses a priority queue to handle more than 64 notifications. When the app can no more schedule additional notifications, they are added to the app's notifications queue. That's why you need to call `ABNScheduler.scheduleNotificationsFromQueue()` whenever some scheduled notifications are fired.

Additionally, the notifications queue is not saved to disk automatically, therefore, you will need to call `ABNScheduler.saveQueue()` whenever you need to persist the queue to disk. You do not need to load the queue when your app launches; this is handled automatically whenever the queue is to be accessed.

###Repeating a Notification

You can repeat a notification every hour, day, week, month, year using `Repeats` `.Hourly`, `.Daily`, `.Weekly`, `.Monthly`, `.Yearly` respectively.

Repeating a notification daily:

```
var notification = ABNotification(alertBody: "A Notification")
notification.repeatInterval = Repeats.Daily
let identifier = notification.schedule(fireDate: NSDate().nextHours(2))
```

### Retrieving a Notification
```
let notification = ABNScheduler.notificationWithIdentifier("identifier")
```

To retrieve the scheduled notifications by iOS, call `ABNScheduler.scheduledNotifications()`. This returns an array of ABNotification.

