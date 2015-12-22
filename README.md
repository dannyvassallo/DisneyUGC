#Radio Disney UGC Platform [![Build Status](https://travis-ci.org/dannyvassallo/DisneyUGC.svg)](https://travis-ci.org/dannyvassallo/DisneyUGC)
Platform for Radio Disney to create User Generated Content Contests

###Getting Started
```
git clone https://github.com/dannyvassallo/DisneyUGC.git
cd DisneyUGC
bundle install
rake db:migrate
foreman s
```
visit ```localhost:5000``` in the browser.

###Create an Admin
```shell
rails c
u = User.first
u.update_attributes(:role => 'admin')
u.save!
```

###Sticky Footer

Content must be between 2 main tags for sticky footer to work:
```html
<main></main>
```

###Set ENV with figaro on Heroku

Production:
```shell
figaro heroku:set -e production
```
Staging:
```shell
figaro heroku:set -e staging --app APPNAME
```

###Local Video Processing

```shell
brew install ffmpeg
brew install ffmpegthumbnailer
gem install streamio-ffmpeg
brew install mysql
```

###Production/Staging Video Processing

To set the buildpack:
```shell
heroku buildpacks:set https://github.com/ddollar/heroku-buildpack-multi.git --app APPNAME
```
run the workers:
```
heroku run rake jobs:work --app APPNAME
```

if app doesnt run, scale up:
```
heroku ps:scale web=1 workers=1 --app disneyugc-staging
```

if you mess up do this:
```shell
heroku buildpacks:clear --app APPNAME
```

###Clear Jobs

To clear jobs:
```
rake jobs:clear
```

###Using Pry

Throw pry anywhere to get an irb debug console:
```
pry
```

###Travis CI

install:
```
gem install travis
```

encrypt ENV:
```
travis encrypt SOMEVAR=secretvalue
```
This will output a string looking something like:
```
secure: ".... encrypted data ...."
```
Copy paste it into the ```travis.yml``` file.

ALTERNATIVELY

You may add them in the settings in your Travis CI Dashboard for the repo.

###Signup URL
```
localhost:5000/users/8626705366
```
