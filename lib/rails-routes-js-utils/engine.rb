module Rails
  module Routes
    module Js
      module Utils
        class Engine < Rails::Engine
          JS_ROUTES_ASSET = 'rails-routes-js-utils'
          initializer 'js-routes.dependent_on_routes', :after => "sprockets.environment" do
            if Rails.application.assets.respond_to?(:register_preprocessor)
              routes = Rails.root.join('config','routes.rb')
              Rails.application.assets.register_preprocessor 'application/javascript', :'js-routes_dependent_on_routes' do |ctx,data|
                ctx.depend_on(routes) if ctx.logical_path == JS_ROUTES_ASSET
                data
              end
            end
          end
        end
      end
    end
  end
end