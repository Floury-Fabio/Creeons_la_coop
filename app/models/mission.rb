# frozen_string_literal: true

# A Mission is an activity that has to be done for the Supermaket Team to function properly.
# Every member can create a mission
# Available methods: #addresses, #author, #due_date, #name, #description
class Mission < ApplicationRecord
  belongs_to :author, class_name: "Member", inverse_of: 'created_missions'
  has_and_belongs_to_many :members
  has_and_belongs_to_many :productors
  has_and_belongs_to_many :addresses

  validates :name, presence: true
  validates :description, presence: true
  validates :max_member_count, presence: true
  validates :min_member_count, presence: true

  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true
end
