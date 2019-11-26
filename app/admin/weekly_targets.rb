ActiveAdmin.register WeeklyTarget do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :start_on, :plate_count
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs 'Details' do
      f.input :start_on, as: :datepicker, label: 'Week Start'
      f.input :plate_count, label: 'Plate Target'
    end
    f.actions
  end

  show do
    attributes_table do
      row :start_on do |wt|
        start = wt.start_on
        "#{start.strftime('%b %e')} - #{(start + 6.days).strftime('%b %e')}"
      end
      row :plate_count
    end
  end

  index do
    column :start_on do |wt|
      start = wt.start_on
      "#{start.strftime('%b %e')} - #{(start + 6.days).strftime('%b %e')}"
    end
    column :plate_count
    actions
  end
end
