module Presenter::Export
  class Domestic < Presenter::Export::Base
    def build
      view = {}
      view[:addendum] = @view_model.addendum
      view[:address] = address
      view[:assessment_id] = @view_model.assessment_id
      view[:assessor] = assessor
      view[:built_form] =
        enum_value(:built_form_string, @view_model.built_form)
      view[:co2_emissions_current_per_floor_area] =
        @view_model.co2_emissions_current_per_floor_area.to_i
      view[:construction_age_band] =
        enum_value(
          :construction_age_band_lookup,
          @view_model.main_dwelling_construction_age_band_or_year,
          @wrapper.schema_type,
          @view_model.report_type,
        )
      view[:current_carbon_emission] = @view_model.current_carbon_emission.to_f
      view[:current_energy_efficiency_band] =
        Helper::EnergyBandCalculator.domestic(@view_model.current_energy_rating)
      view[:current_energy_efficiency_rating] = @view_model.current_energy_rating
      view[:date_of_assessment] = @view_model.date_of_assessment
      view[:date_of_expiry] = @view_model.date_of_expiry
      view[:date_of_registration] = @view_model.date_of_registration
      view[:dwelling_type] = @view_model.dwelling_type
      view[:energy_consumption_potential] =
        @view_model.energy_consumption_potential.to_i
      view[:environmental_impact_current] = @view_model.environmental_impact_current
      view[:environmental_impact_potential] = @view_model.environmental_impact_potential
      if @view_model.respond_to?(:extensions_count) && !@view_model.extensions_count.nil?
        view[:extensions_count] = @view_model.extensions_count
      end
      view[:fixed_lighting_outlets_count] =
        @view_model.respond_to?(:fixed_lighting_outlets_count) ? @view_model.fixed_lighting_outlets_count : nil
      view[:glazed_area] = @view_model.glazed_area.to_i if @view_model.respond_to?(:glazed_area) && !@view_model
        .glazed_area.nil?
      if @view_model.respond_to?(:habitable_room_count) && !@view_model.habitable_room_count.nil?
        view[:habitable_room_count] = @view_model.habitable_room_count
      end
      view[:heat_demand] = heat_demand
      if @view_model.respond_to?(:heat_loss_corridor) && !@view_model.heat_loss_corridor.nil?
        view[:heat_loss_corridor] = @view_model.heat_loss_corridor.to_i
      end
      if @view_model.respond_to?(:heated_room_count) && !@view_model.heated_room_count.nil?
        view[:heated_room_count] = @view_model.heated_room_count
      end
      view[:heating_cost_current] = @view_model.heating_cost_current.to_f
      view[:heating_cost_potential] = @view_model.heating_cost_potential.to_f
      view[:hot_water_cost_current] = @view_model.hot_water_cost_current.to_f
      view[:hot_water_cost_potential] =
        @view_model.hot_water_cost_potential.to_f
      view[:hot_water_description] = @view_model.hot_water_description
      view[:hot_water_energy_efficiency_rating] =
        @view_model.hot_water_energy_efficiency_rating.to_i
      view[:hot_water_environmental_efficiency_rating] =
        @view_model.hot_water_environmental_efficiency_rating.to_i
      view[:level] = @view_model.level.to_i
      view[:lighting_cost_current] = @view_model.lighting_cost_current.to_f
      view[:lighting_cost_potential] = @view_model.lighting_cost_potential.to_f
      view[:lighting_description] = @view_model.lighting_description
      view[:lighting_energy_efficiency_rating] =
        @view_model.lighting_energy_efficiency_rating.to_i
      view[:lighting_environmental_efficiency_rating] =
        @view_model.lighting_environmental_efficiency_rating.to_i
      view[:low_energy_fixed_lighting_outlets_count] =
        @view_model.respond_to?(:low_energy_fixed_lighting_outlets_count) ? @view_model.low_energy_fixed_lighting_outlets_count : nil
      view[:low_energy_lighting] = @view_model.respond_to?(:low_energy_lighting) ? @view_model.low_energy_lighting&.to_i : nil
      view[:main_fuel_type] = @view_model.main_fuel_type
      view[:main_heating_controls_descriptions] =
        @view_model.all_main_heating_controls_descriptions
      view[:main_heating_descriptions] =
        @view_model.all_main_heating_descriptions
      view[:mains_gas] = @view_model.mains_gas if @view_model.respond_to?(:mains_gas) && !@view_model.mains_gas.nil?
      view[:multiple_glazed_proportion] =
        @view_model.respond_to?(:multiple_glazed_proportion) ? @view_model.multiple_glazed_proportion.to_i : nil
      view[:open_fireplaces_count] = @view_model.respond_to?(:open_fireplaces_count) ? @view_model.open_fireplaces_count : nil
      if @view_model.respond_to?(:photovoltaic_roof_area_percent) && !@view_model.photovoltaic_roof_area_percent.nil?
        view[:photovoltaic_roof_area_percent] =
          @view_model.photovoltaic_roof_area_percent.to_i
      end
      view[:potential_carbon_emission] =
        @view_model.potential_carbon_emission.to_f
      view[:potential_energy_efficiency_band] =
        Helper::EnergyBandCalculator.domestic(@view_model.potential_energy_rating)
      view[:potential_energy_efficiency_rating] = @view_model.potential_energy_rating
      view[:primary_energy_use] = @view_model.respond_to?(:primary_energy_use) ? @view_model.primary_energy_use.to_i : nil
      view[:property_age_band] = @view_model.respond_to?(:property_age_band) ? @view_model.property_age_band : nil
      view[:property_summary] = @view_model.property_summary
      view[:property_type] =
        enum_value(:property_type, @view_model.property_type)
      view[:recommended_improvements] =
        @view_model.improvements.map do |improvement|
          improvement[:energy_performance_band_improvement] =
            Helper::EnergyBandCalculator.domestic(improvement[:energy_performance_rating_improvement])
          improvement
        end
      if @view_model.respond_to?(:related_party_disclosure_number) && !@view_model.related_party_disclosure_number.nil?
        view[:related_party_disclosure_number] =
          @view_model.related_party_disclosure_number
      end
      unless @view_model.related_party_disclosure_text.nil?
        view[:related_party_disclosure_text] =
          @view_model.related_party_disclosure_text
      end
      view[:secondary_heating_description] =
        @view_model.secondary_heating_description
      view[:secondary_heating_energy_efficiency_rating] =
        @view_model.secondary_heating_energy_efficiency_rating.to_i
      view[:secondary_heating_environmental_efficiency_rating] =
        @view_model.secondary_heating_environmental_efficiency_rating.to_i
      view[:status] = @view_model.status
      view[:storey_count] = @view_model.storey_count if @view_model.respond_to?(:storey_count) && !@view_model
        .storey_count.nil?
      view[:tenure] = enum_value(:tenure, @view_model.respond_to?(:tenure) ? @view_model.tenure : nil)
      view[:top_storey] = @view_model.top_storey
      view[:total_floor_area] = @view_model.total_floor_area.to_f
      view[:transaction_type] =
        enum_value(:transaction_type, @view_model.respond_to?(:transaction_type) ? @view_model.transaction_type : nil)
      view[:type_of_assessment] = @wrapper.type.to_s
      if @view_model.respond_to?(:unheated_corridor_length) && !@view_model.unheated_corridor_length.nil?
        view[:unheated_corridor_length] = @view_model.unheated_corridor_length.to_i
      end
      view[:wind_turbine_count] = @view_model.wind_turbine_count
      view[:window_description] = @view_model.window_description
      view[:window_energy_efficiency_rating] =
        @view_model.window_energy_efficiency_rating.to_i
      view[:window_environmental_efficiency_rating] =
        @view_model.window_environmental_efficiency_rating.to_i
      view[:metadata] = metadata

      # RdSAP only: storey_count

      # date_registered is removed as duplicate of date_of_registration
      # estimated_energy_cost is removed since this is a calculated value
      view
    end
  end
end
