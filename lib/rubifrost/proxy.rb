class RuBifrost::Proxy
  attr_reader :oid
  def initialize oid, bifrost
    @oid = oid
    @bifrost = bifrost
  end
  def method_missing(method, *params)
    @bifrost.callmethod @oid, method, params
  end
end
