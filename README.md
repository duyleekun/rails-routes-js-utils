# Rails::Routes::Js::Utils

Make rails route available in Javascript via window.Routes.*_path() and Array window.AllRoutes
This also generates plist file for iOS in /assets/rails-routes-js-utils.plist

## Installation

Add this line to your application's Gemfile:

    gem 'rails-routes-js-utils'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails-routes-js-utils

Add this to application.js

```
//= require rails-routes-js-utils
```

## Usage

```javascript
Routes.blog_post_path(123)
Routes.blog_post_path({id: 123})
Routes.blog_posts_path()

for (var i=0; i<AllRoutes.length; i++){
    var route = AllRoutes[i];
    var host = document.location.hostname;
    var pathname = document.location.pathname;
    if (route.path.test(pathname) && route.host.test(host)) {
        // Matched route
        console.log(route);
        var controller = route.reqs.controller;
        var action = route.reqs.action;
        var parts = route.reqs.parts; 
}
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
