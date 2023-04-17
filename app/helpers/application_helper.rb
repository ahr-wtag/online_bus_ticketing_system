module ApplicationHelper
  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end
end
