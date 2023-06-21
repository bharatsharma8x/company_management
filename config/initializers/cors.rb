Rails.application.config.middleware.insert_before ActionDispatch::Static, Rack::Cors do
  allow do
    origins '*'  # You can replace '*' with your allowed origin(s) here
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end