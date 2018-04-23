require "RESO_UPI_Tester_Ruby/version"
require "csv"

module RESOUPITesterRuby

  class UPI

    @upi
    @country_name
    @country_code
    @sub_country_name
    @sub_country_code
    @sub_county_code
    @property_id
    @property_code
    @sub_property_code
    @is_valid = nil
    @valid_codes = nil

    def initialize(upi = false)
      if (upi) 
        self.set_upi(upi)
        self.parse_upi
      end

      @valid_codes = CSV.read(File.join(File.dirname(__FILE__), 'national_county.txt'))

    end

    def set_upi(upi)
    	@upi = upi
    end

    def get_country_name
    	@country_name
    end

    def set_country_name(country_name)
    	@country_name = country_name
    end

    def get_country_code
    	@country_code
    end

    def set_country_code(country_code)
        is_valid_code = false

        # for now just US and Canada
        if country_code == 'US'
           is_valid_code = true
        elsif country_code == 'CA'
           is_valid_code = true
        end

        if !is_valid_code
            @is_valid = false
        end

    	@country_code = country_code
    end

    def get_sub_country_name
    	@sub_country_name
    end

    def set_sub_country_name(sub_country_name)
    	@sub_country_name = sub_country_name
    end

    def get_sub_country_code
    	@sub_country_code
    end

    def set_sub_country_code(sub_country_code)
    	@sub_country_code = sub_country_code
    end

    def get_sub_county_code
    	@sub_county_code
    end

    def set_sub_county_code(sub_county_code)
    	@sub_county_code = sub_county_code
    end

    def get_property_id
    	@property_id
    end

    def set_property_id(property_id)
    	@property_id = property_id
    end

    def get_property_code
    	@property_code
    end

    def set_property_code(property_code)
    	@property_code = property_code
    end

    def get_sub_property_code
    	@sub_property_code
    end

    def set_sub_property_code(sub_property_code)
    	@sub_property_code = sub_property_code
    end

    def is_valid
    	@is_valid
    end

    def set_is_valid(is_valid)
    	@is_valid = is_valid
    end

    def to_upi
      data = [
          @country_code,
          @sub_country_code,
          @sub_county_code,
          @property_id,
          @property_code,
          @sub_property_code,
      ]

      self.class.set_upi(data.join("-"))

      # parse the new UPI so we can have a check for validity
      self.class.parse_upi

      @upi
    end

    def parse_upi
    	parts = @upi.split('-')

      if parts.count < 6 
        self.set_is_valid(false)
      else
          self.set_country_code(parts[0]) # eg US
          self.set_sub_country_code(parts[1]) # eg FIPS code or Int'l equivalent
          self.set_sub_county_code(parts[2]) # sub-county ID or N
          self.set_property_id(parts[3]) # parcel ID
          self.set_property_code(parts[4]) # R(n) (n being integer), S, T, B
          self.set_sub_property_code(parts[5]) # N, (int) unit number, lot number, or building ID number

          # if we still haven't set is_valid to false, set it to true
          if @is_valid.nil?
              self.set_is_valid(true)
          end
      end
    end
  end
end
