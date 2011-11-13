Rails.application.config.generators do |g|
  g.stylesheet_engine = :sass
  g.fixture_replacement :factory_girl, dir: "spec/factories"
  g.view_specs false
  g.helper_specs false
  g.routing_specs false
  g.controller_specs false
  g.stylesheets false
  g.helper false
  g.assets false
  g.integration_tool false
end
