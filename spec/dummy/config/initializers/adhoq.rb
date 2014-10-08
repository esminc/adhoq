Adhoq.configure do |c|
  c.authorization = :adhoq_authorized?
  c.current_user  = :current_user
  c.storage       = [:local_file, Rails.root + "/tmp/adhoq/#{Rails.env}"]
end
