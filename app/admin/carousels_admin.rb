Trestle.resource(:carousels) do
  menu do
    group t('trestle.groups.configuration'), priority: :last do
      item :carousels, icon: 'fa fa-picture-o', label: t('trestle.labels.carousels')
    end
  end

  table do
    column :active
    column :image do |carousel|
      if carousel.image?
        image_tag(carousel.image.url(:thumb), loading: 'lazy')
      else
        image_tag('fallback/carousel_default.jpeg', loading: 'lazy')
      end
    end
    column :created_at, align: :center do |carousel|
      carousel.created_at.strftime('%d/%m/%Y')
    end

    column :updated_at, align: :center do |carousel|
      carousel.updated_at.strftime('%d/%m/%Y')
    end
    actions
  end

  form do
    row do
      col(sm: 12) { check_box :active }
    end

    row do
      col(sm: 12) { file_field :image }
    end
  end
end
