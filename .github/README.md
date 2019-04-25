# NYCASP - Parking Notifier
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)


> Tweeting NYC ASP info daily at 7:30 AM, 4 PM, & during emergency suspensions. Account is automated and will not respond

![NYCASP-tweets-screenshot](screenshot.png)

Inspired by [this article](https://dev.to/twitterdev/how-i-solved-my-nyc-parking-problem-with-python-the-search-tweets-api-and-twilio-1chp) I decided to create a minimalistic and simple solution in Ruby. And here there is!

When there in no need to move your car, you will get the text message!
![text-message-screenshot](text_message.png)

## Usage

### Heroku (preferred)
Setuping the notifier on Heroku will allow you to fully automate it. Notifier will be triggered everyday at the same time of the day and text message will be sent to you if needed.

1. Start with clicking Heroku Deploy Button:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

2. You will be asked to set:
- App's name
- Region
- Environmental variables for [Twillio](https://www.twilio.com/console) & [Twitter](https://developer.twitter.com/en/apps/)

3. Click `Deploy App` button.
4. Click `Manage App` button.
5. Go to `Heroku Scheduler` settings:
- Create a new job.
- Set the schedule to run in preferably once per day, for example in the evening (remember, it's UTC).
- As running command type: `ruby notifier.rb`
- Save new job
6. Everything should be set and working.
Optionally:
7. You can check logs after job is triggered. (requirement: [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed)
- run: `heroku logs --ps scheduler -a your-app-name -t` - this will print logs to your terminal and tail them.


### Locally
If you don't want to deploy it to Heroku you can run it manually on your local machine.

#### 1. Setup your credentials by filling the `secrets.yml` file:
```yaml
twitter_api:
  api_key: api-key
  api_secret_key: api-secret-key
  access_token: access-token
  access_secret_token: access-secret-token
twilio:
  account_sid: account-sid
  auth_token: auth-token
  from_number: from-number
  to_number: to-number

```
You can start by copying the `secrets.yml` file:
```bash
cp secrets.example.yml
```

#### 2. Run the script (Docker required, Ruby not required to be installed locally)
Following command will fetch Docker base image, build app's new Docker image and run ruby command inside of it:
```bash
make run
```

#### 2.1 Run the script (Docker not required, Ruby required to be installed locally)
```bash
ruby notifier.rb
```
