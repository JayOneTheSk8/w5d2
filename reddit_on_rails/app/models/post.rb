# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sub_id     :integer
#  user_id    :integer
#

class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :sub,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Sub

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
end
