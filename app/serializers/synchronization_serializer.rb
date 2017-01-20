class SynchronizationSerializer < ActiveModel::Serializer
  attributes :id, :service_item_id,:state,:created_at,:updated_at,:ran_at,:run_at, :service_name
end
