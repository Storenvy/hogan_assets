module HoganAssets
  class Engine < ::Rails::Engine
    initializer "sprockets.hogan", :after => "sprockets.environment", :group => :all do |app|
      next unless app.assets
      HoganAssets::Config.load_yml! if HoganAssets::Config.yml_exists?
      HoganAssets::Config.template_extensions.each do |ext|
        Sprockets.register_mime_type "text/x-#{ext}-template", extensions: ".#{ext}"
        Sprockets.register_transformer "text/x-#{ext}-template", 'application/javascript', Tilt
      end
    end
  end
end
