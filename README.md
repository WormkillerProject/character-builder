# character-builder

Step by step Character builder with guidance

# data & scripts

The data folder contains a copy of https://gitlab.com/jrmiller82/pathfinder-2-sqlite/-/blob/master/data/feats.yaml . The scripts folder contains a ruby script that will parse the `yaml` file and output a few `const` variables to access the data in a structured way in JSON. it will

- Add a numerical identifier to each feat and dump an object with `const featsByIdentifier = {1: feat, 2: anotherFeat ...}`
- Sort all ancestry feats into a hash by ancestries `const ancestryFeats = {Dwarf: [3,4,5], Elf: [12,14,15] ...}`
- Sort all class feats into a hash by class `const classFeats = {Bard: [56,57,58,58...], Wizard: [155, 156, 157...] ...}`
- Dump all general feats into an array `const generalFeats = [455,456,457...]`
- Dump all skill feats into an array `const skillFeats = [566,567,568...]`