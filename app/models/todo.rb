# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  status     :integer          default(0)
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Todo < ApplicationRecord
  validates :title, presence: true
end
