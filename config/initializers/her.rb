class QueryInjector < Faraday::Middleware
  def call(env)
    token = ENV['API_KEY'] # or any method to get your token

    # env[:url] is a URI object
    env[:url].query = "api_key=#{token}"

    # You can also change headers 
    # env[:request_headers]['header']
    @app.call(env)
  end
end

class SynchronizationsParser < Faraday::Response::Middleware
  def on_complete(env)
    json = MultiJson.load(env[:body], symbolize_keys: true)
    response = json[:synchronizations] ? json[:synchronizations] : json
    env[:body] = {
      data: response,
      metadata: json[:total_entries]
    }
  end
end

# config/initializers/her.rb
Her::API.setup url: "https://mapc-admin.carto.com/api/v1" do |c|
  # Request
  c.use QueryInjector
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use SynchronizationsParser

  # Adapter
  c.use Faraday::Adapter::NetHttp
end