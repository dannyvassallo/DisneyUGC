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

###CORS setup on S3 for fonts

1. Navigate to your AWS console and the S3 service
2. Select the bucket you are using to store your assets
3. Click the ‘Properties’ tab
4. Under ‘Permissions’ click ‘Add CORS Configuration’
5. Paste in the following

If you are using CloudFront as your CDN and you want to use the example CORS configuration that limits requests from only your site, then you will need to decide which type of request your site will use: HTTP or HTTPS.

The example allows requests from both protocols, however, CloudFront will cache the response from the first request and if it receives a subsequent request from a different protocol it will fail. Therefore if your site is using HTTP, only include that in the configuration and vice versa for HTTPS.

```
<CORSConfiguration>
    <CORSRule>
        <AllowedOrigin>http://www.mysite.com</AllowedOrigin>
        <AllowedOrigin>https://www.mysite.com</AllowedOrigin>
        <AllowedMethod>GET</AllowedMethod>
        <AllowedMethod>HEAD</AllowedMethod>
        <AllowedMethod>DELETE</AllowedMethod>
        <AllowedMethod>PUT</AllowedMethod>
        <AllowedMethod>POST</AllowedMethod>
        <MaxAgeSeconds>3000</MaxAgeSeconds>
        <AllowedHeader>Authorization</AllowedHeader>
    </CORSRule>
</CORSConfiguration>
```

###If fonts are still not working

Precompile your assets locally and then push your branch:

```
rake assets:precompile
```
