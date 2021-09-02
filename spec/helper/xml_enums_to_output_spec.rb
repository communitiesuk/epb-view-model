RSpec.shared_context "with common node values" do
  let(:enum_built_form) do
    {
      "1" => "Detached",
      "2" => "Semi-Detached",
      "3" => "End-Terrace",
      "4" => "Mid-Terrace",
      "5" => "Enclosed End-Terrace",
      "6" => "Enclosed Mid-Terrace",
      "NR" => "Not Recorded",
    }
  end
  let(:enum_rdsap_main_fuel) do
    {
      "0" =>
        "To be used only when there is no heating/hot-water system or data is from a community network",
      "1" =>
        "mains gas - this is for backwards compatibility only and should not be used",
      "2" =>
        "LPG - this is for backwards compatibility only and should not be used",
      "3" => "bottled LPG",
      "4" =>
        "oil - this is for backwards compatibility only and should not be used",
      "5" => "anthracite",
      "6" => "wood logs",
      "7" => "bulk wood pellets",
      "8" => "wood chips",
      "9" => "dual fuel - mineral + wood",
      "10" =>
        "electricity - this is for backwards compatibility only and should not be used",
      "11" =>
        "waste combustion - this is for backwards compatibility only and should not be used",
      "12" =>
        "biomass - this is for backwards compatibility only and should not be used",
      "13" =>
        "biogas - landfill - this is for backwards compatibility only and should not be used",
      "14" =>
        "house coal - this is for backwards compatibility only and should not be used",
      "15" => "smokeless coal",
      "16" => "wood pellets in bags for secondary heating",
      "17" => "LPG special condition",
      "18" => "B30K (not community)",
      "19" => "bioethanol",
      "20" => "mains gas (community)",
      "21" => "LPG (community)",
      "22" => "oil (community)",
      "23" => "B30D (community)",
      "24" => "coal (community)",
      "25" => "electricity (community)",
      "26" => "mains gas (not community)",
      "27" => "LPG (not community)",
      "28" => "oil (not community)",
      "29" => "electricity (not community)",
      "30" => "waste combustion (community)",
      "31" => "biomass (community)",
      "32" => "biogas (community)",
      "33" => "house coal (not community)",
      "34" => "biodiesel from any biomass source",
      "35" => "biodiesel from used cooking oil only",
      "36" => "biodiesel from vegetable oil only (not community)",
      "37" => "appliances able to use mineral oil or liquid biofuel",
      "51" => "biogas (not community)",
      "56" =>
        "heat from boilers that can use mineral oil or biodiesel (community)",
      "57" =>
        "heat from boilers using biodiesel from any biomass source (community)",
      "58" => "biodiesel from vegetable oil only (community)",
      "99" => "from heat network data (community)",
    }
  end
  let(:enum_sap_main_fuel) do
    {
      "1" => "Gas: mains gas",
      "2" => "Gas: bulk LPG",
      "3" => "Gas: bottled LPG",
      "4" => "Oil: heating oil",
      "7" => "Gas: biogas",
      "8" => "LNG",
      "9" => "LPG subject to Special Condition 18",
      "10" => "Solid fuel: dual fuel appliance (mineral and wood)",
      "11" => "Solid fuel: house coal",
      "12" => "Solid fuel: manufactured smokeless fuel",
      "15" => "Solid fuel: anthracite",
      "20" => "Solid fuel: wood logs",
      "21" => "Solid fuel: wood chips",
      "22" => "Solid fuel: wood pellets (in bags, for secondary heating)",
      "23" =>
        "Solid fuel: wood pellets (bulk supply in bags, for main heating)",
      "36" => "Electricity: electricity sold to grid",
      "37" => "Electricity: electricity displaced from grid",
      "39" => "Electricity: electricity, unspecified tariff",
      "41" => "Community heating schemes: heat from electric heat pump",
      "42" => "Community heating schemes: heat from boilers - waste combustion",
      "43" => "Community heating schemes: heat from boilers - biomass",
      "44" => "Community heating schemes: heat from boilers - biogas",
      "45" => "Community heating schemes: waste heat from power stations",
      "46" => "Community heating schemes: geothermal heat source",
      "48" => "Community heating schemes: heat from CHP",
      "49" => "Community heating schemes: electricity generated by CHP",
      "50" =>
        "Community heating schemes: electricity for pumping in distribution network",
      "51" => "Community heating schemes: heat from mains gas",
      "52" => "Community heating schemes: heat from LPG",
      "53" => "Community heating schemes: heat from oil",
      "54" => "Community heating schemes: heat from coal",
      "55" => "Community heating schemes: heat from B30D",
      "56" =>
        "Community heating schemes: heat from boilers that can use mineral oil or biodiesel",
      "57" =>
        "Community heating schemes: heat from boilers using biodiesel from any biomass source",
      "58" => "Community heating schemes: biodiesel from vegetable oil only",
      "72" => "biodiesel from used cooking oil only",
      "73" => "biodiesel from vegetable oil only",
      "74" => "appliances able to use mineral oil or liquid biofuel",
      "75" => "B30K",
      "76" => "bioethanol from any biomass source",
      "99" => "Community heating schemes: special fuel",
    }
  end
  let(:rdsap_report_type) { "2" }
  let(:sap_report_type) { "3" }
