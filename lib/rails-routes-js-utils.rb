require "rails-routes-js-utils/version"
require "rails-routes-js-utils/engine"

module Rails
  module Routes
    module Js
      module Utils
        def self.generate
          all_routes = ENV['CONTROLLER'] ? Rails.Application.routes.select { |route| route.defaults[:controller] == ENV['CONTROLLER'] } : IMuaSam::Application.routes
          param_split = /\(?\.?:[^\/\(\)]*\)?/
          param_replace = '[^\/\(\)]*'

          all_routes.routes.collect do |route|
            reqs = route.requirements.empty? ? "{}" : route.requirements.to_json

            this_spec = route.path.spec().to_s
            static_part = this_spec.split(param_split)
            dynamic_part = this_spec.scan(param_split)
            dynamic_part.slice!(-1,1)
            compiled_match = []
            compiled_replace = ["function() { return ''"]
            for i in 0..[static_part.length,dynamic_part.length].max
              if (static_part[i] && static_part[i].length)
                compiled_match << static_part[i]
                compiled_replace << "+'#{static_part[i]}'"
              end
              if (dynamic_part[i] && dynamic_part[i].length)
                compiled_replace << "+arguments[#{i}]"
                compiled_match << param_replace
              end
            end
            compiled_regex = Regexp.new(compiled_match.join());
            compiled_replace << ";}"

            if compiled_regex.match(this_spec) && route.name
              "addRouteToEnv({name: '#{route.name}', path: #{compiled_regex.inspect} , reqs: #{reqs}, replace: #{compiled_replace.join()}});"
            end
          end.join("\n");
        end

      end
    end
  end
end
