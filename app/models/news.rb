# == Schema Information
#
# Table name: news
#
#  id           :bigint           not null, primary key
#  body         :text
#  group_ids    :text             default([]), is an Array
#  public       :boolean          default(FALSE)
#  published_at :datetime
#  status       :integer          default(0)
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#
class News < ApplicationRecord
  extend HumanizeValues
  include HumanizeValue

  enum status: { draft: 0, published: 1, archived: 2 }
end
