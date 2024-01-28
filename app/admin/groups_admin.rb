Trestle.resource(:groups) do
  menu do
    item :groups, icon: 'fa fa-briefcase', label: t('trestle.labels.groups')
  end

  table do
    column :name
    column :company_id, align: :center do |group|
      group.company.name
    end
    column :created_at, align: :center do |group|
      group.created_at.strftime('%d/%m/%y')
    end
    column :updated_at, align: :center do |group|
      group.updated_at.strftime('%d/%m/%y')
    end
    actions
  end

  form do
    text_field :name

    row do
      col(sm: 12) { collection_select :company_id, Company.all, :id, :name }
    end
  end

  params do |params|
    params.require(:group).permit(:name, :company_id)
  end
end
