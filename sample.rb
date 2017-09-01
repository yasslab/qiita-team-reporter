require "qiita"

client = Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
client.list_items
client.list_users
client.list_user_items("r7kamura")
client.get_user("r7kamura")
client.get_user("r7kamura").status
client.get_user("r7kamura").headers
client.get_user("r7kamura").body
