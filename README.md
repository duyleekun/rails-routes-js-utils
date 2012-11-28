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
Routes.blog_post_path(id)
Routes.blog_posts_path()

for (var i=0; i<AllRoutes.length; i++){
    if (AllRoutes[i].path.test(pathname)) {
        console.log(AllRoutes[i]);
        var controller = AllRoutes[i].reqs.controller;
        var action = AllRoutes[i].reqs.action;
}
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
