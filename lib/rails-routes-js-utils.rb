require "rails-routes-js-utils/version"
require "rails-routes-js-utils/engine"
require "regex"
module Rails
  module Routes
    module Js
      module Utils
        def self.generate
          all_routes = ENV['CONTROLLER'] ? Rails.Application.routes.select { |route| route.defaults[:controller] == ENV['CONTROLLER'] } : IMuaSam::Application.routes
          all_routes.routes.collect do |route|
            compiled_regex = route.path.to_regexp.to_javascript
            reqs = route.defaults.merge(parts: route.parts)
            if route.name
              "addRouteToEnv({name: '#{route.name}', path: #{compiled_regex} , reqs: #{reqs}});"
            end
          end.join("\n");
        end

      end
    end
  end
end
