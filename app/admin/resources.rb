ActiveAdmin.register Resource do
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

    permit_params [:name, :price, :quantity]

    form do |f|
        f.inputs "Resource details" do
            f.input :name 
            f.input :price
            f.input :quantity
        end
        f.actions
    end

    index do
        selectable_column
        column :id
        column :name
        column :price
        actions
    end

end
