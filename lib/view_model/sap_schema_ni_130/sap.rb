module ViewModel
  module SapSchemaNi130
    class Sap < ViewModel::SapSchemaNi130::CommonSchema
      def property_age_band
        construction_year
      end

      def construction_year
        xpath(%w[Construction-Year])
      end

      def cylinder_insul_thickness
        xpath(%w[Hot-Water-Store-Insulation-Thickness])
      end

      def cylinder_insulation_type
        xpath(%w[Hot-Water-Store-Insulation-Type])
      end

      def cylinder_size
        xpath(%w[Hot-Water-Store-Size])
      end

      def has_cylinder_thermostat
        xpath(%w[Has-Cylinder-Thermostat])
      end

      def mech_vent_sys_index_number
        xpath(%w[Mechanical-Vent-System-Index-Number])
      end

      def mechanical_vent_data_source
        xpath(%w[Mechanical-Ventilation-Data-Source])
      end

      def thermal_store
        xpath(%w[Thermal-Store])
      end

      def ventilation_type
        xpath(%w[Ventilation-Type])
      end

      def water_heating_fuel
        xpath(%w[Water-Fuel-Type])
      end
    end
  end
end
