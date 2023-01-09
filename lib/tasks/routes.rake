task routes: :environment do
  Rails.application.eager_load!
  models = ApplicationRecord.descendants.collect(&:name).join(" -g ").prepend(" -g ").downcase
  puts `bundle exec rails routes #{models}`
end
