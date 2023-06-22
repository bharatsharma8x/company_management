module EmployeesHelper

  def toggle_sort_order(current_order, column)
    if current_order.present? && params[:order_by] == column
      current_order == 'asc' ? 'desc' : 'asc'
    else
      'asc'
    end
  end

  # def sort_icon(column)
  #   if params[:order_by] == column && params[:order] == 'asc'
  #     content_tag(:i, nil, class: "fa fa-arrow-up")
  #   elsif params[:order_by] == column && params[:order] == 'desc'
  #     content_tag(:i, nil, class: "fa fa-arrow-down")
  #   end
  # end
end
