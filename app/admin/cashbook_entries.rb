ActiveAdmin.register CashbookEntry do
  permit_params :id, :recorded_at, :particular, :amount, :cashbook_category, :user

  index do
    column :particular
    column :amount
    column :recorded_at
    column :cashbook_category
    column :user
    actions
  end

  filter :name

  form do |f|
    f.object.recorded_at = DateTime.now
    f.object.recorded_by = current_user
    f.inputs do
      f.input :particular
      f.input :amount
      f.input :recorded_at
      f.input :category
      f.input :recorded_by
    end
    f.actions
  end
end