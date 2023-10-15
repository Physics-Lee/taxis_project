function variable_within_struct = load_struct(full_path)
% only suitable for struct with 1 variable

loaded_data = load(full_path);
variable_within_struct = loaded_data.(char(fieldnames(loaded_data)));

end