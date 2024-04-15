Trestle.resource(:footers) do
  menu do
    group t('trestle.groups.configuration'), priority: :last do
      item :footers, icon: 'fa fa-wrench'
    end
  end

  table do
    column :logo
    column :company_info
    column :company_phone
    column :company_email
    column :company_address_info
    column :created_at, align: :center
    column :updated_at, align: :center
    actions
  end

  form do |_footer|
    row do
      col(sm: 12) { file_field :logo }
    end

    row do
      col(sm: 6) { text_field :company_info }
      col(sm: 6) { text_field :company_phone }
    end

    row do
      col(sm: 6) { text_field :company_email }
      col(sm: 6) { text_field :company_address_info }
    end
  end

  params do |params|
    params.require(:footer).permit(:logo, :company_info, :company_phone, :company_email, :company_address_info)
  end
end
