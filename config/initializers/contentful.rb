ContentfulModel.configure do |config|
  # config.authenticate_webhooks = true # false here would allow the webhooks to process without basic auth
  # config.webhooks_username = "a basic auth username"
  # config.webhooks_password = "a basic auth password"
  config.access_token = 'cd2c60ea902ff8ba3378eea5e06097303599d8089c06f01ffd7f41115ebbd6fc'
  #config.preview_access_token = "d3ab00cb48f78352f75eed2e825b18fa4658d719e0ea0a7cf6db13b94b68b2f4"
  config.default_locale = "en-US"

  management_token = nil
  raise "Enter Management Token" unless management_token
  config.management_token = management_token
  
  config.space = 'ymtlskoxsdvn'

  config.default_locale = "en-US"

  # config.contentful_options = {
  #   logger: Rails.logger,
  #   log_level: Logger::DEBUG
  # }


  #config.eager_load_entry_mapping = false

  # config.contentful_options = {
  #   entry_mapping: {
  #     'article' => Article,
  #     ...
  #   }
  # }
end


# class ContentfulModel::Base
#   def self.to_hash
#     {}
#   end
# end