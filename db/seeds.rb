['admin', 'author', 'follower', 'guest'].each do |role|
  Role.find_or_create_by(name: role)
end

role = Role.find_by(name: 'admin')
User.find_or_create_by(role_id: role.id ) do |user|
  user.email = 'roman-skrupun@yandex.ru'
  user.password = 'adminka'
  user.skip_confirmation!
end
