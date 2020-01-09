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
    f.object.user = current_user
    f.inputs do
      f.input :particular
      f.input :amount
      f.input :recorded_at
      f.input :cashbook_category
      f.input :user
    end
    f.actions
  end
end