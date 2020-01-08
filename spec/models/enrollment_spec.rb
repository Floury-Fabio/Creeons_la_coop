# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  member_id  :bigint(8)        not null
#  mission_id :bigint(8)        not null
#  id         :bigint(8)        not null, primary key
#  start_time :time
#  end_time   :time
#

require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe "instanciation" do
    let(:enrollment) { create :enrollment }

    it "set :start_time default value to the associated mission start" do
      expect(enrollment.start_time.strftime('%T')).to eq enrollment.mission.start_date.strftime('%T')
    end
    it "set :end_time default value to the associated mission end" do
      expect(enrollment.end_time.strftime('%T')).to eq enrollment.mission.due_date.strftime('%T')
    end
  end
end
