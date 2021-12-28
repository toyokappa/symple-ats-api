OrganizationRecruiter.seed_once do |ro|
  ro.id = 1
  ro.organization_id = 1
  ro.recruiter_id = 1
  ro.role = :admin
end

OrganizationRecruiter.seed_once do |ro|
  ro.id = 2
  ro.organization_id = 1
  ro.recruiter_id = 2
  ro.role = :interviewer
end

OrganizationRecruiter.seed_once do |ro|
  ro.id = 3
  ro.organization_id = 1
  ro.recruiter_id = 3
  ro.role = :viewer
end

OrganizationRecruiter.seed_once do |ro|
  ro.id = 4
  ro.organization_id = 2
  ro.recruiter_id = 1
  ro.role = :interviewer
end
