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
    [404, headers, ["Error Request!\n"]]
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def time
    date = DateTime.now

    @date_format = {
      'year'   => date.year,
      'month'  => date.month,
      'day'    => date.day,
      'hour'   => date.hour,
      'minute' => date.minute,
      'second' => date.second
    }

    @params = @request.params['format'].split(',')

    if valid?
      [200, headers, ["#{valid_params}\n"]]
    else
      [400, headers, ["Unknown time format #{invalid_params}\n"]]
    end
  end

  def valid?
    @params.all? { |format| @date_format.has_key? format }
  end

  def valid_params
    @params.map { |format| @date_format[format] }.join('-')
  end

  def invalid_params
    @params.reject { |format| @date_format.has_key? format }
  end

end
