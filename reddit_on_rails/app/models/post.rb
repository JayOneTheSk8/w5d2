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
#

class Post < ApplicationRecord

end
