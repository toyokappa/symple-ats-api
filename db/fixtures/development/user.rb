User.seed_once do |u|
  u.id = 1
  u.name = '豊川 雄太'
  u.nickname = 'toyokawa'
  u.email = 'toyokawa@symple.com'
  u.password = 'password'
  u.role = :admin
  u.level = 3
end

User.seed_once do |u|
  u.id = 2
  u.name = '田中 太郎'
  u.nickname = 'tanaka'
  u.email = 'tanaka@symple.com'
  u.password = 'password'
  u.role = :interviewer
  u.level = 2
end

User.seed_once do |u|
  u.id = 3
  u.name = '山田 次郎'
  u.nickname = 'yamada'
  u.email = 'yamada@symple.com'
  u.password = 'password'
  u.role = :viewer
  u.level = 1
end
