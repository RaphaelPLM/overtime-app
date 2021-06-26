100.times do |post|
    Post.create!(date: Date.today, rationale: "This is post number #{post}")
end