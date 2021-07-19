class MattermostHandler
  include Tools
  include HttpHandler

  def initialize
    get_api
    @url = Setting.plugin_redmine_mattermost["mattermost_url"]
    @icon = Setting.plugin_redmine_mattermost["icon"]
    @account = Setting.plugin_redmine_mattermost["account"]
    @password = Setting.plugin_redmine_mattermost["password"]
    @display_watchers = Setting.plugin_redmine_mattermost["display_watchers"]
    login
  end
  
  def login
    return if @account.blank? or @password.blank?
    params = {
      "login_id": @account,
      "password": @password
    }.to_json
    resp = send_request("#{@url}#{@api['users_login']}", params, '', 'post')
    return unless resp
    # @token = resp.headers['token'].blank? ? '' : resp.headers['token']
    @token = ''
    resp_json = JSON.parse resp.body
    #@sender_id = resp_json['id'].blank? ? '' : resp_json['id']
    @sender_id = ''
  end

  def notify(issue, journals = '', status)
		return if issue.is_private?
    @redmine = RedmineHandler.new
    notify_to_watcher(issue, status)
		return if issue.assigned_to_id.blank?
		return if issue.assigned_to_id == issue.author_id and status == 'created'
    unless journals.blank?
      return if issue.assigned_to_id == journals.user_id
    end
		email = @redmine.find_user_by_id(issue.assigned_to_id)
		return if email.blank?
    case status
    when "created"
      msg = "[#{escape issue.project}][#{issue.priority.name}] [#{escape issue}](#{object_url issue}) #{escape issue.status.name} by #{escape issue.author}"
    when "updated"
      user_name = @redmine.get_user_info(journals.user_id)
      msg = "[#{escape issue.project}][#{issue.priority.name}] [#{escape issue}](#{object_url issue}) #{escape issue.status.name} by #{escape user_name}"
    end
		publish_msg(email, msg)
  end

  def publish_msg(email, msg)
		params = {
				"channel_id": create_direct_channel(email),
				"message": msg,
				"file_ids": [],
				# "props": {"attachments": [attachment]}
		}.to_json
    resp = send_request("#{@url}#{@api['posts']}", params, @token, 'post')
    return unless resp
  end

	def notify_to_watcher(issue, status)
    return unless @display_watchers == '1'
    unless issue.watcher_users.ids.map.blank?
      issue.watcher_users.ids.map do |user_id|
        next if issue.assigned_to_id == user_id
        email = @redmine.find_user_by_id(user_id)
        case status
        when "created"
          msg = "[#{escape issue.project}] 你關注的 [#{escape issue}](#{object_url issue}) 議題已被新建"  
        when "updated"
          msg = "[#{escape issue.project}] 你關注的 [#{escape issue}](#{object_url issue}) 議題已被更新"
        end
        publish_msg(email, msg)
      end
    end
	end

  def create_direct_channel(email)
		params = [
			@sender_id,
			reciver_id(email)
		].to_json
    resp = send_request("#{@url}#{@api['channel_direct']}", params, @token, 'post')
    return unless resp
		direct_channel = JSON.parse resp.body
		return direct_channel['id']
  end

  def reciver_id(email)
    resp = send_request("#{@url}#{@api['users_email']}/#{email}", {}, @token, 'get')
    return unless resp
		user_info = JSON.parse resp.body
		return user_info['id']
  end

  def get_api
    @config = YAML.load_file("plugins/redmine_mattermost/config/config.yml")
    @api = @config['mattermost']['api']
  end
end