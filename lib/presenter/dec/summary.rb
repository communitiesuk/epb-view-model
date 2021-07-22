module Presenter
  module Dec
    class Summary
      TYPE_OF_ASSESSMENT = "DEC".freeze

      def initialize(view_model, schema_type)
        @view_model = view_model
        @schema_type = schema_type.to_s
      end

      def to_hash
        {
          assessment_id: @view_model.assessment_id,
          date_of_assessment: @view_model.date_of_assessment,
          date_of_expiry: @view_model.date_of_expiry,
          date_of_registration: @view_model.date_of_registration,
          address: {
            address_id: @view_model.address_id,
            address_line1: @view_model.address_line1,
            address_line2: @view_model.address_line2,
            address_line3: @view_model.address_line3,
            address_line4: @view_model.address_line4,
            town: @view_model.town,
            postcode: @view_model.postcode,
          },
          type_of_assessment: TYPE_OF_ASSESSMENT,
          schema_version: @schema_type.gsub(/[a-zA-Z-]/, "").to_f,
          report_type: @view_model.report_type,
          current_assessment: {
            date: @view_model.current_assessment_date,
            energy_efficiency_rating: @view_model.energy_efficiency_rating,
            energy_efficiency_band:
              Helper::EnergyBandCalculator.commercial(
                @view_model.energy_efficiency_rating.to_i,
              ),
            heating_co2: @view_model.current_heating_co2,
            electricity_co2: @view_model.current_electricity_co2,
            renewables_co2: @view_model.current_renewables_co2,
          },
          year1_assessment: {
            date: @view_model.year1_assessment_date,
            energy_efficiency_rating: @view_model.year1_energy_efficiency_rating,
            energy_efficiency_band:
              Helper::EnergyBandCalculator.commercial(
                @view_model.year1_energy_efficiency_rating.to_i,
              ),
            heating_co2: @view_model.year1_heating_co2,
            electricity_co2: @view_model.year1_electricity_co2,
            renewables_co2: @view_model.year1_renewables_co2,
          },
          year2_assessment: {
            date: @view_model.year2_assessment_date,
            energy_efficiency_rating: @view_model.year2_energy_efficiency_rating,
            energy_efficiency_band:
              Helper::EnergyBandCalculator.commercial(
                @view_model.year2_energy_efficiency_rating.to_i,
              ),
            heating_co2: @view_model.year2_heating_co2,
            electricity_co2: @view_model.year2_electricity_co2,
            renewables_co2: @view_model.year2_renewables_co2,
          },
          technical_information: {
            main_heating_fuel: @view_model.main_heating_fuel,
            building_environment: @view_model.building_environment,
            floor_area: @view_model.floor_area,
            occupier: @view_model.occupier,
            asset_rating: @view_model.asset_rating,
            annual_energy_use_fuel_thermal:
              @view_model.annual_energy_use_fuel_thermal,
            annual_energy_use_electrical:
              @view_model.annual_energy_use_electrical,
            typical_thermal_use: @view_model.typical_thermal_use,
            typical_electrical_use: @view_model.typical_electrical_use,
            renewables_fuel_thermal: @view_model.renewables_fuel_thermal,
            renewables_electrical: @view_model.renewables_electrical,
          },
          assessor: {
            scheme_assessor_id: @view_model.scheme_assessor_id,
            name: @view_model.assessor_name,
            company_details: {
              name: @view_model.company_name,
              address: @view_model.company_address,
            },
            contact_details: {
              email: @view_model.assessor_email,
              telephone: @view_model.assessor_telephone,
            },
          },
          administrative_information: {
            issue_date: @view_model.date_of_issue,
            calculation_tool: @view_model.calculation_tool,
            related_party_disclosure: @view_model.dec_related_party_disclosure,
            related_rrn: @view_model.related_rrn,
          },
        }
      end
    end
  end
end
