require 'YAML'
require 'JSON'

STANDARD_RACES = %w(Dwarf Elf Human Orc Goblin Halfling Half-elf Half-orc)
CHARACTER_CLASSES = %w(Bard Barbarian Champion Cleric Druid Fighter Monk Ranger Rogue Sorcerer Wizard)

PATH_TO_FILE = "#{__dir__}/../data/data_feats.yaml"
feats = YAML.load(File.read(PATH_TO_FILE))

feats_by_identifier = {}
identifier = 1
feats['feat'].each do |feat|
  feat['identifier'] = identifier
  identifier += 1
  feats_by_identifier[identifier] = feat
end


ancestry_feats = feats['feat'].select do |feat|
  (feat['prereqs'] || []).any? do |prereq|
    STANDARD_RACES.include?(prereq['descr']) ||
      prereq['descr'].start_with?('Ancestry')
  end
end

grouped_ancestry_feats = {}
STANDARD_RACES.each do |ancestry|
  grouped_ancestry_feats[ancestry] = ancestry_feats.select do |feat|
    next true if feat['prereqs'] && feat['prereqs'][0] == ancestry
    next true if feat['traits'] && feat['traits'][0] == ancestry
    false
  end.map { |feat| feat['identifier']}
end

class_feats = {}
CHARACTER_CLASSES.each do |character_class|
  class_feats[character_class] = feats['feat'].select do |feat|
    next false unless feat['traits']
    next true if feat['traits'].any? { |trait| trait == character_class }
    false
  end.map { |feat| feat['identifier']}
end

general_feats = feats['feat'].select do |feat|
  next false unless feat['traits']
  next true if feat['traits'].any? { |trait| trait == 'General' }
  false
end.map { |feat| feat['identifier']}

skill_feats = feats['feat'].select do |feat|
  next false unless feat['traits']
  next true if feat['traits'].any? { |trait| trait == 'Skill' }
  false
end.map { |feat| feat['identifier']}

json_data = "const featsByIdentifier = #{feats_by_identifier.to_json};"\
            "const ancestryFeats = #{grouped_ancestry_feats.to_json};"\
            "const classFeats = #{class_feats.to_json};"\
            "const generalFeats = #{general_feats.to_json};"\
            "const skillFeats = #{skill_feats.to_json};"\

puts json_data