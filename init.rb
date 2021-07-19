require 'redmine'
require 'yaml'
require 'active_support/core_ext'

require_dependency 'listener'

Redmine::Plugin.register :redmine_mattermost do
	name 'Redmine Mattermost'
	author 'junminhong'
	url 'https://gitlab.kdanmobile.com/qa/redmine_mattermost'
	author_url 'https://gitlab.kdanmobile.com/qa/redmine_mattermost'
	description 'Mattermost private send message'
	version '2.0.5'

	requires_redmine :version_or_higher => '2.0.0'

	settings \
		:default => {
			'callback_url' => 'http://example.com/callback/',
			'channel' => nil,
			'icon' => 'https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/icon.png',
			'username' => 'redmine',
			'display_watchers' => 'no'
		},
		:partial => 'settings/mattermost_settings'
end

ActiveSupport::Reloader.to_prepare do
	require_dependency 'issue'
	unless Issue.included_modules.include? IssuePatch
		Issue.send(:include, IssuePatch)
	end
end
