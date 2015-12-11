#Radio Disney UGC Platform

Platform for Radio Disney to create User Generated Content Contests

###Getting Started
```
git clone https://github.com/dannyvassallo/DisneyUGC.git
cd DisneyUGC
bundle install
rake db:migrate
foreman s
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
```
###Production/Staging Video Processing
###Buildpacks with FFMpeg and Thumbnailer
The set the buildpack:
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

to clear jobs:
```
rake jobs:clear
```

###Using Pry
throw pry anywhere to get an irb debug console:
```
pry
```

