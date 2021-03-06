# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength
ActiveAdmin.register Mission do
  permit_params :author_id, :name, :description, :event, :delivery_expected,
                :max_member_count, :min_member_count,
                :start_date, :due_date

  index do
    selectable_column
    column :name
    column :description
    column :delivery_expected
    column :event
    column :due_date
    column :author
    actions
  end

  form do |f|
    f.inputs do
      f.input :author,
              collection: options_from_collection_for_select(Member.all, :id, :email)
      f.input :name
      f.input :description
      f.input :delivery_expected
      f.input :event
      f.input :max_member_count
      f.input :min_member_count
      f.input :start_date
      f.input :due_date
    end

    actions
  end
end
# rubocop: enable Metrics/BlockLength
