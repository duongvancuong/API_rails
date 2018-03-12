module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_pagination page, per_page, total_pages, total_entries
    {
      pagination:{
        page: page.to_i,
        per_page: per_page,
        total_pages: total_pages,
        total_objects: total_entries
      }
    }
  end
end
