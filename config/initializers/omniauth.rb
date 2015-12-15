Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["API"],ENV["API_SECRET"]
end
