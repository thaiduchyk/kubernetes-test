# frozen_string_literal: true

class ErrorSerializer < ActiveModel::Serializer
  attributes :uid, :code, :title, :details
  attribute :http_status_code, key: :status

  def uid
    [object.uid, time].join('-')
  end

  private

  def time
    Time.current.strftime('%Y%m%dT%H%M%S')
  end
end
