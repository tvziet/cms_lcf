Trestle.resource(:roles) do
  menu do
    group t('trestle.groups.configuration'), priority: :last do
      item :roles, icon: 'fa fa-suitcase', label: t('trestle.labels.roles')
    end
  end

  table do
    column :level, align: :center do |role|
      role.value(:level, role.level)
    end

    column :created_at, align: :center do |role|
      role.created_at.strftime('%d/%m/%y')
    end

    column :updated_at, align: :center do |role|
      role.updated_at.strftime('%d/%m/%y')
    end

    actions do |toolbar, _instance, admin|
      if (admin&.actions&.include?(:edit) && current_administrator.high_level?) || current_administrator.medium_level?
        toolbar.edit
        toolbar.delete
      end
    end
  end

  form do
    row do
      col(sm: 12) { select(:level, Role.values(:levels)) }
    end
  end

  params do |params|
    params.require(:role).permit(:level)
  end
end
