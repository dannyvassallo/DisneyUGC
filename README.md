#Radio Disney UGC Platform

Platform for Radio Disney to create User Generated Content Contests

###Getting Started
```
git clone https://github.com/dannyvassallo/DisneyUGC.git
cd DisneyUGC
bundle install
rake db:migrate
rails s
```

###Sticky Footer
Content must be between 2 main tags for sticky footer to work:
```html
<main></main>
```