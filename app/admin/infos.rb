# frozen_string_literal: true

ActiveAdmin.register Info do
  permit_params :title, :content, :author_id

  index do
    selectable_column
    column :title
    column :content
    column :author
    actions
  end

  form do |f|
    f.inputs do
      f.input :author,
              collection: options_from_collection_for_select(Member.all, :id, :email)
      f.input :title
      f.input :content
    end

    actions
  end
end
