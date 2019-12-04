ActiveAdmin.register User do
  permit_params :email, :name, :password, :password_confirmation, :is_admin

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :is_admin
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
      f.input :is_admin
    end
    f.actions
  end

end
