class PhoneNumberSerializer < ActiveModel::Serializer
  attributes :id, :number, :number_kind, :cpm_code, :notes, :location_uid

  def location_uid
    object.location.uid
  end
end
