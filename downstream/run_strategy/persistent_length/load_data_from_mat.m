function data = load_data_from_mat(full_path)

loaded_data = load(full_path);
data = loaded_data.(char(fieldnames(loaded_data)));

end