# frozen_string_literal: true

def time_to_milliseconds(t = Time.now)
  (t.to_f * 1000).to_i
end

def signed_request(method, uri, params: {}, token: nil, **kargs)
  token   ||= create(:api_token)
  headers = make_authorization_headers(token.access_key, token.secret_key)
  send method, uri, params: params, headers: headers.merge(kargs)
  response.mash_body
end

def make_authorization_headers(access_key, secret_key, **opts)
  payload = {
    access_key: access_key,
  }
  payload.merge! opts
  Hashie::Mash.new({ Authorization: "Bearer #{JWT.encode(payload, secret_key)}" })
end

def signed_get(uri, params: {}, token: nil, **kargs)
  signed_request :get, uri, params: params, token: token, **kargs
end

def signed_post(uri, params: {}, token: nil, **kargs)
  signed_request :post, uri, params: params, token: token, **kargs
end

def signed_put(uri, params: {}, token: nil, **kargs)
  signed_request :put, uri, params: params, token: token, **kargs
end

def signed_delete(uri, params: {}, token: nil, **kargs)
  signed_request :delete, uri, params: params, token: token, **kargs
end
