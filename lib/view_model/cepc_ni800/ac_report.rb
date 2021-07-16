module ViewModel
  module CepcNi800
    class AcReport < ViewModel::CepcNi800::CommonSchema
      def related_party_disclosure
        xpath(%w[ACI-Related-Party-Disclosure])
      end

      def executive_summary
        xpath(%w[Executive-Summary])
      end

      def extract_aci_recommendations(nodes)
        nodes.map { |node|
          {
            sequence: node.at("Seq-Number").content,
            text: node.at("Text").content,
          }
        }.reject { |node| node[:text].nil? || node[:text].empty? }
      end

      def key_recommendations_efficiency
        extract_aci_recommendations(
          @xml_doc.search(
            "ACI-Key-Recommendations/Sub-System-Efficiency-Capacity-Cooling-Loads/ACI-Recommendation",
          ),
        )
      end

      def key_recommendations_maintenance
        extract_aci_recommendations(
          @xml_doc.search(
            "ACI-Key-Recommendations/Improvement-Options/ACI-Recommendation",
          ),
        )
      end

      def key_recommendations_control
        extract_aci_recommendations(
          @xml_doc.search(
            "ACI-Key-Recommendations/Alternative-Solutions/ACI-Recommendation",
          ),
        )
      end

      def key_recommendations_management
        extract_aci_recommendations(
          @xml_doc.search(
            "ACI-Key-Recommendations/Other-Recommendations/ACI-Recommendation",
          ),
        )
      end

      def sub_systems
        @xml_doc
          .search("ACI-Sub-Systems/ACI-Sub-System")
          .map do |node|
            {
              volume_definitions:
                node.at("Sub-System-Volume-Definitions")&.content,
              id: node.at("Sub-System-ID")&.content,
              description: node.at("Sub-System-Description")&.content,
              cooling_output: node.at("Sub-System-Cooling-Output")&.content,
              area_served:
                node.at("Sub-System-Area-Served-Description")&.content,
              inspection_date: node.at("Sub-System-Inspection-Date")&.content,
              cooling_plant_count:
                node.at("Sub-System-Cooling-Plant-Count")&.content,
              ahu_count: node.at("Sub-System-AHU-Count")&.content,
              terminal_units_count:
                node.at("Sub-System-Terminal-Units-Count")&.content,
              controls_count: node.at("Sub-System-Controls-Count")&.content,
            }
          end
      end

      def cooling_plants
        extraction_helper = Helper::AcReportExtraction.new

        @xml_doc
          .search("Air-Conditioning-Inspection-Report/ACI-Cooling-Plant")
          .map { |node| extraction_helper.cooling_plant(node) }
      end

      def checklist_values(checklist)
        results =
          checklist&.element_children&.map { |node|
            checklist_item = node.name.underscore.to_sym
            value = node.content == "Yes"
            { checklist_item => value }
          }&.inject(&:merge)

        results.nil? ? {} : results
      end

      def pre_inspection_checklist
        {
          essential:
            checklist_values(
              @xml_doc.at(
                "ACI-Pre-Inspection-Information/ACI-Pre-Inspection-Essential",
              ),
            ),
          desirable:
            checklist_values(
              @xml_doc.at(
                "ACI-Pre-Inspection-Information/ACI-Pre-Inspection-Desirable",
              ),
            ),
          optional:
            checklist_values(
              @xml_doc.at(
                "ACI-Pre-Inspection-Information/ACI-Pre-Inspection-Optional",
              ),
            ),
        }
      end

      def related_rrn
        xpath(%w[Related-RRN])
      end

      def extract_inspection_item(node)
        inspection_item = {
          note: node&.at("Note")&.content,
          recommendations:
            if node.respond_to?(:search)
              extract_aci_recommendations(node.search("ACI-Recommendation"))
            else
              []
            end,
        }

        if node.respond_to?(:at) && node.at("Flag")
          inspection_item[:flag] = node.at("Flag").content == "Yes"
        end

        inspection_item
      end

      def air_handling_systems
        @xml_doc
          .search("ACI-Air-Handling-System")
          .map do |node|
            {
              equipment: {
                unit: node.at("System-Number")&.content,
                component: node.at("System-Component-Identifier")&.content,
                systems_served:
                  node.at("ACI-Air-Handling-System-Equipment/Systems-Served")
                    &.content,
                manufacturer:
                  node.at("ACI-Air-Handling-System-Equipment/Manufacturer")
                    &.content,
                year_installed:
                  node.at("ACI-Air-Handling-System-Equipment/Year-Installed")
                    &.content,
                location:
                  node.at("ACI-Air-Handling-System-Equipment/Location")
                    &.content,
                areas_served:
                  node.at("ACI-Air-Handling-System-Equipment/Area-Served")
                    &.content,
                discrepancy:
                  node.at("ACI-Air-Handling-System-Equipment/Discrepancy-Note")
                    &.content,
              },
              inspection: {
                filters: {
                  filter_condition:
                    extract_inspection_item(node.at("Filter-Condition-OK")),
                  change_frequency:
                    extract_inspection_item(
                      node.at("Filter-Change-Frequency-OK"),
                    ),
                  differential_pressure_gauge:
                    extract_inspection_item(
                      node.at("Differential-Pressure-Gauge-OK"),
                    ),
                },
                heat_exchangers: {
                  condition:
                    extract_inspection_item(node.at("Heat-Exchangers-OK")),
                },
                refrigeration: {
                  leaks: extract_inspection_item(node.at("Refrigeration-Leak")),
                },
                fan_rotation: {
                  direction:
                    extract_inspection_item(node.at("Fan-Rotation-OK")),
                  modulation:
                    extract_inspection_item(node.at("Fan-Modulation-OK")),
                },
                fan_control: {
                  setting:
                    extract_inspection_item(node.at("Fan-Control-Setting")),
                },
                heat_recovery: {
                  energy_conservation:
                    extract_inspection_item(
                      node.at("Energy-Conservation-Features"),
                    ),
                },
                air_leakage: {
                  condition: extract_inspection_item(node.at("Air-Leakage")),
                },
                outdoor_inlets: {
                  condition:
                    extract_inspection_item(node.at("Outdoor-Air-Inlets")),
                },
                fan_power: {
                  condition: extract_inspection_item(node.at("Fan-Power-OK")),
                  sfp_calculation: xpath(%w[SFP-Calculation], node),
                },
              },
            }
          end
      end

      def terminal_units
        @xml_doc
          .search("ACI-Terminal-Unit")
          .map do |node|
            {
              equipment: {
                unit: node.at("System-Number")&.content,
                component: node.at("System-Component-Identifier")&.content,
                description: node.at("System-Identifier")&.content,
                cooling_plant: node.at("Systems-Served")&.content,
                manufacturer: node.at("Manufacturer")&.content,
                year_installed: node.at("Year-Installed")&.content,
                area_served: node.at("Area-Served")&.content,
                discrepancy: node.at("Discrepancy-Note")&.content,
              },
              inspection: {
                insulation: {
                  pipework:
                    extract_inspection_item(node.at("Pipe-Insulation-OK")),
                  ductwork:
                    extract_inspection_item(node.at("Ductwork-Insulated-OK")),
                },
                unit: {
                  condition:
                    extract_inspection_item(node.at("Unit-Condition-OK")),
                },
                grilles_air_flow: {
                  distribution:
                    extract_inspection_item(
                      node.at("Air-Flow-Distribution-OK"),
                    ),
                  tampering:
                    extract_inspection_item(
                      node.at("Air-Flow-Tampering-Issues"),
                    ),
                  water_supply:
                    extract_inspection_item(node.at("Water-Supply-OK")),
                  complaints:
                    extract_inspection_item(node.at("Air-Flow-Issues")),
                },
                diffuser_positions: {
                  position_issues:
                    extract_inspection_item(
                      node.at("Diffuser-Positions-Issues"),
                    ),
                  partitioning_issues:
                    extract_inspection_item(node.at("Partitioning-Issues")),
                  control_operation:
                    extract_inspection_item(node.at("Control-Operation-OK")),
                },
              },
            }
          end
      end

      def system_controls
        @xml_doc
          .search("ACI-System-Control")
          .map do |node|
            {
              sub_system_id: xpath(%w[Sub-System-ID], node),
              component: xpath(%w[System-Component-Identifier], node),
              inspection: {
                zoning: extract_inspection_item(node.at("Zoning-Assessment")),
                time:
                  extract_inspection_item(node.at("Current-Indicated-Time")),
                set_on_period:
                  extract_inspection_item(node.at("Set-On-Period")),
                timer_shortfall:
                  extract_inspection_item(node.at("Timer-Shortfall")),
                sensors:
                  extract_inspection_item(node.at("Sensors-Appropriate")),
                set_temperature:
                  extract_inspection_item(node.at("Set-Temperature")),
                dead_band: extract_inspection_item(node.at("Dead-Band-Set")),
                capacity:
                  extract_inspection_item(node.at("Equipment-Capacity")),
                airflow: extract_inspection_item(node.at("Airflow-Modulation")),
                guidance_controls:
                  extract_inspection_item(node.at("Use-Guidance-Or-Controls")),
              },
            }
          end
      end
    end
  end
end
