require "rails-routes-js-utils/version"
require "rails-routes-js-utils/engine"
require "regex"
module Rails
  module Routes
    module Js
      module Utils

        #DFS Traversal
        def self.dig(current,js)

          if (!current.respond_to? :left) || (current.class == Journey::Nodes::Symbol) || (current.class == Journey::Nodes::Group)
            #puts("#{current.class} #{current}")
            if (current.class == Journey::Nodes::Symbol)
              #Required
              js << "opts.#{current.to_s[1..-1]}"
            else
              if (current.class == Journey::Nodes::Group)
                #js << current.to_s
              else
                #Literal
                js << "'#{current.to_s}'"
              end
            end
          else
            dig(current.left,js)
            if (current.respond_to? :right)
              dig(current.right,js)
            end
          end
        end

        def self.generate
          all_routes = ENV['CONTROLLER'] ? Rails.Application.routes.select { |route| route.defaults[:controller] == ENV['CONTROLLER'] } : IMuaSam::Application.routes
          all_routes.routes.collect do |route|
            compiled_regex = route.path.to_regexp.to_javascript

            #route.defaults contains action and controller name
            reqs = route.defaults.merge(parts: route.parts)


            subdomain_regex = {}
            if route.constraints[:subdomain]
              subdomain_regex = route.constraints[:subdomain].to_javascript
            end

            js = [];
            dig(route.path.spec,js)
            if route.name
              "addRouteToEnv({name: '#{route.name}', path: #{compiled_regex}, subdomain: #{subdomain_regex} , reqs: #{reqs.to_json}, replace: function(opts) { return #{js.join('+')}; } });"
            end
          end.join("\n");
        end

      end
    end
  end
end