end

RSpec.describe Helper::XmlEnumsToOutput do
  let(:helper) { described_class }

  include_context("with common node values")

  context "when a Built-Form XML value is passed to the BUILT_FORM enum" do
    context "and the XML does not have the specified node" do
      it "returns nil for Open Data Communities" do
        response = helper.built_form_string(nil)
        expect(response).to be_nil
      end
    end

    context "when the XML does have the specified node" do
      it "returns the string when you pass as the argument" do
        enum_built_form.each do |key, value|
          response = helper.built_form_string(key)
          expect(response).to eq(value)
        end
      end
    end

    it "returns nil for any other value outside of the enum given a hash" do
      response = helper.built_form_string({ "hello": 20 })
      expect(response).to be_nil
    end

    it "returns nil for any other value outside of the enum given a string" do
      response = helper.built_form_string("Any other value")
      expect(response).to be_nil
    end
  end

  context "when an EnergyEfficiencySummaryCode type XML value is passed to the RATINGS enum" do
    context "and the XML has a value contained in the enum" do
      it "returns the correct string value for Open Data Communities" do
        expect(described_class.energy_rating_string("2")).to eq("Poor")
        expect(described_class.energy_rating_string("0")).to eq("N/A")
        expect(described_class.energy_rating_string("4")).to eq("Good")
      end
    end

    context "and the XML has a value outside of the enum" do
      it "returns nil if the wrong type or key out of range is passed" do
        expect(described_class.energy_rating_string("A")).to be_nil
        expect(described_class.energy_rating_string("10")).to be_nil
        expect(described_class.energy_rating_string([0, 0])).to be_nil
      end
    end
  end

  context "when the Energy-Tariff XML value is passed to the ENERGY_TARIFF enum" do
    it "finds the value in the enum and returns the correct string value" do
      expect(described_class.energy_tariff("1", rdsap_report_type)).to eq(
        "dual",
      )
      expect(described_class.energy_tariff("1", sap_report_type)).to eq(
        "standard tariff",
      )
      expect(described_class.energy_tariff("ND", sap_report_type)).to eq(
        "not applicable",
      )
      expect(described_class.energy_tariff("ND", rdsap_report_type)).to eq(
        "ND",
      )
    end

    it "does not find the value in the enum and returns the same value" do
      expect(described_class.energy_tariff("test", rdsap_report_type)).to eq("test")
      expect(described_class.energy_tariff("test", sap_report_type)).to eq("test")
    end
  end

  context "when the Main-Fuel-Type XML value is passed to the RDSAP_MAIN_FUEL enum" do
    it "does not find a value in the enum and returns nil" do
      expect(described_class.main_fuel_rdsap(nil)).to be_nil
      expect(described_class.main_fuel_rdsap("hello")).to be_nil
    end

    it "returns nil if the value is not the correct type" do
      expect(described_class.main_fuel_rdsap({ "hello": 1 })).to be_nil
      expect(described_class.main_fuel_rdsap(1)).to be_nil
    end

    it "and the value is in the lookup it return the expected string" do
      enum_rdsap_main_fuel.each do |key, value|
        response = helper.main_fuel_rdsap(key)
        expect(response).to eq(value)
      end
    end
  end

  context "when the Main-Fuel-Type XML value is passed to the SAP_MAIN_FUEL enum" do
    it "does not find a value in the enum and returns nil" do
      expect(described_class.main_fuel_sap(nil)).to be_nil
      expect(
        described_class.main_fuel_sap("any other value"),
      ).to be_nil
    end

    it "returns nil if the value is not the correct type" do
      expect(described_class.main_fuel_sap({ "hello": 1 })).to be_nil
      expect(described_class.main_fuel_sap(1)).to be_nil
    end

    it "and the value is in the lookup it return the expected string" do
      enum_sap_main_fuel.each do |key, value|
        response = helper.main_fuel_sap(key)
        expect(response).to eq(value)
      end
    end
  end

  context "when the Glazing-Type XML value is passed to to the RdSAP glazed_type enum" do
    it "does not find a value in the enum and returns nil" do
      expect(described_class.glazed_type_rdsap(nil)).to be_nil
      expect(
        described_class.glazed_type_rdsap("Any other value"),
      ).to be_nil
    end

    it "and the value is in the lookup, it returns the expected string" do
      expect(described_class.glazed_type_rdsap("1")).to eq(
        "double glazing installed before 2002",
      )
      expect(described_class.glazed_type_rdsap("3")).to eq(
        "double glazing, unknown install date",
      )
      expect(described_class.glazed_type_rdsap("5")).to eq(
        "single glazing",
      )
    end

    it "returns nil if the value is not the correct type" do
      expect(
        described_class.glazed_type_rdsap({ "hash": "3" }),
      ).to be_nil
      expect(described_class.glazed_type_rdsap(3)).to be_nil
    end
  end

  context "when the Glazing-Area XML value is passed to to the RdSAP glazed_area enum" do
    it "does not find a value in the enum and returns nil" do
      expect(described_class.glazed_area_rdsap(nil)).to be_nil
      expect(
        described_class.glazed_area_rdsap("Any other value"),
      ).to be_nil
    end

    it "and the value is in the lookup, it returns the expected string" do
      expect(described_class.glazed_area_rdsap("1")).to eq("Normal")
      expect(described_class.glazed_area_rdsap("3")).to eq(
        "Less Than Typical",
      )
      expect(described_class.glazed_area_rdsap("5")).to eq(
        "Much Less Than Typical",
      )
      expect(described_class.glazed_area_rdsap("ND")).to eq(
        "Not Defined",
      )
    end
  end

  context "when the Tenure XML value is passed to the tenure enum" do
    it "and the value is in the lookup, it returns the expected string" do
      expect(described_class.tenure("1")).to eq("Owner-occupied")
      expect(described_class.tenure("ND")).to eq(
        "Not defined - use in the case of a new dwelling for which the intended tenure in not known. It is not to be used for an existing dwelling",
      )
    end

    it "returns the xml value if the entered value is not in the lookup" do
      expect(described_class.tenure("Hello, this is a value")).to eq(
        "Hello, this is a value",
      )
      expect(described_class.tenure(nil)).to be_nil
      expect(described_class.tenure(%w[1 2 3])).to eq(%w[1 2 3])
    end
  end

  context "when the Transaction-Type xml value is passed to the transaction type enum" do
    it "and the value is in the lookup, it returns the expected string" do
      expect(described_class.transaction_type("1")).to eq(
        "marketed sale",
      )
      expect(described_class.transaction_type("3", "3")).to eq(
        "rental (social) - this is for backwards compatibility only and should not be used",
      )
      expect(described_class.transaction_type("12", "3")).to eq(
        "Stock condition survey",
      )
      expect(described_class.transaction_type("12")).to eq(
        "RHI application",
      )
      expect(described_class.transaction_type("13", "3")).to eq("13")
    end
  end

  context "when the Construction-Age-Band xml value is passed to the construction age band enum" do
    it "returns the expected description for RdSAP exclusive schemas" do
      expect(
        described_class.construction_age_band_lookup(
          "A",
          "RdSAP-Schema-20.0.0",
          rdsap_report_type,
        ),
      ).to eq("England and Wales: before 1900")

      expect(
        described_class.construction_age_band_lookup(
          "B",
          "RdSAP-Schema-18.0",
          rdsap_report_type,
        ),
      ).to eq("England and Wales: 1900-1929")

      expect(
        described_class.construction_age_band_lookup(
          "C",
          "RdSAP-Schema-17.1",
          rdsap_report_type,
        ),
      ).to eq("England and Wales: 1930-1949")
    end

    it "returns the expected description for K values" do
      expect(
        described_class.construction_age_band_lookup(
          "K",
          "SAP-Schema-18.0.0",
          sap_report_type,
        ),
      ).to eq("England and Wales: 2007-2011")
      expect(
        described_class.construction_age_band_lookup(
          "K",
          "SAP-Schema-18.0.0",
          rdsap_report_type,
        ),
      ).to eq("England and Wales: 2007-2011")

      expect(
        described_class.construction_age_band_lookup(
          "K",
          "SAP-Schema-16.3",
          rdsap_report_type,
        ),
      ).to eq("England and Wales: 2007 onwards")
      expect(
        described_class.construction_age_band_lookup(
          "K",
          "SAP-Schema-16.3",
          sap_report_type,
        ),
      ).to eq("England and Wales: 2007 onwards")

      expect(
        described_class.construction_age_band_lookup(
          "K",
          "SAP-Schema-12.0",
          rdsap_report_type,
        ),
      ).to eq("Post-2006")
      expect(
        described_class.construction_age_band_lookup(
          "K",
          "SAP-Schema-12.0",
          sap_report_type,
        ),
      ).to eq("England and Wales: 2007 onwards")

      expect(
        described_class.construction_age_band_lookup(
          "K",
          "SAP-Schema-10.2",
          rdsap_report_type,
        ),
      ).to eq("England and Wales: 2007-2011")
      expect(
        described_class.construction_age_band_lookup(
          "K",
          "SAP-Schema-10.2",
          sap_report_type,
        ),
      ).to eq("England and Wales: 2007-2011")

      expect(
        described_class.construction_age_band_lookup(
          "K",
          "RdSAP-Schema-20.0.0",
          rdsap_report_type,
        ),
      ).to eq("England and Wales: 2007-2011")
      expect(
        described_class.construction_age_band_lookup(
          "K",
          "RdSAP-Schema-20.0.0",
          sap_report_type,
        ),
      ).to eq("England and Wales: 2007-2011")
    end

    it "returns the expected description for L values" do
      expect(
        described_class.construction_age_band_lookup(
          "L",
          "SAP-Schema-18.0.0",
          rdsap_report_type,
        ),
      ).to eq("England and Wales: 2012 onwards")

      expect(
        described_class.construction_age_band_lookup(
          "L",
          "SAP-Schema-16.3",
          rdsap_report_type,
        ),
      ).to eq("L")
      expect(
        described_class.construction_age_band_lookup(
          "L",
          "SAP-Schema-16.3",
          sap_report_type,
        ),
      ).to eq("L")
    end

    it "returns the expected description for NR values" do
      expect(
        described_class.construction_age_band_lookup(
          "NR",
          "SAP-Schema-16.1",
          rdsap_report_type,
        ),
      ).to eq("Not recorded")
      expect(
        described_class.construction_age_band_lookup(
          "NR",
          "SAP-Schema-16.1",
          sap_report_type,
        ),
      ).to eq("NR")

      expect(
        described_class.construction_age_band_lookup(
          "NR",
          "SAP-Schema-16.0",
          rdsap_report_type,
        ),
      ).to eq("NR")
    end

    it "returns the expected description for 0 values" do
      expect(
        described_class.construction_age_band_lookup(
          "0",
          "SAP-Schema-17.0",
          rdsap_report_type,
        ),
      ).to eq("0")
      expect(
        described_class.construction_age_band_lookup(
          "0",
          "SAP-Schema-17.0",
          sap_report_type,
        ),
      ).to eq("0")

      expect(
        described_class.construction_age_band_lookup(
          "0",
          "SAP-Schema-16.3",
          rdsap_report_type,
        ),
      ).to eq("Not applicable")
      expect(
        described_class.construction_age_band_lookup(
          "0",
          "SAP-Schema-16.3",
          sap_report_type,
        ),
      ).to eq("0")

      expect(
        described_class.construction_age_band_lookup(
          "0",
          "SAP-Schema-10.2",
          rdsap_report_type,
        ),
      ).to eq("0")
      expect(
        described_class.construction_age_band_lookup(
          "0",
          "SAP-Schema-10.2",
          sap_report_type,
        ),
      ).to eq("0")
    end

    it "returns the expected description for empty values" do
      expect(
        described_class.construction_age_band_lookup(
          nil,
          "SAP-Schema-18.0.0",
          rdsap_report_type,
        ),
      ).to be_nil
      expect(
        described_class.construction_age_band_lookup(
          nil,
          "SAP-Schema-18.0.0",
          sap_report_type,
        ),
      ).to be_nil

      expect(
        described_class.construction_age_band_lookup(
          "Any other content",
          "RdSAP-Schema-20.0.0",
          rdsap_report_type,
        ),
      ).to eq("Any other content")
      expect(
        described_class.construction_age_band_lookup(
          "Any other content",
          "RdSAP-Schema-20.0.0",
          sap_report_type,
        ),
      ).to eq("Any other content")

      expect(
        described_class.construction_age_band_lookup(
          "",
          "RdSAP-Schema-20.0.0",
          rdsap_report_type,
        ),
      ).to be_nil
      expect(
        described_class.construction_age_band_lookup(
          "",
          "RdSAP-Schema-20.0.0",
          sap_report_type,
        ),
      ).to be_nil
    end
  end

  context "when the Property-Type xml value is passed to the transaction type enum" do
    it "and the value is in the lookup, it returns the expected string" do
      expect(described_class.property_type("0")).to eq("House")
      expect(described_class.property_type("4")).to eq("Park home")
    end
  end

  context "when the Heat-Loss-Corridor xml value is passed to the transaction type enum" do
    it "does not find a value in the enum and returns nil" do
      expect(described_class.heat_loss_corridor(nil)).to be_nil
      expect(
        described_class.heat_loss_corridor("Any other value"),
      ).to eq("Any other value")
    end

    it "and the value is in the lookup, it returns the expected string" do
      expect(described_class.heat_loss_corridor("0")).to eq(
        "no corridor",
      )
      expect(described_class.heat_loss_corridor("2")).to eq(
        "unheated corridor",
      )
    end
  end

  context "when the Mechanical-Ventilation xml value is passed to the transaction type enum" do
    it "does not find a value in the enum and returns nil" do
      expect(
        described_class.mechanical_ventilation(
          nil,
          "RdSAP-Schema-20.0.0",
          rdsap_report_type,
        ),
      ).to be_nil
      expect(
        described_class.mechanical_ventilation(
          "Any other value",
          "RdSAP-Schema-20.0.0",
          rdsap_report_type,
        ),
      ).to eq("Any other value")
    end

    it "and the value is in the lookup, it returns the expected string" do
      expect(
        described_class.mechanical_ventilation(
          "0",
          "RdSAP-Schema-20.0.0",
          rdsap_report_type,
        ),
      ).to eq("natural")
      expect(
        described_class.mechanical_ventilation(
          "2",
          "RdSAP-Schema-20.0.0",
          rdsap_report_type,
        ),
      ).to eq("mechanical, extract only")
      expect(
        described_class.mechanical_ventilation(
          "0",
          "SAP-Schema-11.2",
          rdsap_report_type,
        ),
      ).to eq("none")
      expect(
        described_class.mechanical_ventilation(
          "2",
          "SAP-Schema-11.2",
          rdsap_report_type,
        ),
      ).to eq("mechanical - non recovering")
      expect(
        described_class.mechanical_ventilation(
          "0",
          "SAP-Schema-NI-11.2",
          rdsap_report_type,
        ),
      ).to eq("none")
    end
  end

  context "when the CECP Transaction-Type xml value is passed to the transaction type enum" do
    it "and the value is in the lookup, it returns the expected string" do
      expect(described_class.cepc_transaction_type("1")).to eq(
        "Mandatory issue (Marketed sale)",
      )
      expect(described_class.cepc_transaction_type("3")).to eq(
        "Mandatory issue (Property on construction).",
      )
      expect(described_class.cepc_transaction_type("12")).to eq("12")
    end
  end

  context "when the Cylinder-Insulation-Thickness/Hot-Water-Store-Insulation-Thickness xml value is passed to the cylinder_insulation_thickness enum" do
    it "does not find a value in the enum and returns nil if RdSAP or value if SAP" do
      expect(described_class.cylinder_insulation_thickness(nil)).to be_nil
      expect(
        described_class.cylinder_insulation_thickness("Any other value", "3"),
        ).to eq("Any other value")
    end

    it "and the Cylinder-Insulation-Thickness value is in the lookup, it returns the expected string" do
      expect(described_class.cylinder_insulation_thickness("25")).to eq("25 mm")
      expect(described_class.cylinder_insulation_thickness("160")).to eq("160 mm")
    end

    it "and the Hot-Water-Store-Insulation-Thickness value is in the lookup, it returns the expected string" do
      expect(described_class.cylinder_insulation_thickness("25", "3")).to eq("25")
      expect(described_class.cylinder_insulation_thickness("160", "3")).to eq("160")
    end
  end

  context "when the Ventilation Type xml value is passed to the ventilation type enum" do
    it "and the value is in the lookup, it returns the expected string" do
      expect(described_class.ventilation_type("1")).to eq("natural with intermittent extract fans")
      expect(described_class.ventilation_type("5")).to eq("mechanical extract, centralised (MEV c)")
      expect(described_class.ventilation_type("10")).to eq("natural with intermittent extract fans and passive vents")
    end

    it "returns the default value for 9" do
      expect(described_class.ventilation_type("9")).to eq("natural with intermittent extract fans and/or passive vents.  For backwards compatibility only, do not use.")
    end

    it "returns a truncated version of 9 for SAP-NI schemas" do
      expect(described_class.ventilation_type("9", "SAP-Schema-NI-16.1")).to eq("natural with intermittent extract fans and/or passive vents")
      expect(described_class.ventilation_type("9", "SAP-Schema-NI-13.0")).to eq("natural with intermittent extract fans and/or passive vents")
    end
  end

  context "when the Water-Heating-Fuel/Water-Fuel-Type xml value is passed to the water heating fuel enum" do
    it "and the value for Water-Heating-Fuel is in the RdSAP schema, it returns the expected string" do
      expect(described_class.water_heating_fuel("2", "RdSAP-Schema-20.0.0".to_sym)).to eq("LPG - this is for backwards compatibility only and should not be used")
      expect(described_class.water_heating_fuel("7", "RdSAP-Schema-18.0".to_sym)).to eq("bulk wood pellets")
      expect(described_class.water_heating_fuel("7", "RdSAP-Schema-NI-17.3".to_sym)).to eq("bulk wood pellets")
    end

    it "and the value for Water-Fuel-Type is in the SAP schema, it returns the expected string" do
      expect(described_class.water_heating_fuel("7", "SAP-Schema-17.0".to_sym, "3")).to eq("Gas: biogas")
      expect(described_class.water_heating_fuel("1", "SAP-Schema-16.3".to_sym, "3")).to eq("Gas: mains gas")
      expect(described_class.water_heating_fuel("1", "SAP-Schema-NI-18.0.0".to_sym, "3")).to eq("Gas: mains gas")
    end

    it "and the value for Water-Heating-Fuel is in the SAP schema, and it is an RdSAP report_type, it returns the expected string" do
      expect(described_class.water_heating_fuel("1", "SAP-Schema-15.0".to_sym, "2")).to eq("mains gas - this is for backwards compatibility only and should not be used")
      expect(described_class.water_heating_fuel("4", "SAP-Schema-15.0".to_sym, "2")).to eq("oil - this is for backwards compatibility only and should not be used")
      expect(described_class.water_heating_fuel("4", "SAP-Schema-NI-15.0".to_sym, "2")).to eq("oil - this is for backwards compatibility only and should not be used")
    end

    it "and the value for Water-Heating-Fuel is in the SAP Schema 14.2 and older, and it is an RdSAP report_type" do
      expect(described_class.water_heating_fuel("1", "SAP-Schema-14.2".to_sym, "2")).to eq("mains gas")
      expect(described_class.water_heating_fuel("4", "SAP-Schema-13.0".to_sym, "2")).to eq("oil")
      expect(described_class.water_heating_fuel("4", "SAP-Schema-NI-13.0".to_sym, "2")).to eq("oil")
    end

    it "and the value is nil, it returns nil" do
      expect(described_class.water_heating_fuel(nil, "SAP-Schema-16.3".to_sym, "3")).to be_nil
    end

  end
end
