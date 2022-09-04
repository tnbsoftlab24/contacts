module ApplicationHelper

  def subcat_prefix(depth)
    ("&nbsp;" * 4 * depth).html_safe
  end
  
  def category_options_array(current_id = 0,categories=[], parent_id=0, depth=0)
      Admin::JobCategory.where('parent_id = ? AND id != ?', parent_id, current_id ).order(:id).each do |category|
        categories << [subcat_prefix(depth) + category.title, category.id]
        category_options_array(current_id,categories, category.id, depth+1)
    end
  
    categories
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-success" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    # link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
    link_to title, params.permit(column).merge(sort: column, direction: direction, page: nil), { class: css_class }
  end

  def child_options_for_select(collection, children_method, group_label_method, child_value_method, child_label_method, options = {})
    body = ''
    collection.each do |item|
      children = item.send(children_method)
      if item.children.count != 0
        body << content_tag(:optgroup, child_options_for_select(children, children_method, group_label_method, child_value_method, child_label_method, options), :label => item.send(group_label_method))
      else
        body << content_tag(:option, item.send(child_label_method), :value => item.send(child_value_method))
      end
    end
    body.html_safe
  end


  def link_to_add_row(name, form, association, **args)
        new_object = form.object.send(association).klass.new
        id = new_object.object_id
        fields = form.fields_for(association, new_object, child_index: id) do |builder|
            render(association.to_s.singularize, form: builder)
      end
    link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_experience_row(name, form, association, **args)
        new_object = form.object.send(association).klass.new
        id = new_object.object_id
        fields = form.fields_for(association, new_object, child_index: id) do |builder|
            render(association.to_s.singularize, form: builder)
      end
        link_to(name, '#', class: "add_experience_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_adresse_row(name, form, association, **args)
      new_object = form.object.send(association).klass.new
      id = new_object.object_id
      fields = form.fields_for(association, new_object, child_index: id) do |builder|
          render(association.to_s.singularize, form: builder)
      end
      link_to(name, '#', class: "add_adresse_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_tarifs_row(name, form, association, **args)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize, form: builder)
    end
    link_to(name, '#', class: "add_tarifs_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_freetime_row(name, form, association, **args)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize, form: builder)
    end
    link_to(name, '#', class: "add_freetime_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end   
end
