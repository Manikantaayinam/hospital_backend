class PaginatedSerializer < ActiveModel::Serializer
  attr_reader :object, :serializer, :options

  def initialize(object, serializer:, options: {})
    @object = object
    @serializer = serializer
    @options = options
  end

  def serializable_hash
    {
      data: ActiveModelSerializers::SerializableResource.new(object, each_serializer: serializer, **options),
      meta: pagination_meta
    }
  end

  private

  def pagination_meta
    {
      current_page: object.current_page,
      per_page: object.limit_value,
      total_pages: object.total_pages,
      total_records: object.total_count
    }
  end
end
