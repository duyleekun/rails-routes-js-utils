require "rails-routes-js-utils/version"
require "rails-routes-js-utils/engine"
require "regex"
require 'plist'

module Rails
  module Routes
    module Js
      module Utils

        #DFS Traversal
        def self.dig(current,js = [])

          if (!current.respond_to? :left) || (current.class == ActionDispatch::Journey::Nodes::Symbol) || (current.class == ActionDispatch::Journey::Nodes::Group)
            #puts("#{current.class} #{current}")
            if (current.class == ActionDispatch::Journey::Nodes::Symbol)
              #Required
              js << "opts.#{current.to_s[1..-1]}"
            else
              if (current.class == ActionDispatch::Journey::Nodes::Group)
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
          js
        end

        def self.all_routes
          ENV['CONTROLLER'] ? Rails.Application.routes.select { |route| route.defaults[:controller] == ENV['CONTROLLER'] } : Rails.application.routes
        end

        def self.generate_js
          last_name = nil
          self.all_routes.routes.collect do |route|
            compiled_regex = route.path.to_regexp.to_javascript

            #route.defaults contains action and controller name
            reqs = route.defaults.merge(parts: route.parts)


            subdomain_regex = {}
            if route.constraints[:subdomain]
              subdomain_regex = route.constraints[:subdomain].to_javascript
            end

            js = dig(route.path.spec)
            compiled_verb = route.verb.to_javascript
            if compiled_verb == '//'
              compiled_verb = '/.*/'
            end

            name = route.name
            if !name && last_name
              name = last_name
            end

            if name
              last_name = name
              "addRouteToEnv({name: '#{name}', path: #{compiled_regex}, subdomain: #{subdomain_regex} , reqs: #{reqs.to_json}, replace: function(opts) { return #{js.join('+')}; }, verb: #{compiled_verb} });"
            end
          end.join("\n")

        end
        def self.generate_plist
          parsedRoutes = {}
          last_name = nil
          self.all_routes.routes.collect do |route|
            name = route.name
            if !name && last_name
              name = last_name
            end
            reqs = route.defaults.merge(parts: route.parts)

            if name
              parsedRoutes[name] = {path: route.path.to_regexp.to_javascript,subdomain: route.constraints[:subdomain] ? route.constraints[:subdomain].to_javascript: '',reqs: reqs, verb: route.verb.to_javascript,ast:route.ast.to_s}
            end
          end
          parsedRoutes.to_plist
        end
      end
    end
  end
end
