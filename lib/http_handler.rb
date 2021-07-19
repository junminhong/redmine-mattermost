module HttpHandler
  def send_request(host, params, token, method)
    method = method.downcase
    headers = {
			'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{token}"
		}
    begin
      case method
      when 'get'
        return Faraday.get(host, params, headers)
      when 'post'
        return Faraday.post(host, params, headers)
      end
    rescue Faraday::Error::ConnectionFailed => e
      return false
    end
  end
end