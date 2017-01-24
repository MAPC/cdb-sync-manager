class Import < ActiveModelSerializers::Model
  include Her::Model

  include_root_in_json = true
end
