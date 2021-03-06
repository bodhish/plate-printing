ActiveAdmin.register CashbookCategory do
  menu parent: 'Cashbook', label: 'Categories'
  actions :index, :show, :create, :edit, :new, :update
  permit_params :id, :name

  index do
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end
