require 'test_helper'

module Demux
  class ConnectionTest < ActiveSupport::TestCase
    test "#entry_url requests a app entry url with account_id as payload" do
      connection = demux_connections(:one)
      app = demux_apps(:one)

      url = connection.entry_url
      token = url.match(/token=(?<token>.*)/)[:token]
      decoded_token = JWT.decode(token, app.secret, true, { algorithm: 'HS256' })

      assert_equal(
        connection.account_id,
        decoded_token.first["data"]["account_id"]
      )
    end
  end
end