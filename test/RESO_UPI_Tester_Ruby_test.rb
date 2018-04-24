require 'test_helper'

class RESOUPITesterRubyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RESOUPITesterRuby::VERSION
  end

  def test_basic_functions
    good_upis = [
        "US-04015-N-11022331-R-N",
        "US-42049-49888-1213666-R-N",
        "US-36061-N-010237502R1-R-N",
        "US-36061-N-010237502R1-S-113",
        "US-06075-N-40010333-T-10",
        "US-13051-N-1122444-R-N",
        "US-36061-N-0122213-S-118",
        "US-04019-N-12401001H-B-65A",
        "US-123331-N-N-99798987-99",
    ];

    bad_upis = [
        "US-123331-N-87-99",
        "XX-123331-N-N-99798987-99",
        "OIOASPODASDO APOSAPSCAS" ,
    ];

    good_upis.each do |upi|
    	t = RESOUPITesterRuby::UPI.new upi
    	assert(t.is_valid, upi)
    end

    bad_upis.each do |upi|
    	t = RESOUPITesterRuby::UPI.new upi
    	refute(t.is_valid, upi)
    end
  end

  def test_state_code
    t = RESOUPITesterRuby::UPI.new
    t.set_sub_country_name('AL')
    assert_equal(t.get_sub_country_code, "01")
  end

  def test_county_code
    t = RESOUPITesterRuby::UPI.new
    t.set_sub_country_name('AL')
    t.set_sub_county_name('Autauga County')
    assert_equal(t.get_sub_county_code, "001")
  end
end
