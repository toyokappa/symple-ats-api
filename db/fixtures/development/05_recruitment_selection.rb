RecruitmentSelection.seed_once do |s|
  s.id = 1
  s.name = "書類選考"
  s.selection_type = :document
  s.position = 1
  s.recruitment_project_id = 1
end

RecruitmentSelection.seed_once do |s|
  s.id = 2
  s.name = "1次面接"
  s.selection_type = :interview
  s.position = 2
  s.recruitment_project_id = 1
end

RecruitmentSelection.seed_once do |s|
  s.id = 3
  s.name = "2次面接"
  s.selection_type = :interview
  s.position = 3
  s.recruitment_project_id = 1
end

RecruitmentSelection.seed_once do |s|
  s.id = 4
  s.name = "内定"
  s.selection_type = :offer
  s.position = 4
  s.recruitment_project_id = 1
end

RecruitmentSelection.seed_once do |s|
  s.id = 5
  s.name = "内定承諾"
  s.selection_type = :consent
  s.position = 5
  s.recruitment_project_id = 1
end

RecruitmentSelection.seed_once do |s|
  s.id = 6
  s.name = "見送り"
  s.selection_type = :failure
  s.position = 6
  s.recruitment_project_id = 1
end

RecruitmentSelection.seed_once do |s|
  s.id = 7
  s.name = "辞退"
  s.selection_type = :decline
  s.position = 7
  s.recruitment_project_id = 1
end
