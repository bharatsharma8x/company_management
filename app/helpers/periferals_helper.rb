module PeriferalsHelper
  def toggle_sort_order(current_order, column)
    if current_order.present? && params[:order_by] == column
      current_order == 'asc' ? 'desc' : 'asc'
    else
      'asc'
    end
  end
end
