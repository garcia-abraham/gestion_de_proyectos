ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  #permit_params :email, :role, :name, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at

  permit_params [:name, :email, :password, :password_confirmation, :role]

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :role
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :name
    column :role
    actions
  end

end
