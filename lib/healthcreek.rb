require 'csv'

module HealthCreek
    module Data
        module SNOMEDCT
            def load_snomed_concepts(file)
                puts "Loading SNOMEDCT concepts from #{file} ..."
				created = 0
				updated = 0
                CSV.read(file, headers: :first_row, return_headers: false, col_sep: "\t").each do |r|
                    c = SnomedctConcept.where(snomedct_id: r[0]).first
                    if c
                        c.update(
                            effective_time: Date.parse(r[1]),
                            active: r[2],
                            module_id: r[3],
                            definition_status_id: r[4]
                        )
                        updated += 1
                    else
                        c = SnomedctConcept.create(
                            snomedct_id: r[0],
                            effective_time: Date.parse(r[1]),
                            active: r[2],
                            module_id: r[3],
                            definition_status_id: r[4]
                        )
                        created += 1
                    end
                end
                puts "\tCreated #{created} concepts."
                puts "\tUpdated #{updated} concepts."
            end

            def load_snomed_descriptions(file)
                puts "Loading SNOMEDCT descriptions from #{file} ..."
				created = 0
				updated = 0
                CSV.read(file, headers: :first_row, return_headers: false, col_sep: "\t", quote_char: "Ƃ").each do |r|
                    c = SnomedctConcept.where(snomedct_id: r[4]).first
                    d = SnomedctDescription.where(snomedct_id: r[4]).first
                    if d
                        d.update
                        updated += 1
                    else
                        d = SnomedctDescription.create(
                            snomedct_concept: c,
                            snomedct_id: r[0],
                            effective_time: Date.parse(r[1]),
                            active: r[2],
                            module_id: r[3],
                            concept_id: r[4],
                            language_code: r[5],
                            type_id: r[6],
                            term: r[7],
                            case_significance_id: r[8]
                        )
                        created += 1
                              end
                end
				puts "\tCreated #{created} descriptions."
				puts "\tUpdated #{updated} descriptions."

          end

            def load_snomed(dir)
                terms = File.join(dir, 'Full', 'Terminology')
                concepts = File.join(terms, '*Concept_Full*')
                Dir.glob(concepts) do |file|
                    # load_snomed_concepts file
                end

                descriptions = File.join(terms, '*Description_Full*')
                Dir.glob(descriptions) do |file|
                    load_snomed_descriptions file
                end
            end
        end
    end
end
