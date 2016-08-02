Apipie.configure do |config|
  config.app_name = "VertigoRTM"
  config.copyright = "VertigoRTM &copy; 2016"
  config.api_base_url = "/vertigo-rtm"
  config.doc_base_url = "/apipie"
  config.validate = false
  config.show_all_examples = true
  config.languages = ['en']
  config.default_locale = 'en'
  config.api_controllers_matcher = File.join(Rails.root, "..", "..", "app", "controllers", "**", "*.rb")
  config.default_version = 'v1'
  config.app_info["v1"] = "VertigoRTM REST API"
end
