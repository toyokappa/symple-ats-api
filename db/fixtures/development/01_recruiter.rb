Recruiter.seed_once do |r|
  r.id = 1
  r.name = '豊川 雄太'
  r.nickname = 'toyokawa'
  r.email = 'toyokawa@symple.com'
  r.password = 'password'
  r.level = 3
  r.confirmed_at = Time.zone.now
end

Recruiter.seed_once do |r|
  r.id = 2
  r.name = '田中 太郎'
  r.nickname = 'tanaka'
  r.email = 'tanaka@symple.com'
  r.password = 'password'
  r.level = 2
  r.confirmed_at = Time.zone.now
end

Recruiter.seed_once do |r|
  r.id = 3
  r.name = '山田 次郎'
  r.nickname = 'yamada'
  r.email = 'yamada@symple.com'
  r.password = 'password'
  r.level = 1
  r.confirmed_at = Time.zone.now
end
