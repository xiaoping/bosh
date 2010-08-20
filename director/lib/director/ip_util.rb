module Bosh::Director
  module IpUtil

    def each_ip(ranges)
      if ranges
        ranges.each do |range|
          parts = range.split("-")
          parts.each { |part| part.strip! }
          if parts.size == 1
            range = NetAddr::CIDR.create(parts[0])
            first_ip = range.first(:Objectify => true).to_i
            last_ip = range.last(:Objectify => true).to_i
            (first_ip .. last_ip).each do |ip|
              yield ip
            end
          elsif parts.size == 2
            first_ip = NetAddr::CIDR.create(parts[0])
            last_ip = NetAddr::CIDR.create(parts[1])
            raise ArgumentError unless first_ip.size == 1
            raise ArgumentError unless last_ip.size == 1
            (first_ip.to_i .. last_ip.to_i).each do |ip|
              yield ip
            end
          else
            raise ArgumentError
          end
        end
      end
    end

    def ip_to_i(ip)
      unless ip.kind_of?(Integer)
        unless ip.kind_of?(NetAddr::CIDR)
          ip = NetAddr::CIDR.create(ip)
        end
        ip = ip.to_i
      end
      ip
    end

    def ip_to_netaddr(ip)
      unless ip.kind_of?(NetAddr::CIDR)
        ip = NetAddr::CIDR.create(ip)
      end
      ip
    end

  end
end