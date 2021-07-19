class MattermostListener < Redmine::Hook::Listener
	def redmine_mattermost_issues_new_after_save(context={})
		mattermost = MattermostHandler.new
		begin
			mattermost.notify(context[:issue], "created")
		rescue Exception => e
			p "除錯小尖兵#{e}"
		end
	end

	def redmine_mattermost_issues_edit_after_save(context={})
		return unless Setting.plugin_redmine_mattermost["post_updates"] == '1'
		mattermost = MattermostHandler.new
		begin
			mattermost.notify(context[:issue], context[:journal], "updated")
		rescue Exception => e
			p "除錯小尖兵#{e}"
		end
	end
end
	