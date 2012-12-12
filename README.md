# Rails::Routes::Js::Utils

Make rails route available via window.Routes.*_path() and Array window.AllRoutes

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
    var subdomain = document.location.hostname.split('.')[0];
    var pathname = document.location.pathname;
    if (route.path.test(pathname) && route.subdomain.test(subdomain)) {
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
