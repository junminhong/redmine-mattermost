class RedmineHandler
	include HttpHandler

  def initialize
    get_config
  end

  def find_user_by_id(user_id)
		page = get_users_count.to_i / 100
		@index = 0
		while @index <= page do
			offset = (0 + (100 * @index)).to_s
			resp = send_request("#{@url}#{@api['users']}?key=#{@key}&limit=100&offset=#{offset}", {}, '', 'get')
			redmine_users = JSON.parse resp.body
			redmine_users['users'].each { |redmine_user| return redmine_user['mail'] if user_id == redmine_user['id'] }	
			@index += 1
		end
  end

	def get_user_info(id)
		resp = send_request("#{@url}#{@api['get_user']}/#{id}.json?key=#{@key}", {}, '', 'get')
		user_info = JSON.parse resp.body
		return "#{user_info['user']['lastname']}#{user_info['user']['firstname']}"
	end

	def get_users_count
		resp = send_request("#{@url}#{@api['users']}?key=#{@key}", {}, '', 'get')
		users_info = JSON.parse resp.body
		return users_info['total_count']
	end

  def get_config
    @config = YAML.load_file("plugins/redmine_mattermost/config/config.yml")
    @api = @config['redmine']['api']
    @key = @config['redmine']['key']
    @url = @config['redmine']['url']
  end
end