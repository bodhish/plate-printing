ActiveAdmin.register PlateDimension do
  permit_params :id, :dimension, :name

  index do
    selectable_column
    id_column
    column :name
    column :dimension
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :dimension
    end
    f.actions
  end
end