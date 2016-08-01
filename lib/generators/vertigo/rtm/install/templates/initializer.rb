Vertigo::Rtm.setup do |config|
  config.user_class = <%= "'#{user_class_name}'" %>
  config.user_name_column = :name
  config.current_user_method = :current_user
end
