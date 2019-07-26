require_relative 'time_formatter'

class App

  def call(env)
    @request = Rack::Request.new(env)

    if @request.path == '/time' && @request.request_method == 'GET'
      time
    else
      not_found
    end
  end

  private

  def not_found
    Rack::Response.new(["Error Request!\n"], 404, headers)
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def time
    date = TimeFormatter.new(DateTime.now, @request.params['format'])
    date.format

    if date.valid?
      Rack::Response.new(["#{date.date_str}\n"], 200, headers)
    else
      Rack::Response.new(["Unknown time format #{date.invalid_formats}\n"], 400, headers)
    end
  end
end
