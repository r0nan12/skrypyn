['admin', 'author', 'guest'].each do |role|
  Role.find_or_create_by(name: role)
end
role = Role.all
User.find_or_create_by(user_name: 'adminka') do |user|
  user.email = 'roman-skrupun@yandex.ru'
  user.password = 'adminka'
  user.role = role.find_by_name('admin')
end
