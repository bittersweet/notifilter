# Notifilter
Get notified about events

Quick explanation:

1. Send data to Notifilter
2. Configure what you want to be notified about and how, optionally set up rules
3. Get notifications in Slack

Example:

People buy products on your website, you send `conversion` events to Notifilter. You want to give customers that buy a certain package some special attention so you set up a notification and add a rule that the `revenue` needs to be above 100$. All incoming conversions matching the rules will be sent to a Slack channel of your choosing. You've setup the notification with a nice template so you see all relevant data right away and can click on a link to your admin page.

### Ecosystem

* [notifilter](https://github.com/bittersweet/notifilter) - You're here!
* [notifilter-receive](https://github.com/bittersweet/notifilter-receive) - Go app that receives UDP, checks rules and notifies
* [notifilter-rb](https://github.com/bittersweet/notifilter-rb) – Ruby gem to track events

### Architecture & Requirements

Data is received over UDP (fire and forget) by [notifilter-receive](https://github.com/bittersweet/notifilter-receive) and stored in Elasticsearch (for aggregation + statistics type stuff in the future). Postgres is use to store notifiers that contain notification templates (based on [Go templating](https://golang.org/pkg/html/template/)), rules and settings (send to what channel etc).

This repo is a Phoenix + React app where you can configure notifications and view incoming events.

```
                persist to ES
              /
receive data
              \
                check if there are notifications
                set up that match this event      - notify channel with configured template
                and if all rules are satisfied

```
