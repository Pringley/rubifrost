require "rubifrost/version"
require 'open3'
require 'json'
require 'rubifrost/proxy'

class RuBifrost

  def self.python
    new 'python3 -mpybifrost.server'
  end

  def initialize bifrost_cmd
    @stdin, @stdout, @stderr, @wait_thr = Open3.popen3(bifrost_cmd)
  end

  def import module_name
    get_result({'module' => module_name})
  end

  def callmethod oid, method, params
    get_result({
      'oid' => oid,
      'method' => method,
      'params' => params.map { |param|
        deproxify param
      }
    })
  end

  def get_result request
    @stdin.write JSON.generate(request) + "\n"
    @stdin.flush
    line = @stdout.gets
    result = JSON.parse line
    raise RuntimeError, result['error'] if result.has_key? 'error'
    raise RuntimeError, 'no result' if not result.has_key? 'result'
    proxify result['result']
  end
  
  def deproxify obj
    case obj
    when Integer, Float, String, TrueClass, FalseClass, NilClass
      obj
    when Proxy
      {'__oid__' => obj.oid}
    when Hash
      Hash.new[obj.each_pair.map { |key, val|
        [deproxify(key), deproxify(val)]
      }]
    when Enumerable
      obj.map { |item| deproxify item }
    else
      raise RuntimeError, 'unexpected obj for deproxify'
    end
  end

  def proxify obj
    case obj
    when Integer, Float, String, TrueClass, FalseClass, NilClass
      obj
    when Hash
      if obj.has_key? "__oid__"
        Proxy.new obj["__oid__"], self
      else
        Hash.new[obj.each_pair.map { |key, val| [proxify(key), proxify(val)] }]
      end
    when Enumerable
      obj.map { |item| proxify item }
    else
      raise RuntimeError, 'unexpected obj for proxify'
    end
  end

end
