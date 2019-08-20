ActiveAdmin.register PlateDimension do
  permit_params :id, :dimension

  index do
    selectable_column
    id_column
    column :dimension
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :dimension
    end
    f.actions
  end
end